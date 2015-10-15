//$(document).ready(function () {
function TreeFunction(width,height) {
    
    var margin = {top: 20, right: 10, bottom: 20, left: 10};
//    width = $(".wordtree_basic").width() - margin.right - margin.left,
  //          height = $(".wordtree_basic").height() - margin.top - margin.bottom;


    var i = 0,
            duration = 750,
            root;

    var tree = d3.layout.tree()
            .size([height, width]);

    var diagonal = d3.svg.diagonal()
            .projection(function (d) {
                return [d.y, d.x];
            });

    var svg = d3.select(".wordtree_basic").append("svg")
            .attr("width", width + margin.right + margin.left)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


// alert(width);
    //alert(height);
//json/tree.json
    d3.json("showtopicstrees", function (error, flare) {
      //  alert(flare);

        if (error)
            throw error;




        root = flare;
        root.x0 = height / 2;
        root.y0 = 0;

        function collapse(d) {
            if (d.children) {
                d._children = d.children;
                d._children.forEach(collapse);
                d.children = null;
            }
        }

        root.children.forEach(collapse);
        update(root);


        $("#contentloading").hide();

    });

    d3.select(self.frameElement).style("height", "800px");

    function update(source) {

        // Compute the new tree layout.
        var nodes = tree.nodes(root).reverse(),
                links = tree.links(nodes);

        // Normalize for fixed-depth.
        nodes.forEach(function (d) {
            d.y = d.depth * width / 8;
        });

        // Update the nodes…
        var node = svg.selectAll("g.TopicHernode")
                .attr("class", "TopicHernode")
                .data(nodes, function (d) {
                    return d.id || (d.id = ++i);
                });
                

        // Enter any new nodes at the parent's previous position.
        var nodeEnter = node.enter().append("g")
                .attr("class", "TopicHernode")
                .attr("transform", function (d) {
                    return "translate(" + source.y0 + "," + source.x0 + ")";
                })                
                .on("click", click);

        nodeEnter.append("circle")
                .attr("r", 1e-6)
                .style("fill", function (d) {
                    return d._children ? "lightsteelblue" : "#fff";
                });

        nodeEnter.append("text")
                .attr("x", function (d) {
                    return d.children || d._children ? -10 :10;
                })
                .attr("dy", ".35em")
                .attr("text-anchor", function (d) {
                    return d.children || d._children ? "end" : "start";
                })
                .text(function (d) {
                    return d.name;
                })
                .style("fill-opacity", 1e-6);

        // Transition nodes to their new position.
        var nodeUpdate = node.transition()
                .duration(duration)
                .attr("transform", function (d) {
                    return "translate(" + d.y + "," + d.x + ")";
                });

        nodeUpdate.select("circle")
                .attr("r", function (d) {
                    return d.Weight;
                })
                .style("fill", function (d) {
                    return d._children ? "lightsteelblue" : "#fff";
                });

        nodeUpdate.select("text")
                .style("fill-opacity", 1)
                .text(function(d) {
                return d.name;
            });
        // Transition exiting nodes to the parent's new position.
        var nodeExit = node.exit().transition()
                .duration(duration)
                .attr("transform", function (d) {
                    return "translate(" + source.y + "," + source.x + ")";
                })
                .remove();

        nodeExit.select("circle")
                .attr("r", 1e-6);

        nodeExit.select("text")
                .style("fill-opacity", 1e-6);

        // Update the links…
        var link = svg.selectAll("path.ranklink")
                .data(links, function (d) {
                    return d.target.id;
                });

        // Enter any new links at the parent's previous position.
        link.enter().insert("path", "g")
                .attr("class", "ranklink")
                .attr("d", function (d) {
                    var o = {x: source.x0, y: source.y0};
                    return diagonal({source: o, target: o});
                });

        // Transition links to their new position.
        link.transition()
                .duration(duration)
                .attr("d", diagonal);

        // Transition exiting nodes to the parent's new position.
        link.exit().transition()
                .duration(duration)
                .attr("d", function (d) {
                    var o = {x: source.x, y: source.y};
                    return diagonal({source: o, target: o});
                })
                .remove();

        // Stash the old positions for transition.
        nodes.forEach(function (d) {
            d.x0 = d.x;
            d.y0 = d.y;
        });
    }

    function checkEmpty(child) {
        return child == null || typeof child == 'undefined';
    }

// Toggle children on click.
    function click(d) {


        if (d.children) {
            d._children = d.children;
            d.children = null;
        } else {
            d.children = d._children;
            d._children = null;
        }

        if (checkEmpty(d.children) && checkEmpty(d._children)) {
            var currentParent = d.parent;
            var keyname="";
            var labels =""; //d.name+":"+d.Opion;           
            keyname=d.name;
            if (d.tw_List<'undefined') labels =d.tw_List;
            while (typeof currentParent != 'undefined') {
                if (currentParent.tw_List<'undefined') labels+=' '+currentParent.tw_List;                
                //labels += ("," + currentParent.name+":"+currentParent.Opion);
                currentParent = currentParent.parent;
            }
            
            
            //alert(labels);
            window.open("function/Topic_Key.jsp?keyname="+keyname+"&word=" + labels);
        } else {
            update(d);
        }



    }
}
//});

