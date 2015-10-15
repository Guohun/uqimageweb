var Eventchart = null;
var allText = null;


function DrawEventChart(width, height) {
    google.load('visualization', '1', {packages: ['timeline']});
    //      google.load("visualization", "1", {packages:["motionchart"]});
    // google.load("visualization", "1");
    

    $(window).on("location_move", function (event, result) {
        
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            //var query = new google.visualization.Query('json/crunchbase-quarters.csv',
            var x1 = result.x1;
            var y1 = result.y1;
            var x2 = result.x2;
            var y2 = result.y2;
            var SURL = "function/rankEvent.jsp?x1=" + x1 + "&y1=" + y1 + "&x2=" + x2 + "&y2=" + y2;
            
            var query = new google.visualization.Query(SURL,
                    //                var query = new google.visualization.Query('json/crunchbase-quarters.csv',
                            {csvColumns: ['string', 'string', 'number', 'number', 'number', 'number', 'number', 'number', 'number', 'number', 'number', 'number', 'string', 'string'], csvHasHeader: true});
                    query.send(handleQueryResponse);
                    /*                $(document).ready(function () {
                     $.ajax({
                     type: "GET",
                     url: "json/crunchbase-quarters.csv",
                     dataType: "text",
                     success: function (data) {
                     handleQueryResponse(data);
                     }
                     });
                     });
                     */
                }
                
                
    });
    function handleQueryResponse(response) {
        if (response.isError()) {
            alert('Error in query: ' + response.getMessage() + ' ' +
                    response.getDetailedMessage());
            return;
        }
        allText = response.getDataTable();
        //alert()
        //alert(allText.getNumberOfColumns())
        var Eventdata = null;
        Eventdata = new google.visualization.DataTable();
        Eventdata.addColumn({type: 'string', id: 'Room'});
        Eventdata.addColumn({type: 'string', id: 'Name'});
        Eventdata.addColumn({type: 'string', role: 'tooltip'});
        Eventdata.addColumn({type: 'date', id: 'Start'});
        Eventdata.addColumn({type: 'date', id: 'End'});
        // Add empty rows
        Eventdata.addRows(allText.getNumberOfRows());
        var colorArray = [];
        for (i = 0; i < allText.getNumberOfRows(); i++) {
            Eventdata.setCell(i, 0, allText.getValue(i, 0));
            Eventdata.setCell(i, 1, allText.getValue(i, 1));
            Eventdata.setCell(i, 2, allText.getValue(i, 13));
            Eventdata.setCell(i, 3, new Date(allText.getValue(i, 2), allText.getValue(i, 3), allText.getValue(i, 4), allText.getValue(i, 5), allText.getValue(i, 6)));
            Eventdata.setCell(i, 4, new Date(allText.getValue(i, 7), allText.getValue(i, 8), allText.getValue(i, 9), allText.getValue(i, 10), allText.getValue(i, 11)));
            var tempStr = allText.getValue(i, 12);
            if (tempStr.charAt(0) == 'P')
                colorArray[i] = '#0000FF';
            else if (tempStr.charAt(0) == 'N')
                colorArray[i] = '#FF0000';
            else
                colorArray[i] = '#cccccc';
            //          alert(colorArray[i]);
        }
//alert(allText);


        var options = {
            height: height,
            timeline: {
                groupByRowLabel: true
            },
            hAxis: {
                format: 'M/d/yy HH:mm a Z',
                //                gridlines: {count: 20}
            },
            vAxis: {
                //                gridlines: {color: 'none'},
                minValue: 0
            },
            colors: colorArray
        };
        var container = document.getElementById('series_chart_div');
        Eventchart = null;
        Eventchart = new google.visualization.Timeline(container);
        //Eventchart = new links.Timeline(document.getElementById('series_chart_div'), options1);

        //          var chart = new google.visualization.MotionChart(container);
        function selectHandler() {
            var selectedItem = Eventchart.getSelection()[0];
            if (selectedItem) {
                var topping = allText.getValue(selectedItem.row, 0);
                var EventName = allText.getValue(selectedItem.row, 1);
                //alert('The user selected facebook' + topping);
                //window.open("https://www.facebook.com/" + topping);
                //window.open("https://www.facebook.com/" + topping);
                window.open("function/showEventTopics.jsp?word=" + topping +"&eventName="+ encodeURIComponent(EventName), "", "left=200, top=200, width=1000, height=500");
                
                //d3.event.stopPropagation();

            }
        }

        google.visualization.events.addListener(Eventchart, 'select', selectHandler);
        Eventchart.draw(Eventdata, options);
        //Eventchart.draw(Eventdata);
        //  Eventchart.setSelection([{row:0,column:1},{row:1, column:null},{row:2, column:null}])
        // Every time the table fires the "select" event, it should call your
        // selectHandler() function.



    }




}

