<%@page import="uqimagePkg.WordCloudList"%>
<%@ page language="java" %>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@ page import ="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="java.net.*" %>
<%@ page import="java.util.*"%>

<%@include file="inc.jsp"%>

<%

    //int lim =Integer.parseInt(request.getParameter("lim"));
    String highstr = request.getParameter("h");
    String widthstr = request.getParameter("w");
    int G_High=450;
    int G_Width=450;
    if (highstr!=null){
        G_High=Integer.valueOf(highstr);
        G_Width=Integer.valueOf(widthstr);        
    }
    String x1 = request.getParameter("x1");
    String y1 = request.getParameter("y1");
    //bottom left coner		
    String x2 = request.getParameter("x2");
    String y2 = request.getParameter("y2");
    //numofresult
    String numOfResult = request.getParameter("numOfResult");
    
    SPARQLRepository myRepository = new SPARQLRepository(sesameServer);
    myRepository.initialize();
    //querying the repository
    RepositoryConnection con = null;
    con = myRepository.getConnection();

    String query = " PREFIX foaf: <http://xmlns.com/foaf/0.1/> "
            + "PREFIX geo: <http://twitter.com/geolocation/#> "
            + "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> "
            + "PREFIX et: <http://twitter.com/Event/#> "
            + "PREFIX st: <http://twitter.com/Cloud/#> "
            + " select ?a1 ?term  where { ?a1  a foaf:mbox.  ?a1 st:HighF ?term.  "
            + "{?a1 rdfs:label \"4072\"} union {?a1 rdfs:label \"4067\"} union {?a1 rdfs:label \"4112\"} union {?a1 rdfs:label \"4006\"}  } ";

    String queryString = query; //prefix + query;
    String TwitterHead = "http://twitter.com/";
    StringBuffer BufferStr = new StringBuffer();
//     	out.print(queryString);
    //BufferStr.append("['ID', 'date', 'Hotest', 'Region','impact'],");
    WordCloudList TermsList = new WordCloudList();
    TermsList.setShowSize(G_Width,G_High);
    
    try {
        String Twrequest = query;
        TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, Twrequest);
        MytupleQuery.setMaxQueryTime(180);
        TupleQueryResult res = MytupleQuery.evaluate();
        String checker = "";

        while (res.hasNext()) {
            BindingSet bs = res.next();
            
            String termStr = bs.getBinding("term").getValue().stringValue();
            
            String[] strArry = termStr.split(",");
            for (String tokenStr : strArry) {
                String words[] = tokenStr.split(":");
                if (words[0] == null || words[0].length() < 2) {
                    continue;
                }
               // out.println("<H2>"+words[0]+":"+words[1]+":"+words[2]+"</h2>");
                TermsList.add(words);
            }
        }
        res.close();
        TermsList.sortToken();
    } catch (RepositoryException ex) {
        System.out.println(ex);
    } catch (MalformedQueryException ex) {
        System.out.println(ex);
    } catch (QueryEvaluationException ex) {
        System.out.println(ex);
    } finally {
        try {
            if (con != null) {
                con.close();
            }
        } catch (RepositoryException ex) {
            System.out.println(ex);
        }
    }
    // BufferStr.setLength(BufferStr.length() - 1);
    BufferStr.append("");
    out.print(BufferStr.toString());
%>

<html>
    <head>
        <title>Event Test </title>
        <!--[if lt IE 9]><script type="text/javascript" src="excanvas.js"></script><![endif]-->
        <script src="tagcanvas.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            window.onload = function () {
                try {
                    TagCanvas.Start('myCanvas', 'tags', {
                        textFont: null,
                        textColour: null,
                        outlineColour: '#ff00ff',
                        reverse: true,
                        weight: true,
                        depth: 0.8,
                        maxSpeed: 0.05
                    });
                } catch (e) {
                    // something went wrong, hide the canvas container
                    document.getElementById('myCanvasContainer').style.display = 'none';
                }
            };
            function tpu(s) {
                //  document.getElementById('sout').innerHTML = s.innerHTML;       
                 window.open("keyword.jsp?word="+s.innerHTML,"_blank","toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500,  width=800, height=600" );
                return false;
            }
        </script>

        <style type="text/css">
            <!--
            /**
             * GeSHi (C) 2004 - 2007 Nigel McNie, 2007 - 2008 Benny Baumann
             * (http://qbnz.com/highlighter/ and http://geshi.org/)
             */
            .javascript  {font-family: 'Andale Mono', Consolas, monospace; font-size: 11px}
            .javascript .imp {font-weight: bold; color: red;}
            .javascript .kw1 {color: #000066; font-weight: bold;}
            .javascript .kw2 {color: #003366; font-weight: bold;}
            .javascript .kw3 {color: #000066;}
            .javascript .kw5 {color: #FF0000;}
            .javascript .co1 {color: #006600; font-style: italic;}
            .javascript .co2 {color: #009966; font-style: italic;}
            .javascript .coMULTI {color: #006600; font-style: italic;}
            .javascript .es0 {color: #000099; font-weight: bold;}
            .javascript .br0 {color: #009900;}
            .javascript .sy0 {color: #339933;}
            .javascript .st0 {color: #3366CC;}
            .javascript .nu0 {color: #CC0000;}
            .javascript .me1 {color: #660066;}
            .javascript span.xtra { display:block; }

            canvas { float: left; margin-bottom: 20px }
            ul.weighted {
                float: left;
                display: block;
                overflow: auto;
                padding: 20px;
                margin: 0 10px 20px 0;
                background-color: #fff;
                border: 4px solid #aaa;
                border-radius: 20px;
                -moz-border-radius: 20px;
            }
            ul.weighted li { display: inline }
            ul.weighted li a { margin: 2px }
            .centred p { width: 320px; float: left; margin-left: 20px }
            .preright { float: left }
            .huge { font-family: Impact,sans-serif; font-size: 56px }
            .large { font-family: 'Arial Black',sans-serif; font-size: 40px }
            .medium { font-family: Verdana,sans-serif; font-size: 18px }
            .small { font-family: Georgia,sans-serif; font-size: 11px }
            a.red { color: #f00 }
            a.green { color: #0c0 }
            a.purple { color: #f09 }

            -->
        </style>
    </head>
    <body>    
        <div id="myCanvasContainer">
            <canvas id="myCanvas" width="<%=G_Width %>" height="<%=G_High %>">

            </canvas>
        </div>
        <div id="tags">
            <ul class="weighted" style="font-size: 50%">

                <%
                    for (int i = 0; i < TermsList.size(); i++) {

                %>
                <li ><a style= "font-family: 'Andale Mono', Consolas, monospace; font-size: <%=TermsList.getWeight(i)%> ; <%=TermsList.getColor(i)%>" href="#" onclick="return tpu(this)" > <%=TermsList.getToken(i)%></a></li>
                    <%
                        if (i>25) break;
                        }
                    %>
            </ul>

        </div>

    </body>
</html>