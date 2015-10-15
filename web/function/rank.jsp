<%@ page language="java" %>
<%@ page import ="org.openrdf.repository.*"%>
<%@ page import ="org.openrdf.repository.sparql.*"%>
<%@ page import ="org.openrdf.query.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>


<%@include file="inc.jsp"%>
<%//		int 
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
              
                
              
            
              
            
              util.FoursquareAPI  PostAPI=new util.FoursquareAPI();
            String [] searchPost = PostAPI.getAuStateCity(x1,y1, x2, y2);//);
            PostAPI.Close();
            if (searchPost==null) return ;                        
            
           if (searchPost.length<1){
               System.out.println("---------------Ranking--no results------------ ");
               return ;
           }
               
           StringBuffer query=new StringBuffer("select ?postcode ?topic where { ?postcode  st:Topic ?topic. ");
           
            //?postcode rdfs:label '" + postcode
            for (int i=0; i<searchPost.length;i++){
                    String tempx=searchPost[i];
                    query.append("{ ?postcode rdfs:label '"); 
                    query.append(tempx);
                    System.out.println(tempx);
                    if (i<searchPost.length-1)
                        query.append("' } union  ");
                        else
                        query.append("'} } limit 4000");
            }

                //numofresult
        SPARQLRepository myRepository = new SPARQLRepository(sesameServer);
        myRepository.initialize();
        //querying the repository
        RepositoryConnection con = null;
        con = myRepository.getConnection();
        //query change 
        

        String queryString = prefix + query.toString();
        
        //System.out.println(queryString);

        String TwitterHead = "http://twitter.com/";
        
        
        final int max_List = 30;
        String TextList[] = new String[max_List];
        char Sentiment[] = new char[max_List];
        int NumberList[] = new int[max_List];
        int indexList = 0;
        try {
            String request1 = prefix + query;
            {
                String Twrequest = request1;
                //out.println(Twrequest);
                TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, Twrequest);
                //MytupleQuery.setMaxQueryTime(180); 
                TupleQueryResult res = MytupleQuery.evaluate();
                while (res.hasNext()) {
                    BindingSet bs = res.next();
                    //out.print(bs.getBinding("topic").getValue().stringValue());
                    String[] tempSte =bs.getBinding("topic").getValue().stringValue().split(";");// bs.getBinding("topic").getValue().stringValue().replaceAll("http://twitter.com/Cloud/#", "").split(",");
                    
                    for (String temp : tempSte) {
                        String[] tempP = temp.split(":");
                        TextList[indexList] = tempP[0];                        
                        NumberList[indexList] = Integer.valueOf(tempP[1]);
                        Sentiment[indexList] = tempP[2].charAt(0);
                        int tempint=Integer.valueOf(tempP[3]);
                        if (tempint>NumberList[indexList]){
                            NumberList[indexList]=tempint;
                            Sentiment[indexList] = tempP[4].charAt(0);
                        }
                        tempint=Integer.valueOf(tempP[5]);
                        if (tempint>NumberList[indexList]){
                            NumberList[indexList]=tempint;
                            Sentiment[indexList] = tempP[6].charAt(0);
                        }
                        indexList++;
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
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (RepositoryException ex) {
                System.out.println(ex);
            }
        }
/*        [{
      'sentiment':'P',
      'name': "QLDD",
      'value': 5
    }, {
      'sentiment':'N',
      'name': "XXX",
      'value': 40
    }];
*/
        StringBuffer BufferStr=new StringBuffer("sentiment,name,value\n");
        
//        BufferStr.append("{ \"barData1\": [ \n {");
        
        for (int i=0;i<indexList;i++){
            //BufferStr.append("\"sentiment\":'");
            //BufferStr.append("'");            
            BufferStr.append(Sentiment[i]);
            //BufferStr.append("',      \"name\":\"");
            BufferStr.append(",");            
            BufferStr.append(TextList[i]);
            //BufferStr.append("\",     \"value\":");
            BufferStr.append(", ");            
            BufferStr.append(NumberList[i]);
           BufferStr.append('\n');
        }
    

    //  BufferStr.setLength(BufferStr.length() - 2);
        out.print (BufferStr.toString());      
%>
