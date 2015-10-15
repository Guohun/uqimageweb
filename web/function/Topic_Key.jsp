<%@ page language="java" %>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@ page import ="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>

<%

    //top right coner
    String word = request.getParameter("word");
    String keyname = request.getParameter("keyname");
    
    if (keyname!=null) keyname=keyname.trim();    
    //else word="QLD,University,UQ";
    String []tempword=word.split(" ");
    System.out.println(word);
    System.out.println(tempword.length);
    //bottom left coner		
    //numofresult
    String numOfResult = request.getParameter("numOfResult");
    //top right coner
    String x1 = request.getParameter("x1");
    String y1 = request.getParameter("y1");
    //bottom left coner		
    String x2 = request.getParameter("x2");
    String y2 = request.getParameter("y2");

    String sesameServer="http://flashlite.rcc.uq.edu.au:8080/openrdf-sesame/repositories/TweetDB";
    
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
    StringBuffer query =null;
/*    if (tempword.length>2)
     query=" select ?tid ?tweet ?time1 ?term ?postcode where { "
            + "?tid rdfs:comment ?tweet. ?tid st:Topic ?term. ?tid dc:date ?time1. "
            + " ?tid foaf:mbox  ?postcode. "
            + " {?postcode  rdfs:label  \"4072\"} union {?postcode  rdfs:label  \"4067\"}  "
            + "  filter (regex(str(?term),'" + tempword[0] + "','i') && regex(str(?term),'" + tempword[1] + "','i') && regex(str(?term),'" + tempword[2] + "','i')) }";        
        else
    query=" select ?tid ?tweet ?time1 ?term ?postcode where { "
            + "?tid rdfs:comment ?tweet. ?tid st:Topic ?term. ?tid dc:date ?time1. "
            + " ?tid foaf:mbox  ?postcode. "
            + " {?postcode  rdfs:label  \"4072\"} union {?postcode  rdfs:label  \"4067\"}  "
            + "  filter regex(str(?term),'" + word + "','i')  }";
*/

 query=new StringBuffer("PREFIX tw: <http://www.uqimage.com/tid/#>"
+" PREFIX User: <http://www.uqimage.com/uid/#> "
+" PREFIX dc: <http://purl.org/dc/elements/1.1/> "
+"  PREFIX foaf: <http://xmlns.com/foaf/0.1/> "
+"  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>"
+"  select ?mUid ?mTid  ?text ?myDate  ?postcode     where { ?mTid tw:Post ?text. "
+"  ?mUid tw:Twitt ?mTid. "
+"  ?mTid  dc:date ?myDate. "
+"   OPTIONAL { ?mTid  foaf:mbox ?postCodeUrl.    ?postCodeUrl rdfs:label ?postcode.}     ");
 
  
//+"?Tid rdfs:Literal "650259933171027968"^^xsd:long   }

    for (int i=0;i<tempword.length;i++){
            String tid=tempword[i];
            if (tid.length()<2) continue;
            query.append(" { ?mTid rdfs:Literal \"");    
            query.append(tid);    
            query.append("\"^^xsd:long } ");    
            if (i<tempword.length-1) query.append(" union  ");    
    }

    query.append("} limit 300");    
    //out.println("<h1>"+query+"</h1>");
    //String queryString = prefix + query;
    System.out.println(query.toString());
    
    String TwitterHead = "<http://www.uqimage.com/tid/#>";

    try {

        {

            TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, query.toString());
            TupleQueryResult res = MytupleQuery.evaluate();
%>            

<h1>Search hot topics: <%=keyname%>  results.</h1>
<table class='Result_table' border="1">
    <tr>
        <th>Post_Id</th>
        <th>Publish Time</th>
        <th>Content</th>        
    </tr>
    <%
        while (res.hasNext()) {
            BindingSet bs = res.next();
  //          out.println(bs.toString());
//            out.println(bs.getBindingNames());
            Binding tempB=bs.getBinding("mTid");
            if (tempB==null) continue;
            String tid = tempB.getValue().stringValue();
            if (tid == null) {
                continue;
            }
            tid=tid.substring(TwitterHead.length());
            String tweet = bs.getBinding("text").getValue().stringValue();
            String time1 = bs.getBinding("myDate").getValue().stringValue();
            String postCode = bs.getBinding("postcode").getValue().stringValue();
           // postCode=postCode.substring(TwitterHead.length());
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

