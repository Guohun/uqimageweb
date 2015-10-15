<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		
              String prefix = "PREFIX foaf: <http://xmlns.com/foaf/0.1/> \n"
                      + "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> \n"
                    +" PREFIX st: <http://twitter.com/Cloud/#>\n"
                    +" PREFIX geo: <http://twitter.com/geolocation/#>\n"
                    +" PREFIX et: <http://twitter.com/Event/#>\n";
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
               
           StringBuffer query=new StringBuffer(" select ?postStr  ?eventname1 ?score  ?starttime ?endtime ?opinon  where { "
                                        +"?eventname et:tim ?starttime. "
  +"?eventname et:etim ?endtime.  "
  +"?eventname foaf:mbox ?postcode.  "
  +"?eventname et:moti ?opinon. "
  +"?eventname rdfs:label  ?eventname1. "                   
  //+" ?eventname et:topic ?topic."
+" ?eventname et:score ?score."                   
//  +" ?eventname et:loca ?location."
//  +" ?eventname et:people ?people."
  +" ?postcode rdfs:label  ?postStr.");                   
//  +" ?eventname et:assi ?items.");

           
            //?postcode rdfs:label '" + postcode

            boolean AddFlag=false;
            boolean Flag4072=false;
            for (int i=0; i<searchPost.length;i++){
                    String tempx=searchPost[i];
                    query.append(" { ?postcode rdfs:label '"); 
                    query.append(tempx);
                    if (tempx.compareTo("4067")==0){
                        AddFlag=true;
                    }                                        
                    if (tempx.compareTo("4072")==0){
                        Flag4072=true;
                    }                                        
                    
                    query.append("' } union");
            }
            query.setLength(query.length()-5);
//                    query.append("{ ?postcode rdfs:label '"); 
  //                  query.append(searchPost[searchPost.length-1]);
    //                query.append("' } ");
            if (AddFlag&&Flag4072==false){
                    query.append(" union { ?postcode rdfs:label '4072'} "); 
            }
            query.append(" } limit 20000");

            
                //numofresult
        SPARQLRepository myRepository = new SPARQLRepository(EventServer);
        myRepository.initialize();
        //querying the repository
        RepositoryConnection con = null;
        con = myRepository.getConnection();
        //query change 
        

        String queryString = prefix + query.toString();
        
        

        String TwitterHead = "http://twitter.com/";
                
        
        
        final int max_List = 30;
        int indexList = 0;
        StringBuffer BufferStr=new StringBuffer(" [ ");        //StringBuffer("Title,Keys,StartTime,Emotion,Score,Location\n");        
        try {
            //String request1 = prefix + query;
            {
                TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                //MytupleQuery.setMaxQueryTime(180); 
                TupleQueryResult res = MytupleQuery.evaluate();
               // out.println(queryString);
                
                while (res.hasNext()) {
                    BindingSet bs = res.next();
                    
                    String postcode=bs.getBinding("postStr").getValue().stringValue();
                    String eventname=bs.getBinding("eventname1").getValue().stringValue();
                    String startTime =bs.getBinding("starttime").getValue().stringValue();// bs.getBinding("topic").getValue().stringValue().replaceAll("http://twitter.com/Cloud/#", "").split(",");
                    String EndTime =bs.getBinding("endtime").getValue().stringValue();// bs.getBinding("topic").getValue().stringValue().replaceAll("http://twitter.com/Cloud/#", "").split(",");
                    String opinion=bs.getBinding("opinon").getValue().stringValue();
//                    String topics=bs.getBinding("topic").getValue().stringValue();
                    String score=bs.getBinding("score").getValue().stringValue();
//                    String items=bs.getBinding("items").getValue().stringValue();
                    
                     if (EndTime==null) continue;
                        SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd hh:mm:ss  yyyy");
                        //Mon May 18 11:31:06 EST 2015
                        Long StartLong=Long.valueOf(startTime);
                        Long EndLong=Long.valueOf(EndTime);
                        if (EndLong<1) continue;
                        if (StartLong>EndLong) { StartLong=EndLong; EndLong=Long.valueOf(startTime);}
                        
                        Date Startdate = new Date(StartLong);
                        Date Enddate = new Date(EndLong);

                /*      { "EventName":"Early","StartTime":"12 Jul 2010 10:00","Value":1200 },
                 { "EventName":"Early","StartTime":"20 Jul 2010 10:20","Value":1000 },
                 { "EventName":"Early","StartTime":"1 Aug 2010 10:40","Value":600 },
                 { "EventName":"Early","StartTime":"8 Aug 2010 10:10","Value":500 },
*/                        
//                        var temp='[ {"EventName": "UQ_#gbr", "StartTime":"1435692228111", "Value": "0.7528445411153117", "Opion":"X"}, \
  //                                          {"EventName": "AB_#gbr", "StartTime":"435692228111", "Value": "0.7528445411153117", "Opion":"X"} \
    //                                    ]';
                        
                        BufferStr.append("{\"EventName\": ");
                        BufferStr.append("\"");
                        BufferStr.append(eventname);
                        BufferStr.append("\",");
                        BufferStr.append(" \"StartTime\":\"");                        
                        formatter = new SimpleDateFormat("EEE d MMM yyyy hh:mm");        
                        String result = formatter.format(Startdate);
                        BufferStr.append(result);
                        //BufferStr.append((1900+Startdate.getYear())+"-"+Startdate.getMonth()+"-"+Startdate.getDate()+" "+Startdate.getHours()+":"+Startdate.getMinutes());
                        BufferStr.append("\",");
                        BufferStr.append(" \"EndTime\":\"");                        
                        formatter = new SimpleDateFormat("EEE d MMM yyyy hh:mm");        
                        result = formatter.format(Enddate);
                        BufferStr.append(result);
                        BufferStr.append("\",");
                        BufferStr.append(" \"Value\": \"");                        
                        BufferStr.append(score);
                        BufferStr.append("\",");                        
                        BufferStr.append(" \"Postcode\": \"");                        
                        BufferStr.append(postcode);
                        BufferStr.append("\",");                                                
                        BufferStr.append(" \"Opion\":\"");                        
                        BufferStr.append(opinion);
                        BufferStr.append("\"},");
//                        BufferStr.append(topics);
  //                      BufferStr.append(',');
//                        BufferStr.append(items);
  //                      BufferStr.append('\n');                                        
                }
                res.close();
                BufferStr.setLength(BufferStr.length()-1);
                BufferStr.append("]");
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
        

//2067,restaurant,2104,7,13,13,16,40,2104,7,13,16,9,15,P, hospitality bars restaurant
        
                out.print (BufferStr.toString());      
                 //System.out.println(BufferStr.toString());                
    

    //  BufferStr.setLength(BufferStr.length() - 2);
    
%>
