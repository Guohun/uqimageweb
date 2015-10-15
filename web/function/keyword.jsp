<%@ page language="java" %>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@ page import ="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@include file="inc.jsp"%>
<%

    //top right coner
    String word = request.getParameter("word");
    if (word!=null) word=word.trim();
    else word="UQ";
    //bottom left coner		
    //numofresult
    String numOfResult = request.getParameter("numOfResult");
    //top right coner
    String x1 = request.getParameter("x1");
    String y1 = request.getParameter("y1");
    //bottom left coner		
    String x2 = request.getParameter("x2");
    String y2 = request.getParameter("y2");

    //String sesameServer = "http://delonix.eait.uq.edu.au:8080/openrdf-sesame/repositories/uqidb";
    SPARQLRepository myRepository = new SPARQLRepository(sesameServer);
    myRepository.initialize();
    //querying the repository
    RepositoryConnection con = null;
    con = myRepository.getConnection();
    String prefix = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> \n"
            + "PREFIX foaf: <http://xmlns.com/foaf/0.1/> \n"
            + "PREFIX dc: <http://purl.org/dc/elements/1.1/> \n"
            + "PREFIX st: <http://twitter.com/Cloud/#> \n"
            +"prefix tw: <http://twitter.com/>";

    //query change 
    String query = " select ?tid ?tweet ?time1 ?term ?postcode where { "
            + "?tid rdfs:comment ?tweet. ?tid st:HighF ?term. ?tid dc:date ?time1. "
            + " ?tid foaf:mbox  ?postcode. "
            + " {?postcode  rdfs:label  \"4072\"} union {?postcode  rdfs:label  \"4067\"}  "
            + "  filter regex(?term,'" + word + "','i')  }";

    String queryString = prefix + query;
    //out.println(queryString);

    String TwitterHead = "http://twitter.com/";

    try {

        {

            TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
            TupleQueryResult res = MytupleQuery.evaluate();
%>            

<h1>Search hot topics: <%=word%>  results.</h1>
<table class='Result_table' border="1">
    <tr>
        <th>Post_Id</th>
        <th>Publish Time</th>
        <th>Content</th>        
    </tr>
    <%
        while (res.hasNext()) {
            BindingSet bs = res.next();
            String tid = bs.getBinding("tid").getValue().stringValue();
            if (tid == null) {
                continue;
            }
            tid=tid.substring(TwitterHead.length());
            String tweet = bs.getBinding("tweet").getValue().stringValue();
            String time1 = bs.getBinding("time1").getValue().stringValue();
            String postCode = bs.getBinding("postcode").getValue().stringValue();
            postCode=postCode.substring(TwitterHead.length());
    %>                
    <tr>
        <td><%=postCode%></td>
        <td><%=time1%></td>

        <td><a href="https://twitter.com/guohun/status/<%=tid%>" > <%=tweet%> </a> </td>
    </tr>                    
    <%
                }
                res.close();
            }
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
        // BufferStr.setLength(BufferStr.length() - 2);
        //out.print(BufferStr.toString());
    %>
</table>

