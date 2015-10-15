<%-- 
    Document   : studying
    Created on : 31/08/2015, 9:11:47 PM
    Author     : uqgzhu1, W.T. Chen
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="java.net.*" %>
<%@ page import="java.util.*"%>



<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="ROBOTS" content="ALL"/>
    <meta name="Copyright" content="Copyright (c) The University of Queensland - Guohun Zhu,  W.T. Chen"/>
    <meta name="title" content="UQ Iamge Home Page"/>
    <meta name="description" property="og:description" content="UQ Iamge, Seeing Options from Social Media"/>
    <meta name="keywords" content="UQ Iamge ; University of Queensland ; UQI ; Queensland university ; Australian universities ; Queensland universities ; Brisbane ; Australia"/>
    <title>UQImage - The University of Queensland</title>
    <link rel="shortcut icon" href="image/favicon.ico"/>    
    <link href="./css/main_1.css" rel="stylesheet" type="text/css" >

</head>  

<body>


    <%@include file="header.html" %>
    <%
        String cmd = request.getParameter("cmd");
        if (cmd == null) {
            session.setAttribute("cmd", "root");
        } else {
            session.setAttribute("cmd", cmd);
        }
        //session.getAttribute( "theName" )
    %>

    <jsp:useBean id="CmdBean" class="uqimagePkg.MycmdBean"> 
        <% CmdBean.setCmdName(cmd);%>
    </jsp:useBean>
    <!------------------------------- Side Bar------------------------------->


    <div class="sidebar-wrapper"> 
        <!-- Menu Toggle Script -->
        <ul class="sidebar-nav">
            <li class="sidebar-brand">
                Navigation
            </li>
            <li>
                <a href="studying.jsp?cmd=root">Home</a
            </li>

            <li class="<%= CmdBean.getCmdHide("studying")%>">
                <a href="studying.jsp?cmd=studying">Studying</a>
            </li>

            <li class="<%= CmdBean.getCmdHide("living")%>">
                <a href="studying.jsp?cmd=living">Living</a>
            </li>
            <li class="<%= CmdBean.getCmdHide("safety")%>">
                <a href="studying.jsp?cmd=safety">Safety</a>
            </li>
            <li class="<%= CmdBean.getCmdHide("support")%>">
                <a href="studying.jsp?cmd=support">Support</a>
            </li>
            <li class="sidebar-brand">
                UQ Public Image
            </li>
            <li class="<%= CmdBean.getCmdHide("postive")%>">
                <a href="studying.jsp?cmd=postive">Postive</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("complains")%>">
                <a href="studying.jsp?cmd=complains">Complains</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("research")%>">
                <a href="studying.jsp?cmd=research">Research</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("teaching")%>">
                <a href="studying.jsp?cmd=teaching">Teaching</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("services")%>">
                <a href="studying.jsp?cmd=services">Services</a>
            </li>
            <li class="sidebar-brand">
                Peer Comparison
            </li>
            <li>
                <select>
                    <option>QUT</option>
                    <option>Griffith</option>
                    <option>CQU</option>
                </select>
            </li>
            <li class="sidebar-brand">
                Search
            </li>
            <li>
                <textarea id="myTextinput" type="text"  rows="3" cols="100%" onfocus="SearchFunction(this)" onblur="notInFocus(this)">Please type your inquiry terms in this text box and use "," for separation 
                </textarea>   
            </li>
            <li >
                <button type="reset" class="nav-button" name="clear" > Clear </button>
                <button type="submit" class="nav-button">Search</button>
            </li>
            <li>
            <li class="sidebar-brand">
                Feedback
            </li>                    
            <form name="myform" onReset="myTextinput.rows = 1;
                        myTextinput.values = 'UQ';" METHOD=POST ACTION="makeSearch.jsp" >    
                <p class="nav-paragraph">Your email address: </p>
                <p class="nav-paragraph"><INPUT type="text" class="nav-input" id="myEmailinput"></p>
                <p class="nav-paragraph">Your comment: </p>
                <p class="nav-paragraph"><textarea id="myTextinput" type="text"  rows="3" cols="100%" onfocus="SearchFunction(this)" onblur="notInFocusComment(this)" width="180px">Please leave your comments here
                    </textarea>   </p>
            </form>
            </li>
            <li>

            </li>
            <li >
                <button type="reset" class="nav-button" name="clear" > Cancel </button>
                <button type="submit" class="nav-button">Submit</button>
            </li>
        </ul>
    </div>
    <!-------------------------------End Side Bar------------------------------->        

    <!------------------------------- Main Container------------------------------->       
    <div class="wrapper"> 

        <!-- Nav tabs  -->
        <!-- disable tab     
         <ul class="nav nav-tabs" role="tablist">
           <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">UQ</a></li>
           <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">QUT</a></li>
         </ul>
        -->
        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="home">
                <div class="sub-wrapper">
                    <!-- Location -->
                    <div class="left-driver" > 
                        <div id='Location-width' class="driver-menu">
                            Location
                        </div>
                        <div class="driver-content" >
                            <div class="map-canvas" id ="my-map">
                            </div>
                        </div>
                    </div>   
                    <!-- Location End -->
                    <!-- Time -->	 
                    <div class="mid-driver">

                        <div class="driver-menu">
                            Events
                        </div>
                        <div class="driver-content" id="series_chart_div"">
                            <div id="series_chart_div" ></div>
                        </div> 
                    </div>
                    <!-- Time  End-->
                    <!--Word cloud-->	
                    <div class="right-driver">
                        <div class="driver-menu" >
                            Word Cloud
                        </div>
                        <div id="myCanvasContainer" width="100%">
                            <canvas id="myCanvas" width="500" height="400">
                            </canvas>
                        </div>
                        <div id="tags" >

                        </div>                         
                    </div>
                    <!--Word cloud End-->	     
                </div> 
                <!--Net Work-->	 
                <div class="sub-wrapper">
                    <div class="left-driver">
                        <div class="driver-menu">
                            Social Communities
                        </div>
                        <div class="driver-content" id="network">
                            <svg class="mynetworks"></svg>
                        </div>
                    </div>
                    <!--Net Work End-->     
                    <!--Word tree-->     
                    <div class="mid-driver">
                        <div class="driver-menu">
                            Content
                        </div>
                        <div class="driver-content" id="wordtree_basic">
                            <div class="wordtree_basic" ></div>	
                        </div>
                    </div>
                    <!--Word Tree End-->
                    <!--Rank-->        
                    <div class="right-driver">
                        <div class="driver-menu">
                            Rank
                        </div>
                        <div class="driver-content" id="rank">
                            <svg class="rankloading" style="margin-top:10px;"></svg>    
                        </div>
                    </div>
                    <!--Rank-->   
                </div> 

            </div>
        </div>
    </div>
    <%@include file="footer.html" %>
