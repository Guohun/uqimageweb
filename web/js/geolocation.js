
var map, heatmap;
var popUp;
var marker_list = [];
var location_list = [];
var MAPAPI = "function/location.jsp";
var locations = new Array();
var URL = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
var data_size = 100;


function map_initialize() {


// Create the Google Map…
  map = new google.maps.Map(d3.select(".map-canvas").node(), {
    zoom: 14,
    center: new google.maps.LatLng(-27.497013553727715, 153.00656765699387),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  });


  google.maps.event.addListener(map, 'idle', function () {
    if (typeof popUp != 'undefined' && !popUp.closed) {
      popUp.$('#map-canvas').trigger("parent_move", {"zoom": map.getZoom(), "center": map.getCenter()});
    }
    sendPoints(data_size);
  });
}

function sendPoints(size) {

  var bounds = map.getBounds();
  var ne = bounds.getNorthEast();
  var sw = bounds.getSouthWest();

  var data = {"x1": ne.lat(), "x2": sw.lat(), "y1": ne.lng(), "y2": sw.lng(), "numOfResult": size};

  $(window).trigger("location_move", data);
  
  $.get(MAPAPI, data)
          .done(function (data) {
            var new_data = "name,lat,log\n" + data.trim();
            var csv = d3.csv.parse(new_data);
            drawMap(csv);
          });
}

function drawMap(_json) {
  clear();
  var showMarker = (map.getZoom() >= 14);
  for (var i = 0; i < _json.length; i++) {
    if (typeof _json[i].lat == 'undefined' || typeof _json[i].log == 'undefined') {
      continue;
    }
    var loc = new google.maps.LatLng(_json[i].lat, _json[i].log);
    if (showMarker) {
      var marker = new google.maps.Marker({
        icon: URL,
        position: loc,
        title: _json[i].name,
        map: map
      });

      google.maps.event.addListener(marker, 'click', function () {
        // showByTweet(this.getTitle())
                //  document.getElementById('sout').innerHTML = s.innerHTML;       
             var tempStr=this.getTitle();
             tempStr.replace("'","");
//             alert(tempStr);
         window.open("function/showGeoUsers.jsp?userName="+tempStr,"_blank","toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500,  width=800, height=600" );
      });

      marker_list.push(marker);
    } else {
      location_list.push(loc);
    }
  }

  if (showMarker == false) {
    //var pointArray = new google.maps.MVCArray(location_list);
    heatmap = new google.maps.visualization.HeatmapLayer({
      data: location_list
    });
    heatmap.setMap(map);
  }
}

function clear() {
  for (var i = 0; i < marker_list.length; i++) {
    marker_list[i].setMap(null);
  }
  if (typeof heatmap != 'undefined') {
    heatmap.setMap(null);
  }
  marker_list = [];
  location_list = [];
}

function popMap() {
  if (typeof popUp == 'undefined' || popUp.closed) {
    popUp = window.open("http://uqimage.uqcloud.net/bigMap.php", "mywindow1", "status=1,width=1080px,height=1000px");
    //popUp = window.open("http://uqimage.uqcloud.net/bigMap.php");
    $(popUp.document).ready(function () {
      popUp.window.parentCenter = map.getCenter();
      popUp.window.parentZoom = map.getZoom();
    });

    $('#map-canvas').on("child_move", function (event, data) {

      map.setZoom(data.zoom);
      map.setCenter({lat: data.center.G, lng: data.center.K});
    });
  }

}


$(document).ready(function () {



  $('#myTabs a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  });

  $(".size-button").click(function (e) {
    var size = parseInt($(this).text());
    data_size = size;
    sendPoints(size);
  });


  $(".type-button").click(function (e) {
    e.stopPropagation();
    var type = $(this).text();
    sendPoints(size);
  });
});


