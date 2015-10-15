var RankURL = "function/rank.jsp";


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


function DrawRankChart(width, height) {



    //var barData = [{ 'sentiment':'P', 'name':'cognition', 'value':0}, {'sentiment':'P', 'name':'food', 'value':0}, {'sentiment':'P', 'name':'time', 'value':1}, {'sentiment':'P', 'name':'person', 'value':1}, {'sentiment':'P', 'name':'QLD', 'value':0}, {'sentiment':'P', 'name':'motion', 'value':0}, {'sentiment':'P', 'name':'artifact', 'value':0}, {'sentiment':'P', 'name':'cognition', 'value':0}, {'sentiment':'P', 'name':'food', 'value':0}, {'sentiment':'P', 'name':'time', 'value':1}, {'sentiment':'P', 'name':'person', 'value':1}, {'sentiment':'P', 'name':'QLD', 'value':0}, {'sentiment':'P', 'name':'motion', 'value':0}, {'sentiment':'P', 'name':'artifact', 'value':0}];
//                xRange = d3.scale.ordinal().rangeRoundBands([MARGINS.left, WIDTH - MARGINS.right], 0.1).domain(barData.map(function (d) {
    //                  return d.name;
    //            })),


    $(window).on("location_move", function (event, result) {

  
        //d3.json("function/rank.jsp", function (barData) 
        //d3.json("function/rank.jsp", function(err, data){

        $.get(RankURL, result)
                .done(function (data) {

                    var barData = d3.csv.parse(data.trim());

                    $(".rankloading").empty();
                    var vis = d3.select('.rankloading')
                              .attr("width", width)
                              .attr("height", height);
                    
                               
                              var WIDTH = width;
                              var HEIGHT = height;
                  var             MARGINS = {
                                  top: 40,
                                  right: 10,
                                  bottom: 20,
                                  left: 30
                              };

                        
                        
                    yRange = d3.scale.linear().range([HEIGHT - MARGINS.top, 0]).domain([0,
                        d3.max(barData, function (d) {
                            return d.value;
                        })
                    ]);

                    //Set X Scale
                    var xScale = d3.scale.ordinal().rangeRoundBands([MARGINS.left, WIDTH - MARGINS.right], 0.1, 0.3);

                    xRange = xScale.domain(barData.map(function (d) {
                        return d.name;
                    }));


                    var xAxis = d3.svg.axis()
                            .scale(xRange)
                            .orient("bottom")
                            .tickSize(0)
                            .tickPadding(2);
//                    xAxis = d3.svg.axis()
                    //                          .scale(xRange)
//                .tickSize(5)
                    //                        .tickSubdivide(true),
                    var yAxis = d3.svg.axis()
                            .scale(yRange)
                            .tickSize(5)
                            .orient("left")
                            .tickSubdivide(true);


                    vis.append('svg:g')
                            .attr('class', 'x axis')
                            .attr('transform', 'translate(0,' + (HEIGHT - MARGINS.bottom) + ')')
                            .call(xAxis);

                    vis.append('svg:g')
                            .attr('class', 'y axis')
                            .attr('transform', 'translate(' + (MARGINS.left) + ',0)')
                            .call(yAxis);

                    vis.selectAll('.bar')
                            .data(barData)
                            .enter()
                            .append('rect')
                            .attr('x', function (d) {
                                return xRange(d.name);
                            })
                            .attr('y', function (d) {
                                return yRange(d.value);
                            })
                            .attr('width', xRange.rangeBand())
                            .attr('height', function (d) {
                                return ((HEIGHT - MARGINS.bottom) - yRange(d.value));
                            })
                            .attr('fill', function (d) {
                                return  getColor(d.sentiment);
                            })
                            .on('mouseover', function (d) {
                                d3.select(this)
                                        .attr('fill', 'blue');
                            })
                            .on('click', function (d) {

                                window.open("function/Topic_Key.jsp?word=" + d.name, "", "left=200, top=200, width=1000, height=500");
                            })

                            .on('mouseout', function (d) {
                                d3.select(this)
                                        .attr('fill', getColor(d.sentiment));
                            });
                });
    });
}
