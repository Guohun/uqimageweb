
  // create sample dataset
  var sample_data = [
    {"name": "alpha", "size": 10},
    {"name": "beta", "size": 12},
    {"name": "gamma", "size": 30},
    {"name": "delta", "size": 26},
    {"name": "epsilon", "size": 12},
    {"name": "zeta", "size": 26},
    {"name": "theta", "size": 11},
    {"name": "eta", "size": 24}
  ]
  // create list of node positions
  var positions = [
    {"name": "alpha", "x": 10, "y": 15},
    {"name": "beta", "x": 12, "y": 24},
    {"name": "gamma", "x": 16, "y": 18},
    {"name": "delta", "x": 26, "y": 21},
    {"name": "epsilon", "x": 13, "y": 4},
    {"name": "zeta", "x": 31, "y": 13},
    {"name": "theta", "x": 19, "y": 8},
    {"name": "eta", "x": 24, "y": 11}
  ]
  // create list of node connections
  var connections = [
    {"source": "alpha", "target": "beta"},
    {"source": "alpha", "target": "gamma"},
    {"source": "beta", "target": "delta"},
    {"source": "beta", "target": "epsilon"},
    {"source": "zeta", "target": "gamma"},
    {"source": "theta", "target": "gamma"},
    {"source": "eta", "target": "gamma"}
  ]
  // instantiate d3plus
  var visualization = d3plus.viz()
    .container("#network")  // container DIV to hold the visualization
    .type("network")    // visualization type
    .data(sample_data)  // sample dataset to attach to nodes
    .nodes(positions)   // x and y position of nodes
    .edges(connections) // list of node connections
    .size("size")       // key to size the nodes
    .id("name")         // key for which our data is unique on
    .draw()             // finally, draw the visualization!

var networkAPI = "function/network.jsp";

function drawNetwork(id, data) {
	
	var width = document.getElementById(id).clientWidth;
	var height = document.getElementById(id).clientHeight;
	var color = d3.scale.category20();
	var force = d3.layout.force()
    	.linkDistance(5)
    	.linkStrength(2)
    	.size([width - 50, height - 50]);
	var box = d3.select("#" + id);
	$("#networkloading").show();
	$("#networkgraph").remove();
	
	var svg = box.append("svg")
    	.attr("width", width)
    	.attr("height", height)
    	.attr('id','networkgraph');

	$.get(networkAPI, data)
	 .done(function(graph) {
	 	var graph2 = JSON.parse(graph.trim());
		var nodes = graph2.nodes.slice(),
		  links = [],
		  bilinks = [];

		graph2.links.forEach(function(link) {
			var s = nodes[link.source],
				t = nodes[link.target],
				i = {}; // intermediate node
			nodes.push(i);
			links.push({source: s, target: i}, {source: i, target: t});
			bilinks.push([s, i, t]);
		});
		
		$("#networkloading").hide();

		force
		  .nodes(nodes)
		  .links(links)
		  .start();

		var link = svg.selectAll(".link")
		  .data(bilinks)
		.enter().append("path")
		  .attr("class", "link");

		var node = svg.selectAll(".node")
		  .data(graph2.nodes)
		.enter().append("circle")
		  .attr("class", "node")
		  .attr("r", 7)
		  .attr("name", function(d) { return d.name; })
		  .style("fill", function(d) { return color(d.group); })
		  .on('click',function() {
          	window.open("http://twitter.com/" + d3.select(this).attr("name"), "User Profile", "left=300, top=200, width=600, height=500");
          	d3.event.stopPropagation();
          })
		  .call(force.drag);

		node.append("title")
		  .text(function(d) { return d.name; });

		force.on("tick", function() {
			link.attr("d", function(d) {
			  return "M" + d[0].x + "," + d[0].y
				  + "S" + d[1].x + "," + d[1].y
				  + " " + d[2].x + "," + d[2].y;
			});
			node.attr("transform", function(d) {
			  return "translate(" + d.x + "," + d.y + ")";
			});
		});
	});
}

var popUpNewWindow;
var networkparameter;

function popNetwork() {
		if(typeof popUpNewWindow == 'undefined' || popUpNewWindow.closed) {
			popUpNewWindow = window.open("http://uqimage.uqcloud.net/bigNetwork.php","mywindow2", "status=1,width=1080px,height=1000px");
		}
	}

$( document ).ready(function() {

	$(window).on("location_move",function(event,result){
		networkparameter = result;
		drawNetwork("network",result);
	});
	
});
