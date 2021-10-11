 <style>
.tweets{
padding-left:5px;
margin-top:780px;
  height: -moz-calc(100% - 780px);
  height: -webkit-calc(100% - 780px);
}
.tweet{
margin-top:20px;
width:200px;
height:auto;
}
.avatar{
padding-left:2px;
padding-top: 6px;
width:35px;
height:35px;
float: left;
}
.nametag{
padding-top: 10px;
width:168px;
height:20px;
margin-left:42px;
font-weight: bold;
}
.nametag a{
display: block;
font-size: 14px;
text-indent: 10px;
font-family:Helvetica,"Trebuchet MS",sans-serif;
font-weight:light;
text-decoration: none;
color: #000000;
}
.postdate{
padding-top: 10px;
margin-left:42px;
display: block;
font-size: 10px;
text-indent: 10px;
font-family:Helvetica,"Trebuchet MS",sans-serif;
font-weight:light;
text-decoration: none;
color: #000000;

}
.post{
padding-top: 2px;
display: block;
font-size: 13px;
text-indent: 10px;
font-family:Helvetica,"Trebuchet MS",sans-serif;
font-weight:light;
text-decoration: none;
color: #003399;
}
.image{
  width: 41px;
  height: 41px;
  border-radius: 20%; /*don't forget prefixes*/
  background-image: url("path/to/image");
  background-position: center center;
  background-size: cover;
}
</style>
<script>
read("http://www.uqimage.com/studying/handler.jsp");
function streamTweet(tweet)
{
		console.error(tweet);
var outPrint="";
var lines = tweet.split('\\,\\');
	for(var line = 0; line < lines.length; line++){
		var entity = lines[line].split('/,/') ///entity 0 id 1 name 2 time 3 text
		if (entity.length>2){
		outPrint+="<div class=\"tweet\"><div class=\"avatar\"><img class=\"image\" src=\"https://twitter.com/"+entity[1]+"/profile_image?size=bigger\" alt=\"Smiley face\" height=\"42\" width=\"42\"></div><div class=\"nametag\">"+
		"<a  class=\"various fancybox.iframe\" href=\"https://twitter.com/"+entity[1]+"/status/"+entity[0]+"\" target=\"_blank\">"+entity[1]+"</a></div>"+
		"<div class=\"postdate\">"+entity[2]+"</div><div class=\"post\">"+entity[3]+"</div></div>";
		}
	}
	document.getElementById("stream").innerHTML=outPrint;
		console.error(outPrint);
	var t = setTimeout(read, 300000);
}
function read(file)
{
      var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                streamTweet(xmlhttp.responseText);
            }
        };
        xmlhttp.open("GET", file, true);
        xmlhttp.send();
    
        
}			
</script>
<marquee id="stream" direction="up" onmouseover=this.stop() onmouseout=this.start() scrollDelay="5" width="200" class="tweets">
 <div class="tweet">
	<div class="avatar">
	<img class="image" src="https://twitter.com/uq_news/profile_image?size=bigger" alt="Smiley face" height="42" width="42">
	</div>
	<div class="nametag">
		<a  class="various fancybox.iframe" href="https://twitter.com/UQ_News/status/666047800346415104" target="_blank">UQ_News</a>
	</div>
	<div class="postdate">
		13/11/2015
	</div>
	<div class="post">
		Melbourne followers can catch @uqbs expert Tim Kastelle this Thursday. 
	</div>
</div>
<div class="tweet">
	<div class="avatar">
	<img class="image" src="https://twitter.com/HASSUQ/profile_image?size=bigger" alt="Smiley face" height="42" width="42">
	</div>
	<div class="nametag">
		<a  class="various fancybox.iframe" href="https://twitter.com/UQ_News/status/665053005100683265" target="_blank">HumanitiesUQ</a>
	</div>
	<div class="postdate">
		12/11/2015
	</div>
	<div class="post">
		Celebrated author & UQ grad Kate Morton describes what it's like to live the writer's life. http://bit.ly/1Ms3XZn  
	</div>
</div>
<div class="tweet">
	<div class="avatar">
	<img class="image" src="https://twitter.com/oneinbillion/profile_image?size=bigger" alt="Smiley face" height="42" width="42">
	</div>
	<div class="nametag">
		<a  class="various fancybox.iframe" href="https://twitter.com/oneinbillion/status/665894490176012290" target="_blank">Max Lu</a>
	</div>
	<div class="postdate">
		13/11/2015
	</div>
	<div class="post">
		Are you recycling right? http://tinyurl.com/o6vcuf3  via @uq_news
	</div>
</div>
</marquee>
