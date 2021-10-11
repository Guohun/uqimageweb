<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%-- 
    Document   : studying
    Created on : 31/08/2015, 9:11:47 PM
    Author     : uqgzhu1, W.T. Chen
--%>


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

    <script type="text/javascript" >
        var mypopupWindow = null;
        function parent_disable() {
            if (mypopupWindow && !mypopupWindow.closed)
                mypopupWindow.focus();
        }
    </script>

</head>  

<body onFocus="parent_disable();" onclick="parent_disable();" onload="eventinitialize()">


    <%@include file="header.html" %>
    <%

        String loginflag = (String) session.getAttribute("login");
       // if (loginflag == null) {
         //  response.sendRedirect("http://uqimage.uqcloud.net/");
         // return;
        // }

        ServletContext tempSession = this.getServletConfig().getServletContext();

        String cmd = request.getParameter("cmd");
        String UniName = request.getParameter("UniName");
        String SearchCmd = null;
        if (cmd == null) {
            tempSession.setAttribute("cmd", "root");
            cmd = "root";
        } else {
            tempSession.setAttribute("cmd", cmd);
            if (!cmd.contains("myself")) {
                tempSession.setAttribute("Search", "End");
            }
        }

                
        String searchTextInput = (String) session.getAttribute("SearchTextinput");
        if (searchTextInput == null) {
            searchTextInput = "#uq, open day";
        }

        String email = (String) session.getAttribute("userEmail");
    /*
  <jsp:useBean id="CmdBean" class="uqimagePkg.MycmdBean" scope="session"> 
  </jsp:useBean>        
        <% 
        
        CmdBean.setCmdName(cmd);       
        if (UniName != null) {                
                CmdBean.setUniName(UniName);                
                tempSession.setAttribute("UniName", UniName);    
            }
       
  */      

    %>
  
    <!------------------------------- Side Bar------------------------------->


    <div class="sidebar-wrapper"> 
        <!-- Menu Toggle Script -->
        <ul class="sidebar-nav">
            <li class="sidebar-brand">
                <h2> Welcome 
                    <%
                        String userName = (String) session.getAttribute("userName");
                        String realName = (String) session.getAttribute("realName");
                        if (realName != null) {
                            out.print("<font color='orange' >" + realName + "</font>");
                        } else {
                            out.print("Navigation");
                        }

                 //    out.print("<font color='orange' >"+loginflag+"</font>");
