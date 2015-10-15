<%-- 
    Document   : studying
    Created on : 31/08/2015, 9:11:47 PM
    Author     : uqgzhu1
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
    <meta name="description" property="og:description" content="UQ Iamge, An Opinion analysis system for reflecting student experience"/>
    <meta name="keywords" content="UQ Iamge ; University of Queensland ; UQI ; Queensland university ; Australian universities ; Queensland universities ; Brisbane ; Australia"/>

    <title>UQImage - The University of Queensland</title>
    
     <link href="./css/main.css" rel="stylesheet" type="text/css" >
     
</head>  

<body>
    <%@include file="header.html" %>
    <%
         String cmd = request.getParameter( "cmd" );
         if (cmd==null)
            session.setAttribute( "cmd", "root" );
         else
            session.setAttribute( "cmd", cmd);
         //session.getAttribute( "theName" )
    %>
    <jsp:useBean id="CmdBean" class="uqimagePkg.MycmdBean"> 
        <% CmdBean.setCmdName(cmd); %>
    </jsp:useBean>
    <table style="width:100%; border:1px solid #d4d4d4;  cellpadding:1; cellspacing:1; " >
        <tr>
            <td class="sidebar-wrapper"> <!-- Menu Toggle Script -->

                <ul class="sidebar-nav">
                    <li class="sidebar-brand">
                        Navigation
                    </li>
                    <li>
                        <a href="studying.jsp?cmd=root">Home</a
                    </li>

                    <li class="<%= CmdBean.getCmdHide("studying") %>">
                        <a href="studying.jsp?cmd=studying">Studying</a>
                    </li>

                    <li class="<%= CmdBean.getCmdHide("living") %>">
                        <a href="studying.jsp?cmd=living">Living</a>
                    </li>
                    <li class="<%= CmdBean.getCmdHide("safety") %>">
                        <a href="studying.jsp?cmd=safety">Safety</a>
                    </li>
                    <li class="<%= CmdBean.getCmdHide("support") %>">
                        <a href="studying.jsp?cmd=support">Support</a>
                    </li>
                    <li class="sidebar-brand">
                        UQ Public Image
                    </li>
                    <li class="<%= CmdBean.getCmdHide("postive") %>">
                        <a href="studying.jsp?cmd=postive">Postive</a>
                    </li>
                    <li  class="<%= CmdBean.getCmdHide("complains") %>">
                        <a href="studying.jsp?cmd=complains">Complains</a>
                    </li>
                    <li  class="<%= CmdBean.getCmdHide("research") %>">
                        <a href="studying.jsp?cmd=research">Research</a>
                    </li>
                    <li  class="<%= CmdBean.getCmdHide("teaching") %>">
                        <a href="studying.jsp?cmd=teaching">Teaching</a>
                    </li>
                    <li  class="<%= CmdBean.getCmdHide("services") %>">
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
                        Input your keywords
                    </li>
                    <form name="myform" onReset="myTextinput.rows=1; myTextinput.values='UQ';" METHOD=POST ACTION="makeSearch.jsp" >
                    <li>                        
                        <textarea id="myTextinput" class="nav-input" type="text"  cols="100%" onfocus="SearchFunction(this)">Great Change
                        </textarea>          <BR>
                        Your email address: <INPUT type="hidden" id="myEmailinput" SIZE=10>
                    </li>
                    <li >
                        <button type="reset" class="nav-button" name="clear" > Clear </button>
                        <button type="submit" class="nav-button">Search</button>
                    </li>
                    </form>
                </ul>
            </td>

            <td> 
                <table width="100%">
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
                                <canvas id="myCanvas" width="500" height="400">
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


                </table>
            </td>
        </tr>

    </table>
    <%@include file="footer.html" %>



<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="./d3/jquery.js"></script>
<script src="./d3/d3.js"></script>
<script src="./d3/d3-tip.js"></script>
<!-- <script type="text/javascript" src="js/timeline.js"></script> 
<link rel="stylesheet" type="text/css" href="css/timeline.css"> 
-->


<script type="text/javascript" src="./js/cloud.js"></script>
<!-- <script type="text/javascript" src="./js/drawEvent.js"></script>  -->
<script type="text/javascript" src="./js/timeBar.js"></script>
<script type="text/javascript" src="./js/showBox.js"></script>
<script type="text/javascript" src="./js/rank.js"></script>
<script type="text/javascript" src="./js/geolocation.js"></script>
<script type="text/javascript" src="./js/wordcloud.js"></script>
<script type="text/javascript" src="./js/wordtree2.js"></script>
<script src="d3/tagcanvas.min.js" type="text/javascript"></script>

<script>
                                        //google.maps.event.addDomListener(window, 'load', map_initialize);
//google.maps.event.addDomListener(window, 'load', map_initialize);
                                        var mywidth = document.getElementById('location_w').offsetWidth;
                                        var myHigh = document.getElementById('location_h').offsetHeight;
                                        
                                        map_initialize();
                                        
                                        NetworkFunction(mywidth, 300);
                                        TreeFunction(mywidth, 300);
                                        DrawRankChart(mywidth, 300);
                                        DrawWordCloudChart(mywidth, 500);
                                        DrawEventChart(mywidth, 300);


                                        
                                        function SearchFunction(x) {
                                            x.rows=6
                                            x.style.background = "yellow";
                                            myEmailinput.type="text";
                                        }

</script>