<%@ page language="java" %>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>

<%@include file="inc.jsp"%>
<%
	//top right coner
        
        
//        latitude<=-27.49 and latitude>=-27.550 and longitude>=152.3  and longitude<=153.1

		
                
		//numofresult
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
//		if (y1==null) x1="";                
  //              if (x2==null) x2="";                                
    //            if (y2==null) y2="152.3";                
                
		String numOfResult=request.getParameter("numOfResult");
                if (numOfResult==null)  numOfResult="100";
		
              String prefix = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>"
              +"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n"
	      +"PREFIX st: <http://twitter.com/Cloud/#>\n"
              +"PREFIX geo: <http://twitter.com/geolocation/#>\n";
             // +"prefix tw: <http://twitter.com/>"; //replace prefix 
    	//query change 
/*        String query="select ?a ?name1 ?lat ?longi ?tweet ?b ?name2  where {  ?a foaf:knows ?b . ?a rdfs:label ?name1 . ?a geo:longi ?longi. ?a geo:lat ?lat. ?b rdfs:label ?name2. "
        +" FILTER(?longi>"+y2 +" && ?longi<"+y1 +" && ?lat>"+x2+" && ?lat<"+x1+") } LIMIT "+numOfResult;   
*/
StringBuffer query=new StringBuffer(
" select  ?name1  ?name2 ?mytype1 ?mytype2  ?score    where {  \n"
+"   ?Relate <http://twitter.com/FROM> ?a1. \n"
+"  ?Relate <http://twitter.com/TO> ?b1. \n"
+"   ?Relate <http://twitter.com/SCORE> ?score. "   
+"   ?a1 foaf:givenName  ?name1.  "
+"   ?a1 a ?mytype1. "
+"   ?b1 a ?mytype2.  "
+"   ?b1 foaf:givenName  ?name2. "
+"    } ORDER BY DESC(?score) limit 5000" );
/*              
              util.FoursquareAPI  PostAPI=new util.FoursquareAPI();
            String [] searchPost = PostAPI.getAuStateCity(x1,y1, x2, y2);//);
            PostAPI.Close();
            if (searchPost==null) return ;

                 
           if (searchPost.length<1){
               System.out.println("------------Networking -----no results------------ ");
               return ;
           }
*/
            
            boolean AddFlag=false;
           /* 
            for (int i=0; i<searchPost.length-1;i++){
                    String tempx=searchPost[i];
                    query.append("{ ?postcode rdfs:label '"); 
                    query.append(tempx);
                    if (tempx.compareTo("4067")==0){
                        AddFlag=true;
                    }                                        
                    query.append("' } union  ");
            }
                    query.append("{ ?postcode rdfs:label '"); 
                    query.append(searchPost[searchPost.length-1]);
                    query.append("' } ");
            if (AddFlag){
                    query.append(" union { ?postcode rdfs:label '4072'} "); 
            }
            query.append(" } limit 20000");
           */ 
//+ "  ?b1 foaf:mbox ?postcode.   "        
// + "{?postcode rdfs:label '4001'} union {?postcode rdfs:label '4072'}   union {?postcode rdfs:label '4067'} union {?postcode rdfs:label '4006'} } limit 20000";
//
//{?postcode rdfs:label '4072'} union {?postcode rdfs:label '4000'}  union {?postcode rdfs:label '4000'} union {?postcode rdfs:label '4001'}  union {?postcode rdfs:label '4067'} union {?postcode rdfs:label '4006'}    
//	out.println(query);union {?postcode rdfs:label '4000'} union {?postcode rdfs:label '4067'} union {?postcode rdfs:label '4006'}   
//

        String queryString= prefix + query.toString();
        String TwitterHead="http://twitter.com/";
        
      //  System.err.println(queryString);
  EventServer = "http://flashlite.rcc.uq.edu.au:8080/openrdf-sesame/repositories/FriendDB";
        
        SPARQLRepository myRepository=new SPARQLRepository(EventServer);
        myRepository.initialize();
		//querying the repository
        RepositoryConnection con=null;    
        con = myRepository.getConnection();
        
     	StringBuffer BufferStr=new StringBuffer();
//     	out.println(queryString);
     	HashMap<String, Integer> groupMap = new HashMap<String, Integer>();
