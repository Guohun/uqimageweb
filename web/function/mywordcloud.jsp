<%-- 
    Document   : mywordcloud
    Created on : 05/09/2015, 12:25:21 PM
    Author     : uqgzhu1
--%>

<%@page import="uqimagePkg.WordCloudList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@include file="inc.jsp"%>

<%
    String highstr = request.getParameter("h");
    String widthstr = request.getParameter("w");
    int G_High = 450;
    int G_Width = 450;
    if (highstr != null) {
        G_High = Integer.valueOf(highstr);
        G_Width = Integer.valueOf(widthstr);
    }

            
              double x1=-27.49;
                double x2=-27.550;
                double y1=153.1;
                double y2=152.3;

                String x1S =request.getParameter("x1");
                if (x1S!=null) {
                        String y1S =request.getParameter("y1");
                        String x2S =request.getParameter("x2");
                        String y2S =request.getParameter("y2");
                    
                        x1=Double.valueOf(x1S);
                        x2=Double.valueOf(x2S);
                        y1=Double.valueOf(y1S);
                        y2=Double.valueOf(y2S);
                        
                }
                util.FoursquareAPI  PostAPI=new util.FoursquareAPI();
                 String []searchPost= PostAPI.getAuStateCity(x1,y1, x2, y2);//);
                PostAPI.Close();
                if (searchPost==null) return ;
                if (searchPost.length<1){
                    System.out.println("------------wordcloud -----no results------------ ");
                    return ;
                }                
                
                
    StringBuffer query =new StringBuffer(" PREFIX foaf: <http://xmlns.com/foaf/0.1/> "
            + "PREFIX geo: <http://twitter.com/geolocation/#> "
            + "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> "
            + "PREFIX et: <http://twitter.com/Event/#> "
            + "PREFIX st: <http://twitter.com/Cloud/#> "
            + " select ?a1 ?term  where { ?a1  a foaf:mbox.  ?a1 st:HighF ?term.  ");
            
      for (int i=0; i<searchPost.length;i++){
                    String tempx=searchPost[i];
                    query.append("{ ?a1 rdfs:label '"); 
                    query.append(tempx);
                    System.out.println(tempx);
                    if (i<searchPost.length-1)
                        query.append("' } union  ");
                        else
                        query.append("'} } limit 400");
            }
            
    
    
    
            

    SPARQLRepository myRepository = new SPARQLRepository(sesameServer);
    myRepository.initialize();
    //querying the repository
    RepositoryConnection con = null;
    con = myRepository.getConnection();
            
    String queryString = query.toString(); 
    String TwitterHead = "http://twitter.com/";
//    StringBuffer BufferStr = new StringBuffer();
//     	out.print(queryString);
    //BufferStr.append("['ID', 'date', 'Hotest', 'Region','impact'],");
    WordCloudList TermsList = new WordCloudList();
    TermsList.setShowSize(G_Width, G_High);
    
    try {
        String Twrequest = query.toString();
//        out.println(Twrequest);
        TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, Twrequest);
        
        //MytupleQuery.setMaxQueryTime(180);
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
//                 out.println("<H2>"+words[0]+":"+words[1]+":"+words[2]+"</h2>");
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
//    BufferStr.append("");
                StringBuffer BufferStr=new StringBuffer("weight,color,token\n");
                
                for (int i = 0; i < TermsList.size(); i++) {
                                    BufferStr.append(TermsList.getWeight(i));
                                    BufferStr.append(",");
                                    BufferStr.append(TermsList.getColor(i));
                                    BufferStr.append(",");
                                    BufferStr.append(TermsList.getToken(i));
                                    BufferStr.append("\n");
                                    if (i>30) break;
                                    }
                out.print(BufferStr.toString());
    %>