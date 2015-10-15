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
    String word1 = request.getParameter("word");
    String word=word1.replace("'", "");
    
    if (word!=null) word=word.trim();
    else word="UQ";
    //bottom left coner		
    //numofresult
    String eventname = request.getParameter("eventName");
    //out.println(eventname+"<br>");
    //eventname=eventname.replace("%20", " ");
        
    
 
    String prefix = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> \n"
            + "PREFIX foaf: <http://xmlns.com/foaf/0.1/> \n"
            + "PREFIX dc: <http://purl.org/dc/elements/1.1/> \n"
            +" PREFIX et: <http://twitter.com/Event/#> \n"            
            + "PREFIX st: <http://twitter.com/Cloud/#> \n"
            +"prefix tw: <http://twitter.com/> \n";

    String query = "select ?starttime ?endtime ?items   where { "
                +"?eventname et:tim ?starttime. "
                +"?eventname et:etim ?endtime.  "
                +" ?eventname foaf:mbox ?postcode.  "
               +" ?postcode rdfs:label  '"+ word + "'."
                +" ?eventname et:assi ?items."
                 +" ?eventname rdfs:label '"+ eventname + "'."
                +"} limit 100";

            //+ "  filter regex(?term,'" + word + "','i')  }";
   // out.println(query);
    SPARQLRepository myRepository = new SPARQLRepository(EventServer);
    myRepository.initialize();
    //querying the repository
    RepositoryConnection con = null;
    con = myRepository.getConnection();
    
          TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, prefix+query);
            TupleQueryResult res = MytupleQuery.evaluate();
    
    String[] twitter_idS=null;
    Date Starttime=null;
    Date Endtime=null;
    if (res.hasNext()){
            BindingSet bs = res.next();
            Starttime =new Date(Long.valueOf(bs.getBinding("starttime").getValue().stringValue()));
            Endtime =new Date(Long.valueOf(bs.getBinding("endtime").getValue().stringValue()));
            String items = bs.getBinding("items").getValue().stringValue();
            twitter_idS=items.split(" ");
    }
    con.close();
    
    if (twitter_idS==null){
%>
<h1>Search Event from  Twitter or Facebook for EventName:  <font color='blue'>  <%=eventname %>   </font> </h1> 
<h2> Database may be    Could not find support Evidences, please contact Administration.</h2> 
<%   
        return;
    }
  
      
    //query change 
     StringBuffer  queryBuffer =new  StringBuffer(" select ?tid ?tweet ?time1 ?term ?postcode where { "
            + "?tid rdfs:comment ?tweet. ?tid st:HighF ?term. ?tid dc:date ?time1. "
            + " ?tid foaf:mbox  ?postcode.  ");
            //+ "?tid rdfs:Literal \""+word+"\"^^xsd:long. } limit "+ 50;
     int numberOftwitters=twitter_idS.length;
     
     for (int i=0;i<numberOftwitters;i++)
    {        
        queryBuffer.append(" { ?tid rdfs:Literal \"");
        queryBuffer.append(twitter_idS[i]);
        queryBuffer.append("\"^^xsd:long . }  union");        
        if (i>100) break;
    }
   
     queryBuffer.setLength(queryBuffer.length() - 6);
    
    queryBuffer.append("} limit 100");
    String queryString = prefix + queryBuffer.toString();
  //  out.println(queryString);

    myRepository = new SPARQLRepository(sesameServer);
    myRepository.initialize();
    //querying the repository
    con = null;
    con = myRepository.getConnection();
    
    
    
    String TwitterHead = "http://twitter.com/";

    try {

        {

             MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
             res = MytupleQuery.evaluate();
%>            


<h1>Search Event from  Twitter or Facebook for EventName:  <font color='blue'>  <%=eventname %>   </font> results.</h1> 
<h2> Event time From: <font color='blue'>   <%=Starttime %>  and  End: <%=Endtime %> </font>  Total Event twitter is  <font color='blue'>    <%=numberOftwitters %></font>  .</h2> 
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

