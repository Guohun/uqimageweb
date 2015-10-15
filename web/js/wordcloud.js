var wordCloudURL = "function/mywordcloud.jsp";

function tpu(s) {
    //  document.getElementById('sout').innerHTML = s.innerHTML;       
    window.open("function/keyword.jsp?word=" + s.innerHTML, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500,  width=800, height=600");
    return false;
}

function getColor(sentiment) {
    if (sentiment == 'N') {
        return "red";
    } else if (sentiment == 'P') {
        return "green";
    } else {
        return "black";
    }
}





//d3.text(RankURL, function (unparsedData) {
//  barData1 = d3.csv.parseRows(unparsedData);

//});


//    barData=barData1;


function DrawWordCloudChart(width, height) {



    //var barData = [{ 'sentiment':'P', 'name':'cognition', 'value':0}, {'sentiment':'P', 'name':'food', 'value':0}, {'sentiment':'P', 'name':'time', 'value':1}, {'sentiment':'P', 'name':'person', 'value':1}, {'sentiment':'P', 'name':'QLD', 'value':0}, {'sentiment':'P', 'name':'motion', 'value':0}, {'sentiment':'P', 'name':'artifact', 'value':0}, {'sentiment':'P', 'name':'cognition', 'value':0}, {'sentiment':'P', 'name':'food', 'value':0}, {'sentiment':'P', 'name':'time', 'value':1}, {'sentiment':'P', 'name':'person', 'value':1}, {'sentiment':'P', 'name':'QLD', 'value':0}, {'sentiment':'P', 'name':'motion', 'value':0}, {'sentiment':'P', 'name':'artifact', 'value':0}];
//                xRange = d3.scale.ordinal().rangeRoundBands([MARGINS.left, WIDTH - MARGINS.right], 0.1).domain(barData.map(function (d) {
    //                  return d.name;
    //            })),


    $(window).on("location_move", function (event, result) {


        //d3.json("function/rank.jsp", function (barData) 
        //d3.json("function/rank.jsp", function(err, data){
        
        $.get(wordCloudURL, result)
                .done(function (data) {

                    var barData = d3.csv.parse(data.trim());
//                    alert(barData)
                     $("#tags").empty();
                    $("#myCanvas").empty();
                    var vis2 = d3.select('#myCanvas')
                            .attr("width", width)
                            .attr("height", height);



                    var vis = d3.select('#tags');


                    var items = vis.append("ul")
                            .attr("class", "weighted")
                            .selectAll("li")
                            .data(barData)
                            .enter()

                            .append("li")

                            .html(function (d) {
                                return "<a style= ' font-size:" + d.weight + "; " + d.color
                                        + "' href='#' onclick='return tpu(this)' >" + d.token + "</a> " + d.token
                            });

                    TagCanvas.Start('myCanvas', 'tags', {
                        textFont: null,
                        textColour: null,
                        outlineColour: '#ff00ff',
                        reverse: true,
                        weight: true,
                        depth: 0.8,
                        maxSpeed: 0.05
                    });

                });
    });
}
