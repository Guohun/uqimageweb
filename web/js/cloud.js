var graph = null;



function NetworkFunction(width, height) {



//d3.json("miserables.json", function(error, graph) {









    $(window).on("location_move", function (event, result) {
        var x1=result.x1;
        var y1=result.y1;
        var x2=result.x2;
        var y2=result.y2;
        
        var SURL= "function/network.jsp?x1="+x1+"&y1="+y1+"&x2="+x2+"&y2="+y2;
        
                
        $(".mynetworks").empty();
        var svg = d3.select(".mynetworks")
                .attr("width", width)
                .attr("height", height);

        var color = d3.scale.category20();

        var force = d3.layout.force()
                .charge(-60)
                .linkDistance(10)
                .linkStrength(1)
                .size([width, height]);

        
        d3.json(SURL, function (error, graph) {

    //        alert(graph);
            
            force
                    .nodes(graph.nodes)
                    .links(graph.links)
                    .start();

            var link = svg.selectAll(".networklink")
                    .data(graph.links)
                    .enter().append("line")
                    .attr("class", "networklink")
                    .style("stroke-width", function (d) {
                        return Math.sqrt(d.value);
                    });


            var node = svg.selectAll(".networknode")
                    .data(graph.nodes)
                    .enter().append("circle")
                    .attr("class", "networknode")
                    .attr("r", 8)
                    .attr("name", function (d) {
                        return d.name;
                    })
                    .style("fill", function (d) {
                        return color(d.group);
                    })
                    .on('click', function () {
                        window.open("http://twitter.com/" + d3.select(this).attr("name"), "User Profile", "left=300, top=200, width=600, height=500");
                        d3.event.stopPropagation();
                    })
                    .call(force.drag);



            node.append("title")
                    .text(function (d) {
                        return d.name;
                    });

            force.on("tick", function () {
                link.attr("x1", function (d) {
                    return d.source.x;
                })
                        .attr("y1", function (d) {
                            return d.source.y;
                        })
                        .attr("x2", function (d) {
                            return d.target.x;
                        })
                        .attr("y2", function (d) {
                            return d.target.y;
                        });

                node.attr("cx", function (d) {
                    return d.x;
                })
                        .attr("cy", function (d) {
                            return d.y;
                        });
            });
        });
    });

}