</body>

<!-- End Tab panes -->
<!-------------------------------End Main Container------------------------------->
<!-- old code, can be remove
                    <tr>
                        <th id='location_w' width="33%">Location</th>
                        <th id='events_w' width="33%">Events</th>
                        <th id='wordcloud_w' width="33%">Wordcloud</th>
                    </tr>

                    <tr id='location_h' style="height:500px">
                        <td><div class="map-canvas">
                            </div>
                        </td>
                        <td >
                            <div id="series_chart_div" ></div>
                        </td>
                        <td >
                            <div id="myCanvasContainer" width="100%">
                                <canvas id="myCanvas">
                                </canvas>
                            </div>
                            <div id="tags" >
                                
                            </div>

                        </td>
                    </tr>
                    <tr style="height:600px">
                        <td>                            
                            <svg class="mynetworks"></svg>
                        </td>
                        <td><div class="wordtree_basic" ></div>						
                        </td>
                        <td>
                            <svg class="rankloading" ></svg>         
                        </td>
                    </tr>

-->




<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="./d3/jquery.js"></script>
<script src="./d3/d3.js"></script>
<script src="./d3/d3-tip.js"></script>


<script type="text/javascript" src="./js/cloud.js"></script>
<script type="text/javascript" src="./js/timeBar.js"></script>
<script type="text/javascript" src="./js/showBox.js"></script>
<script type="text/javascript" src="./js/rank.js"></script>
<script type="text/javascript" src="./js/geolocation.js"></script>
<script type="text/javascript" src="./js/wordcloud.js"></script>
<script type="text/javascript" src="./js/wordtree2.js"></script>
<script src="d3/tagcanvas.min.js" type="text/javascript"></script>

<script>
                    var clientHeight = document.getElementById('my-map').clientHeight;
                    var clientwidth = document.getElementById('my-map').clientWidth;
                    //google.maps.event.addDomListener(window, 'load', map_initialize);
                    //google.maps.event.addDomListener(window, 'load', map_initialize);


                    map_initialize();

                    NetworkFunction(clientwidth, clientHeight);
                    TreeFunction(clientwidth, clientHeight);
                    DrawRankChart(clientwidth, clientHeight - 10);
                    DrawWordCloudChart(clientwidth, clientHeight);
                    DrawEventChart(clientwidth, clientHeight - 85);


                    function SearchFunction(x) {
                        x.rows = 6;
                        x.style.background = "white";
                        x.value = '';
                        myEmailinput.type = "text";
                    }
                    function notInFocus(x) {
                        x.rows = 3;
                        x.style.background = "white";
                        x.value = 'Please type your inquiry terms in this text box and use "," for separation';
                    }

</script>
