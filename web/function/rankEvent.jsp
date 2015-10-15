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
               
           StringBuffer query=new StringBuffer(" select ?postStr  ?eventname1  ?starttime ?endtime ?opinon ?topic ?items  where { "
                                        +"?eventname et:tim ?starttime. "
  +"?eventname et:etim ?endtime.  "
  +"?eventname foaf:mbox ?postcode.  "
  +"?eventname et:moti ?opinon. "
  +"?eventname rdfs:label  ?eventname1. "                   
  +" ?eventname et:topic ?topic."
  +" ?eventname et:loca ?location."
  +" ?eventname et:people ?people."
  +" ?postcode rdfs:label  ?postStr."                   
  +" ?eventname et:assi ?items.");

           
            //?postcode rdfs:label '" + postcode

            boolean AddFlag=false;
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

            
                //numofresult
        SPARQLRepository myRepository = new SPARQLRepository(EventServer);
        myRepository.initialize();
        //querying the repository
        RepositoryConnection con = null;
        con = myRepository.getConnection();
        //query change 
        

        String queryString = prefix + query.toString();
        
        

        String TwitterHead = "http://twitter.com/";
                StringBuffer BufferStr=new StringBuffer("Title,Keys,StartYYYY,StartMM,StartDD,StartHH,Startmm,EndYYYY,EndMM,EndDD,EndHH,Endmm,Emotion,Location\n");        
        
        
        final int max_List = 30;
        int indexList = 0;
        
        try {
            //String request1 = prefix + query;
            {
                TupleQuery MytupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
                //MytupleQuery.setMaxQueryTime(180); 
                TupleQueryResult res = MytupleQuery.evaluate();
                
                
                while (res.hasNext()) {
                    BindingSet bs = res.next();
                    
                    String postcode=bs.getBinding("postStr").getValue().stringValue();
                    String eventname=bs.getBinding("eventname1").getValue().stringValue();
                    String startTime =bs.getBinding("starttime").getValue().stringValue();// bs.getBinding("topic").getValue().stringValue().replaceAll("http://twitter.com/Cloud/#", "").split(",");
                    String EndTime =bs.getBinding("endtime").getValue().stringValue();// bs.getBinding("topic").getValue().stringValue().replaceAll("http://twitter.com/Cloud/#", "").split(",");
                    String opinion=bs.getBinding("opinon").getValue().stringValue();
                    String topics=bs.getBinding("topic").getValue().stringValue();
                    String items=bs.getBinding("items").getValue().stringValue();
                     if (EndTime==null) continue;
                        SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd hh:mm:ss  yyyy");
                        //Mon May 18 11:31:06 EST 2015
                        Long StartLong=Long.valueOf(startTime);
                        Long EndLong=Long.valueOf(EndTime);
                        if (EndLong<1) continue;
                        if (StartLong>EndLong) { StartLong=EndLong; EndLong=Long.valueOf(startTime);}
                        
                        Date Startdate = new Date(StartLong);
                        Date Enddate = new Date(EndLong);
                        
                        BufferStr.append(postcode);
                        BufferStr.append(',');
                        BufferStr.append(eventname);
                        BufferStr.append(',');
                        BufferStr.append((1900+Startdate.getYear())); BufferStr.append(',');BufferStr.append((1+Startdate.getMonth())); BufferStr.append(',');BufferStr.append(Startdate.getDate()); BufferStr.append(',');
                        BufferStr.append(Startdate.getHours()); BufferStr.append(',');BufferStr.append(Startdate.getMinutes()); BufferStr.append(',');
                        //BufferStr.append(Startdate.getSeconds()); BufferStr.append(',');
                        BufferStr.append((1900+Enddate.getYear())); BufferStr.append(',');BufferStr.append((1+Enddate.getMonth())); BufferStr.append(',');BufferStr.append(Enddate.getDate()); BufferStr.append(',');
                        BufferStr.append(Enddate.getHours()); BufferStr.append(',');BufferStr.append(Enddate.getMinutes()); BufferStr.append(',');
                        //BufferStr.append(Enddate.getSeconds()); BufferStr.append(',');
                        BufferStr.append(opinion);
                        BufferStr.append(',');
                        BufferStr.append(topics);
  //                      BufferStr.append(',');
//                        BufferStr.append(items);
                        BufferStr.append('\n');                                        
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
        

//2067,restaurant,2104,7,13,13,16,40,2104,7,13,16,9,15,P, hospitality bars restaurant
        
                out.print (BufferStr.toString());      
                    System.out.println(BufferStr.toString());                
    

    //  BufferStr.setLength(BufferStr.length() - 2);
    
%>
