var RankURL = "function/rank.jsp";
function getColor(sentiment) {
	if(sentiment == "N") {
		return "red";
	} else if(sentiment == "P") {
		return "green";
	} else {
		return "black";
	}
}

function DrawRankChart() {
	
	$(window).on("location_move",function(event,result){
			result.lim = 5;
			$("#rank").html("");
			$("#rankloading").show();
		  	$.get(RankURL, result)
  	 			.done(function( data ) {
					var new_data = "sentiment,text,size\n" + data.trim();
					var csv = d3.csv.parse(new_data);
					var googleData = [["School", "Rate", { role: "style" } ]];
					if(csv.length > 0) {
						for(var i in csv) {
							var dataItem = csv[i];
							googleData.push([dataItem.text,parseFloat(dataItem.size),getColor(dataItem.sentiment)]);
						}
						var data2 = google.visualization.arrayToDataTable(googleData);
						var view = new google.visualization.DataView(data2);
						view.setColumns([0, 1,
									   { calc: "stringify",
										 sourceColumn: 1,
										 type: "string",
										 role: "annotation" },
									   2]);

						var options = {
							title: "Topic Rank",
							height: document.getElementById('rank').clientHeight,
							width: document.getElementById('rank').clientWidth,
							bar: {groupWidth: "95%"},
							legend: { position: "none" },
						};
						var chart = new google.visualization.ColumnChart(document.getElementById("rank"));
						$("#rankloading").hide();
						google.visualization.events.addListener(chart, 'select', selectHandler);
						chart.draw(view, options);
						
						
						function selectHandler() {
							var selectedItem = chart.getSelection()[0];
							  if (selectedItem) {
								var topping = view.getValue(selectedItem.row, 0);
								window.open("/function/Topic_Key.jsp?word=" + topping, "", "left=200, top=200, width=1000, height=500");
							  }
						}
					}
					
			});
	});

  
}
