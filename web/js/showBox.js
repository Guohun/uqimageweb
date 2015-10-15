function showBox() {
	$('#tweetBox').modal('show');
}

function showBigBox() {
	$("#BigBoxModel").modal('show');
}

function showByTweet(tid) {
	$('#tweetBox').off();
	$('#tweetBox').on('show.bs.modal', function (event) {
		var model = $(this);
		var body = $("#tweetBoxcontainer");
		body.html("");
		$("#bigBoxloading").show();
		$.get("/function/tweets.jsp", {"username":tid.substring(1, tid.length - 1), "numOfResult":10})
  	 			.done(function( data ) {
					var new_data = "id,text,time\n" + data.trim();
					var csv = d3.csv.parse(new_data);
					$("#bigBoxloading").hide();
					for(var i in csv) {
						var singleData = csv[i];
						var box = $("<div class='tweetusername' style='margin:5px;'></div>");
						box.html("<blockquote>" + singleData.text.substring(1, singleData.text.length - 1) + "<footer>" + singleData.time.substring(1,singleData.time.length - 1) + "</footer>"+ "</blockquote>");
						body.append(box);
					}
					
				 });
	});
	showBox();
}

function showByKeyword(word,r) {
	var keywordURL = "/function/keyword.jsp"
	$('#tweetBox').off();
	$('#tweetBox').on('show.bs.modal', function (event) {
		r.word = word;
		r.numOfResult = 20;
		var model = $(this);
		var body = $("#tweetBoxcontainer");
		body.html("");
		$("#bigBoxloading").show();
		$.get(keywordURL, r)
  	 			.done(function( data ) {
					var new_data = "id,text,time\n" + data.trim();
					var csv = d3.csv.parse(new_data);
					$("#bigBoxloading").hide();
					for(var i in csv) {
						var singleData = csv[i];
						var box = $("<div class='tweetKeyword' style='margin:5px;'></div>");
						box.html("<blockquote>" + singleData.text.substring(1, singleData.text.length - 1) + "<footer>" + singleData.time.substring(1,singleData.time.length - 1) + "</footer>"+ "</blockquote>");
						box.highlight(word);
						body.append(box);
					}
					
				 });
	});
	showBox();
}

function showBigMap(callback) {
	var id = arguments[1];
	$('#BigBoxModel').off();
	$('#BigBoxModel').on('shown.bs.modal', function (event) {
		callback(id);
	});
	showBigBox();
}

function showUser() {
	$('#BigBoxModel').off();
	$('#BigBoxModel').on('shown.bs.modal', function (event) {
		var model = $(this);
		var iframe = $("<iframe></iframe>");
		var bigBox = model.find('#BigBox');
		iframe.attr('src','http://twitframe.com/show?url=https%3A%2F%2Ftwitter.com%2Fjack%2Fprofile%2F20');
		iframe.attr('width',bigBox.width());
		iframe.attr('height',bigBox.height());
		model.find('#BigBox').html("");
		model.find('#BigBox').append(iframe);
	});
	showBigBox();
}

