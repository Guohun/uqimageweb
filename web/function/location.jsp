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
		String x1 =request.getParameter("x1");
		String y1 =request.getParameter("y1");
		//bottom left coner		
		String x2 =request.getParameter("x2");
		String y2 =request.getParameter("y2");
		//numofresult
		String numOfResult=request.getParameter("numOfResult");
				
		//String sesameServer = "http://flashlite.rcc.uq.edu.au:8080/openrdf-sesame/repositories/uqidb";
        
        
        SPARQLRepository myRepository=new SPARQLRepository(sesameServer);
        myRepository.initialize();
		//querying the repository
		RepositoryConnection con=null;    
        con = myRepository.getConnection();
              String prefix ="PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>"
              +"PREFIX tw: <http://twitter.com/>"
              +"PREFIX foaf: <http://xmlns.com/foaf/0.1/>"
              +"PREFIX geo:<http://twitter.com/geolocation/#>"; //replace prefix         
              
    	//query change 
 		 String query=" SELECT DISTINCT ?lat ?longi ?name ?text WHERE {   ?url tw:Twitt ?tid  . ?tid rdfs:comment ?text .  ?url rdfs:label ?name . " 
        +" ?tid geo:longi ?longi. ?tid geo:lat ?lat";
        
        if (x1!=null) 
           query=query+ ".FILTER(?longi>"+y2 +" && ?longi<"+y1 +" && ?lat>"+x2+" && ?lat<"+x1+") }  LIMIT "+numOfResult;   
           else  query= query+" } limit 20"; 
        
        
        String queryString= prefix + query;
        String TwitterHead="http://twitter.com/";
     	StringBuffer BufferStr=new StringBuffer();
        try {           
       	String  request1=prefix+query;    
             {
             	//out.println(request1);
                int Edgenum = 0;
                int LikeEdgenum = 1;
                String Twrequest =request1;
                TupleQuery MytupleQuery =con.prepareTupleQuery(QueryLanguage.SPARQL, Twrequest);
                
                TupleQueryResult res = MytupleQuery.evaluate();
                String checkExit ="";
                
                while (res.hasNext()) {
                    BindingSet bs = res.next();
                    String _DPostName =bs.getBinding("name").getValue().stringValue(); 
                    if (checkExit!=_DPostName){
                    	checkExit=_DPostName;
                    	String temp=bs.getBinding("text").getValue().stringValue();
                    	StringBuffer myTest1 =new StringBuffer(temp.replaceAll(",","."));                  
                    	Binding tempLa=bs.getBinding("lat");
                   	// if (tempLa==null ) { out.println(_DPostName+"has null lat"); continue;}                  
                    	String _Lat = tempLa.getValue().stringValue();                  
                    	String _longi =bs.getBinding("longi").getValue().stringValue();                  
                    	if (_DPostName == null ) continue;
                    	int loc=_DPostName.lastIndexOf("/");
                   		String DPostName=_DPostName.substring(loc+1);                  

               			BufferStr.append("'");
                		BufferStr.append(DPostName);
                		BufferStr.append("',");
                		BufferStr.append(Double.valueOf(_Lat));
               			//BufferStr.append(Math.random() * ( Double.valueOf(x1) - Double.valueOf(x2) )+Double.valueOf(x2));
               		 	BufferStr.append(",");
                		BufferStr.append(Double.valueOf(_longi));
               			// BufferStr.append(Math.random() * ( Double.valueOf(y1) - Double.valueOf(y2) )+Double.valueOf(y2));
                //		BufferStr.append(",'");
                		Edgenum ++;
             		//   BufferStr.append(TwitterHead+DPostName);
             		//   BufferStr.append("','");
                	//	BufferStr.append(myTest1);
    					BufferStr.append("\n");
    				}
                }
                res.close();   
            }       
        } catch (RepositoryException ex) {
            System.out.println(ex);
        } catch (MalformedQueryException ex) {
            System.out.println(ex);
        } catch (QueryEvaluationException ex) {
            System.out.println(ex);
        }finally{
                try {
                    if (con!=null) con.close();
                } catch (RepositoryException ex) {
                    System.out.println(ex);
                }
        }
       // BufferStr.setLength(BufferStr.length() - 2);
        out.print(BufferStr.toString());      
%>