//     	HashMap<String, Integer> name = new HashMap<String, Integer>();
        //HashMap <Integer, HashSet<Integer> > myEdge = new HashMap  <Integer,  HashSet<Integer> >();
        ArrayList  [] myEdge = new ArrayList [5000];
     	HashMap<String, Integer> link = new HashMap<String, Integer>();
        HashMap <String,Integer> list= new HashMap <String,Integer>();
     	int count=0;
        int numberofEdge=0;
        try {  
       	
             {
                int Edgenum = 0;
                int LikeEdgenum = 1;
                

                
                TupleQuery MytupleQuery =con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                TupleQueryResult res = MytupleQuery.evaluate();
                
		int num=0; 
                while (res.hasNext()) {
                          BindingSet bs = res.next();
   					String name1 =bs.getBinding("name1").getValue().stringValue();
   					String name2 =bs.getBinding("name2").getValue().stringValue(); 
   					String topic1 =bs.getBinding("mytype1").getValue().stringValue(); 
                                        String topic2 =bs.getBinding("mytype2").getValue().stringValue(); 
                                        String score =bs.getBinding("score").getValue().stringValue(); 
                                        System.err.println(name1+"\t"+name2+"\t"+topic1+"\t"+topic2+"\t"+score);
				        //topic1=topic1.toUpperCase();
                                        //topic2=topic2.toUpperCase();
                                        if(topic1.contains("Person")){
                                            if(name1.indexOf("oneinbillion"	)>=0) groupMap.put(name1,new Integer(3));
                                            else if(name1.indexOf("Antonpjm"	)>=0) groupMap.put(name1,new Integer(3));                                                                                        
                                            else groupMap.put(name1,new Integer(1));
                                        }else{                                            
                                            if(name1.indexOf("RCCUQ")>=0) groupMap.put(name1,new Integer(4));
                                            else if(name1.indexOf("UQ_News")>=0) groupMap.put(name1,new Integer(4));
                                            else groupMap.put(name1,new Integer(2));                                            
                                        }
                                        
						
                                        if(topic2.contains("Person")){
                                            if(name2.indexOf("oneinbillion"	)>=0) groupMap.put(name2,new Integer(3));
                                            else if(name2.indexOf("Antonpjm"	)>=0) groupMap.put(name2,new Integer(3));                                                                                        
                                            else groupMap.put(name2,new Integer(1));
                                        }else{                                            
                                            if(name2.indexOf("RCCUQ")>=0) groupMap.put(name2,new Integer(4));
                                            else if(name2.indexOf("UQ_News")>=0) groupMap.put(name2,new Integer(4));
                                            else groupMap.put(name2,new Integer(2));                                            
                                        }
   					
				        
                                        if (list.get(name1)==null){
                                                list.put(name1,count++);
                                        }
                                        if (list.get(name2)==null){
                                               list.put(name2,count++);
                                        }                                                                                
                                        Integer value1=list.get(name1);
                                        Integer value2=list.get(name2);
                                        
                                        if (value1>value2){
                                            Integer temp=value1; value1=value2; value2=temp;
                                        }
                                        //Integer value=myEdge.get(value1);
                                        //if (value==null){
                                        ArrayList tempX=myEdge[value1];
                                        if (tempX==null)
                                            { 
                                                tempX=new ArrayList ();
                                                tempX.add(value2);
                                                myEdge[value1]=tempX;
                                                numberofEdge++;                                         
                                         }else  if (!tempX.contains(value2)){
                                                tempX.add(value2);
                                                myEdge[value1]=tempX;
                                                numberofEdge++;
                                            }
                                        //}else{
                                            //if (value.intValue()!=value2.intValue()) {                                                                                                
                                              //      myEdge.put(value1, value2);
                                          //      }
                                        //}                                                
                                        
//       				list.add(name1);
  //     				list.add(name2);
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
     //   out.println("<h1>"+list.size()+"</h1>");
      //  out.println("<h1>"+numberofEdge+"</h1>");
         BufferStr.append("{\"nodes\":[");
              int k=0;
                for (String key:list.keySet()){
			int group=1;
			Integer group1=groupMap.get(key);
			if (group1!=null)  group=group1.intValue();
                	BufferStr.append("{\"name\":\""+key+"\",\"group\":"+group+"},");
                }
                
        BufferStr.setLength(BufferStr.length() - 1);
  		BufferStr.append("],\"links\":[");
  		for (int i=0;i<list.size();i++) {
                        ArrayList <Integer> keySet=myEdge[i];
                        if (keySet==null) continue;
                        for (int j=0;j<keySet.size();j++){
                            //String temp="{\"source\":"+ i+",\"target\":"+key1+",\"value\":1},";  			  			
                            BufferStr.append("{\"source\":");
                            BufferStr.append(i);
                            BufferStr.append(",\"target\":");
                            BufferStr.append(keySet.get(j));
                            BufferStr.append(",\"value\":1},");
                        //   out.println("<h1>"+i+":"+key1+"</h1>");
                        }
  		}
  		BufferStr.setLength(BufferStr.length() - 1);
  	        BufferStr.append(" ]}");
        out.print(BufferStr.toString());      
%>