%>

                </h2>
            </li>
            <li>
                <a href="studying.jsp?cmd=root">Home</a>
            </li>

            <li class="<%= CmdBean.getCmdHide("studying")%>">
                <a href="studying.jsp?cmd=studying">Studying</a>
            </li>

            <li class="<%= CmdBean.getCmdHide("living")%>">
                <a href="studying.jsp?cmd=living">Living</a>
            </li>
            <li class="<%= CmdBean.getCmdHide("Safety")%>">
                <a href="studying.jsp?cmd=Safety">Safety</a>
            </li>
            <li class="sidebar-brand">
                UQ Public Image
            </li>
            <li class="<%= CmdBean.getCmdHide("postive")%>">
                <a href="studying.jsp?cmd=postive">Postive</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("negative")%>">
                <a href="studying.jsp?cmd=negative">Negative</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("Research")%>">
                <a href="studying.jsp?cmd=Research">Research</a>
            </li>
            <li  class="<%= CmdBean.getCmdHide("teaching")%>">
                <a href="studying.jsp?cmd=teaching">Teaching</a>
            </li>
            <li class="sidebar-brand">
                Peer Comparison
            </li>


            <li>

                <select id="UniSelected"  onchange="myUniFunction(this)">
                    <option value="UQ" <%= CmdBean.getUniHide("UQ")%> >UQ</option>
                    <option value="QUT" <%= CmdBean.getUniHide("QUT")%> >QUT</option>
                    <option value="GRIFF" <%= CmdBean.getUniHide("GRIFF")%> >Griffith</option>
                    <option value="USQ" <%= CmdBean.getUniHide("USQ")%>>USQ</option>
                </select>
            </li>
            <li class="sidebar-brand">
                Search
            </li>            
            <li>

                <textarea id="TextinputArea" name="myTextinput" rows="6" cols="30" onfocus="SearchFunction(this);">
                        Please type your inquiry terms in this text box and use "," for separation 
                </textarea>                       
                <input type="hidden" id="hideTextInputId" name="hideTextInput" value='<%=searchTextInput%>' />
                <input type="hidden" id="hideCmdId" name="hideCmd" value='<%=cmd%>' />
                <button type="reset" class="nav-button" name="clear" > Cancel </button>
                <button id="searchBN_id" type="submit" class="nav-button">Search</button>


            </li>

            <li >
            </li>

            <li>
            <li class="sidebar-brand">
                Feedback
            </li>                                

            <form name="myeform" action="makeSearch.jsp" method="POST">
                <p class="nav-paragraph">Your comment: </p>
                <p class="nav-paragraph">
                    <textarea id="myTextinputEmail" rows="6" cols="30" onfocus="SearchFunction(this);" onblur="notInFocusComment(this);" name="emailcontent"  >Please leave your comments here
                    </textarea>   
                </p>

                <input type="reset" class="nav-button" name="clear" value="Cancel">  
                <input type="submit" class="nav-button" value="Submit">
            </form>
            <li class="sidebar-brand">
                What`s New
            </li>  

        </ul>
        <%@include file="marquee.jsp" %>
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
                        <div class="driver-content" id="series_chart_div">
                            <div id="series_chart_div1" ></div>
                        </div> 
                    </div>
                    <!-- Time  End-->
                    <div id="blanket" style="display:none;"></div>
                    <div id="popUpDiv" style="display:none;">

                        <a href="#" onclick="popup('popUpDiv')" >Click to Close CSS Pop Up</a>
                    </div>	                    
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

                        <div class="driver-menu" >
                            Social Communities:
                            <input type="radio" name="resizeGroup" value="Followers" checked="checked" onclick="resize('nothing');"/> Followers
                            <input type="radio" name="resizeGroup" value="Retweets" checked="checked" />   Retweets
                            <button type="submit" onclick="popNetwork()"  class="nav-button">Show</button>

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
                            <svg class="rankloading" ></svg>    
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




<script type="text/javascript" src="./js/cloud.js"></script>
<script type="text/javascript" src="./js/smallnetwork.js"></script>
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
                                
</script>                                


<%                
        String uniname=CmdBean.getUniName();
        
        if (uniname==null||uniname.compareTo("UQ")==0){
%>
<script>
                                
                                map_initialize(-27.497013553727715, 153.00656765699387);
</script>                                
<% 
       }else  if (uniname.compareTo("QUT")==0){
%>
<script>
                                
                                map_initialize(-27.4771, 153.0284);
</script>                                
<% 
       }else  if (uniname.compareTo("USQ")==0){
%>
<script>
//             lati=-27.6042;
  //                          longi=151.9320;                              
                                map_initialize(-27.6069593, 151.9347829);
</script>                                
<% 
       }else  {
%>

<script>
                                map_initialize(-27.5584, 153.0509);
</script>                                
<% 
       }
%>

<script>
                                NetworkFunction(clientwidth, clientHeight);
                                TreeFunction(clientwidth, clientHeight);
                                DrawRankChart(clientwidth, clientHeight - 10);
                                DrawWordCloudChart(clientwidth, clientHeight);
                                DrawEventChart(clientwidth, clientHeight - 85);


                                function SearchDo(x) {
                                    alert(myTextinput.value);
                                }
                                function SearchFunction(x) {
//                                TextinputArea.rows = 6;
                                    TextinputArea.width = 30;

                                    TextinputArea.style.background = "white";
                                    TextinputArea.value = document.getElementById('hideTextInputId').value;
                                    //myEmailinput.type = "text";
                                }

                                function storeSearch(k) {
                                    var xhttp = new XMLHttpRequest();
                                    xhttp.open("GET", "search.jsp?word=" + k.replace("#", "~"), true);
                                    xhttp.send();
                                }

                                function notInFocus(x) {
                                    //                               x.rows = 3;
                                    x.style.background = "white";
                                    x.value = 'Please type your inquiry terms in this text box and use "," for separation';

                                }
                                //      var form = document.getElementById("custome_form_id");
                                var submitBN = document.getElementById("searchBN_id")
                                submitBN.addEventListener("click", function () {
                                    var backstr = TextinputArea.value;
                                    storeSearch(TextinputArea.value);
                                    if (backstr.indexOf("please") > -1) {
                                        alert("please input the correct keywords");
                                        return;
                                    }
                                    var tempStr = "domysearch?myTextinput=" + encodeURIComponent(TextinputArea.value);

                                    //alert(tempStr);

                                    TextinputArea.value = "please waiting..........."
                                    TextinputArea.disabled = true;
                                    submitBN.disabled = true;
                                    TextinputArea.style.background = "red";
                                    $.get(tempStr, function (data, status) {
                                        TextinputArea.value = "We have finished the search, you can visulized it";
                                        TextinputArea.style.background = "white";
                                        if (data != '0')
                                            reloadPageWithHash("myself");
                                        else
                                            reloadPageWithHash("root");
                                    });


                                    /*                                $.ajax({
                                     url: "domysearch",
                                     data: "myTextinput=" + encodeURIComponent(TextinputArea.value),
                                     success: function (data, status) {
                                     if (data.error) {
                                     return;
                                     }
                                     alert("Data: " + data + "\nStatus: " + status);
                                     TextinputArea.value = "We have finished the search, you can visulized it";
                                     //location.reload();
                                     reloadPageWithHash("myself");
                                     },
                                     error: function (e) {
                                     reloadPageWithHash("root");
                                     },
                                     type: 'GET',
                                     dataType: "html/text",
                                     });
                                     */
                                });

                                function reloadPageWithHash(cmd, uniName) {
                                    var initialPage = location.pathname;
                                    if (uniName == null)
                                        location.replace('studying.jsp?cmd=' + cmd);
                                    else
                                        location.replace('studying.jsp?cmd=' + cmd + '&UniName=' + uniName);
                                }
                                function myUniFunction(sel) {
                                    var val = sel.value;
                                    var cmd ="root";// 
                                    reloadPageWithHash(cmd, val);
                                }
                                function resize(byValue) {
                                    currentSizing = byValue;
                                    var minSize = d3.min(nodes, function (d) {
                                        return parseFloat(d["weight"])
                                    });
                                    var maxSize = d3.max(nodes, function (d) {
                                        return parseFloat(d["weight"])
                                    });
                                    var minWeight = d3.min(links, function (d) {
                                        return parseFloat(d["cost"])
                                    });
                                    var maxWeight = d3.max(links, function (d) {
                                        return parseFloat(d["cost"])
                                    });
                                    var sizingRamp = d3.scale.linear().domain([minSize, maxSize]).range([1, 10]).clamp(true);
                                    var edgeRamp = d3.scale.linear().domain([maxWeight, minWeight]).range([.5, 3]).clamp(true);

                                    switch (byValue)
                                    {
                                        case "nothing":
                                            d3.selectAll("circle.node").attr("r", 5)

                                            d3.selectAll("image.node").attr("x", -2.5)
                                                    .attr("y", -2.5)
                                                    .attr("width", 5)
                                                    .attr("height", 5);
                                            break;
                                        case "degree":
                                            d3.selectAll("circle.node").attr("r", function (d) {
                                                return sizingRamp(d["weight"])
                                            })

                                            d3.selectAll("image.node").attr("x", function (d) {
                                                return -((sizingRamp(d["weight"])) / 2)
                                            })
                                                    .attr("y", function (d) {
                                                        return -((sizingRamp(d["weight"])) / 2)
                                                    })
                                                    .attr("width", function (d) {
                                                        return (sizingRamp(d["weight"]))
                                                    })
                                                    .attr("height", function (d) {
                                                        return (sizingRamp(d["weight"]))
                                                    });
                                            break;
                                    }

                                    d3.selectAll("line.link").style("stroke-width", function (d) {
                                        return edgeRamp(d["cost"])
                                    })
                                }
</script>
