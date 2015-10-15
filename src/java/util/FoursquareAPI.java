/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;

//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//import org.json.simple.parser.ParseException;
/**
 *
 * @author uqgzhu1
 */
public class FoursquareAPI {

    private static final String API_HOST = "api.foursquare.com";
    //private static final String DEFAULT_TERM = "dinner";
    //private static final String DEFAULT_LOCATION = "San Francisco, CA";
    private static final int SEARCH_LIMIT = 3;
    private static final String SEARCH_PATH = "/v2/venues/search";
    private static final String BUSINESS_PATH = "/v2/business";

    static final String FOURSQUARE_OAUTH_REQUEST_TOKEN = "http://foursquare.com/oauth/request_token";
    static final String FOURSQUARE_OAUTH_ACCESS_TOKEN = "http://foursquare.com/oauth/access_token";
    static final String FOURSQUARE_OAUTH_AUTHORIZE = "http://foursquare.com/oauth/authorize";
    private static final String CONSUMER_KEY = "SV5TE3OAE5CSFSPV4BH520SW2RPXCK24CARNTRTSCBEBMKGQ";
    private static final String CONSUMER_SECRET = "DNUHTOBW3XJGSLKRNH51GDUUJZCBWRB515X15QJGKHXHVBXK";
    private StringBuffer G_htp = new StringBuffer("https://api.foursquare.com/v2/venues/search?client_id=SV5TE3OAE5CSFSPV4BH520SW2RPXCK24CARNTRTSCBEBMKGQ&client_secret=DNUHTOBW3XJGSLKRNH51GDUUJZCBWRB515X15QJGKHXHVBXK&v=20130815&ll=");
    private StringBuffer Google_htp = new StringBuffer("http://maps.googleapis.com/maps/api/geocode/json?sensor=true&");//-26.929948,142.401002

    //https://api.foursquare.com/v2/venues/search?client_id=SV5TE3OAE5CSFSPV4BH520SW2RPXCK24CARNTRTSCBEBMKGQ&client_secret=DNUHTOBW3XJGSLKRNH51GDUUJZCBWRB515X15QJGKHXHVBXK&v=20130815&ll=-36.4575,148.262222
    /*
     * Here the fullAddress String is in format like
     * "address,city,state,zipcode". Here address means "street number + route"
     * .
     */
    public double[] convertGoogleToLatLong(String CityStr, String Contry, String place_type1) {
        int index = -1;
        double[] returnDouble = null;
        try {
            String fullAddress = CityStr;
            if (Contry != null) {
                fullAddress += "," + Contry;
            }
            
            URL url = new URL(Google_htp + "address=" + URLEncoder.encode(fullAddress, "UTF-8") + "&sensor=false");
            // Open the Connection
          //  System.out.println(Google_htp + "address="+ URLEncoder.encode(fullAddress, "UTF-8") + "&sensor=false");
            URLConnection conn = url.openConnection();
            URLConnection con = url.openConnection();
            //SSLException thrown here if server certificate is invalid

            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));

            StringBuffer inputBuffer = new StringBuffer();
            String input = null;
            String locality = null;
            int IsaCity = 0;
            while ((input = br.readLine()) != null && IsaCity == 0) {
                //inputBuffer.append(input);
                index = input.indexOf("types");
                if (index > 0) {
                    String tempStr[] = input.substring(index + 6).split(",");
                    if (tempStr[0].contains("locality")) //it is a city
                    {
                        IsaCity = 1;
                    } else if (tempStr[0].contains("colloquial_area")) //it is a mixed concepts
                    {
                        IsaCity = 2;
                    } else if (tempStr[0].contains("administrative_area_level_1")) //it is a state
                    {
                        IsaCity = 3;
                    } else if (tempStr[0].contains("country")) //it is a country
                    {
                        IsaCity = 4;
                    }
                }
            }//end withile
            while ((input = br.readLine()) != null && IsaCity == 2) {   //it is the mixed place, we need city
                index = input.indexOf("types");
                if (index > 0) {
                    String tempStr[] = input.substring(index + 6).split(",");
                    if (tempStr[0].contains("locality")) //it is a city
                    {
                        IsaCity = 1;
                    }
//                    else if (tempStr[0].contains("country"))  //it is a country
                    //                      IsaCity=1;
                }
            }//end withile
            index = -1;

            returnDouble = new double[8];
            double MaxLong = 0, MinLong = Double.MAX_VALUE;
            double MaxLat = 0, MinLat = Double.MAX_VALUE;

            while ((input = br.readLine()) != null && index < 0) {   //ignore mistaken
                index = input.indexOf("geometry");  //start geometry
                if (index > 0) {
                    int loc = 0;
                    while ((input = br.readLine()) != null && loc < 6) {   //it is the mixed place, we need city                                                        
                        {
                            String tempStr[] = input.split(":");
                            if (tempStr.length < 2) {
                                continue;
                            }
                            String tempStr1 = tempStr[1].replace(',', ' ');
                            if (tempStr[0].contains("lat")) {
                                returnDouble[loc] = Double.valueOf(tempStr1);
                                if (MaxLat < returnDouble[loc]) {
                                    MaxLat = returnDouble[loc];
                                }
                                if (MinLat > returnDouble[loc]) {
                                    MinLat = returnDouble[loc];
                                }
                                loc++;
                            }
                            
                            if (tempStr[0].contains("lng")) {
                                returnDouble[loc] = Double.valueOf(tempStr1);
                                if (MaxLong < returnDouble[loc]) {
                                    MaxLong = returnDouble[loc];
                                }
                                if (MinLong > returnDouble[loc]) {
                                    MinLong = returnDouble[loc];
                                }
                                loc++;                                
                            }
                        }
                    }//end withile                    
                    index = 6;//==break;
                }
            }//end withile
            br.close();
            returnDouble[6] =returnDouble[0]+ Math.random() * (MaxLat - MinLat)/2;
            returnDouble[7] =returnDouble[1]+ Math.random() * (MaxLong - MinLong)/2;

            return returnDouble;//response.getBody();
        } catch (MalformedURLException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public FoursquareAPI() {
//              yelpApi = new YelpAPI();
//    this.accessToken = new Token(TOKEN, TOKEN_SECRET);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
        } catch (ClassNotFoundException ex) {
            System.err.println("mysql " + ex);
        } catch (SQLException ex) {
            System.err.println("stmt " + ex);
        }
    }

    //http://maps.googleapis.com/maps/api/geocode/json?latlng=-9.56189,113.15437&sensor=true
    //http://maps.googleapis.com/maps/api/geocode/json?sensor=true&latlng=-26.929948,142.401002
    public JSONObject searchGoogleMap(String term, double latitude, double longitude) {
        try {
            //OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.foursquare.com/v2/venues/search");
            int len = Google_htp.length();
            Google_htp.append("latlng=");
            Google_htp.append(latitude);
            Google_htp.append(',');
            Google_htp.append(longitude);
            int len1 = Google_htp.length();
            //String contents = java.net.URL();
            URL url = new URL(Google_htp.toString());
            Google_htp.delete(len, len1);
            URLConnection con = url.openConnection();

            BufferedReader br
                    = new BufferedReader(
                            new InputStreamReader(con.getInputStream()));

            String input = null;
            boolean Begin_City = false;
            int number = 0;
            JSONObject list1 = new JSONObject();
            StringBuffer SaveString = new StringBuffer();
            while ((input = br.readLine()) != null) {
                String[] tempS = input.split(":");
                if (Begin_City) {
                    if (tempS[0].contains("short_name")) {
                        SaveString.append(tempS[1].trim());
                    }
                    if (tempS[0].contains("types")) {
                        String tempType = tempS[1].trim();
                        if (tempType.length() < 3) {
                            if (tempS.length < 3) {
                                SaveString.setLength(0);
                                continue;
                            }
                            tempType = tempS[2].trim();
                        }
                        int loc = 1;
                        do {
                            loc = -1;
                            for (int i = 0; i < SaveString.length(); i++) {
                                switch (SaveString.charAt(i)) {
                                    case '\"':
                                    case ',':
                                    case ':':
                                        loc = i;
                                        break;
                                }
                            }

                            if (loc >= 0) {
                                SaveString.delete(loc, loc + 1);
                            }
                        } while (loc >= 0);
                        if (tempType.contains("postal_code")) {
                            list1.put("post_code", SaveString.toString());
                            number++;
                        } else if (tempType.contains("administrative_area_level_1")) {
                            list1.put("state_code", SaveString.toString());
                            number++;
                        } else if (tempType.contains("country")) {
                            list1.put("country_code", SaveString.toString());
                            number++;
                        } else if (tempType.contains("locality")) {
                            list1.put("city_name", SaveString.toString());
                            number++;
                        }
                //              else
                        //              System.out.println(tempType+":"+SaveString.toString());
                        SaveString.setLength(0);
                    }
                }
                if (tempS[0].contains("address_components")) {
                    if (Begin_City) {
                        break;
                    }
                    Begin_City = true;
                }
            }
            br.close();

            return list1;
        } catch (IOException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public JSONObject search4Square(String term, double latitude, double longitude) {
        try {
            //OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.foursquare.com/v2/venues/search");
            int len = G_htp.length();
            G_htp.append(latitude);
            G_htp.append(',');
            G_htp.append(longitude);
            int len1 = G_htp.length();
            //String contents = java.net.URL();
            URL url = new URL(G_htp.toString());
            G_htp.delete(len, len1);
            URLConnection con = url.openConnection();
            //SSLException thrown here if server certificate is invalid

            BufferedReader br
                    = new BufferedReader(
                            new InputStreamReader(con.getInputStream()));
            boolean Begin_City = false;
            int number = 0;
            JSONObject list1 = new JSONObject();
            String input = null;
            while ((input = br.readLine()) != null) {
//                System.out.println(input);
                String[] tempS = input.split(",");
                for (int index = 0; index < tempS.length; index++) {
                    String[] IntempS = tempS[index].split(":");
                    if (IntempS.length < 2) {
                        continue;
                    }
                    char[] SaveStringArry = IntempS[1].toCharArray();
                    for (int i = 0; i < SaveStringArry.length; i++) {
                        if (SaveStringArry[i] == '\"') {
                            SaveStringArry[i] = ' ';
                        } else if (SaveStringArry[i] == '[') {
                            SaveStringArry[i] = ' ';
                        }
                        if (SaveStringArry[i] == ']') {
                            SaveStringArry[i] = ' ';
                        }
                    }
                    String SaveString = String.copyValueOf(SaveStringArry).trim();

                    if (IntempS[0].contains("postalCode")) {
                        list1.put("post_code", SaveString);
                        number++;
                    } else if (IntempS[0].contains("state")) {
                        list1.put("state_code", SaveString);
                        number++;
                    } else if (IntempS[0].contains("cc")) {
                        list1.put("country_code", SaveString);
                        number++;
                    } else if (IntempS[0].contains("city")) {
                        list1.put("city_name", SaveString);
                        number++;
                    } else if (IntempS[0].contains("formattedAddress")) {
                        list1.put("address", SaveString);
                        number++;
                    } else if (IntempS[0].contains("name")) {
                        list1.put("place_name", SaveString);
                        number++;
                    }

                    if (number > 5) {
                        break;
                    }
                }
            }
            br.close();

            return list1;
        } catch (IOException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String search(String term, double latitude, double longitude) {
        try {
            //OAuthRequest request = new OAuthRequest(Verb.GET, "https://api.foursquare.com/v2/venues/search");
            int len = G_htp.length();
            G_htp.append(latitude);
            G_htp.append(',');
            G_htp.append(longitude);
            int len1 = G_htp.length();
            //String contents = java.net.URL();
            URL url = new URL(G_htp.toString());
            G_htp.delete(len, len1);
            URLConnection con = url.openConnection();
            //SSLException thrown here if server certificate is invalid

            BufferedReader br
                    = new BufferedReader(
                            new InputStreamReader(con.getInputStream()));

            StringBuffer inputBuffer = new StringBuffer();
            String input = null;
            while ((input = br.readLine()) != null) {
                inputBuffer.append(input);
                //System.out.println(input);
            }
            br.close();
            //request.addQuerystringParameter("v", "20130815");
            //request.addQuerystringParameter("ll", latitude + "," + longitude);
            //request.addQuerystringParameter("limit", String.valueOf(SEARCH_LIMIT));
//    this.service.signRequest(this.accessToken, request);
            //Response response = request.send();

            return inputBuffer.toString();//response.getBody();
        } catch (IOException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //
    /**
     * Main entry for sample Yelp API requests.
     * <p>
     * After entering your OAuth credentials, execute <tt><b>run.sh</b></tt> to
     * run this example.
     */
    public static void main(String[] args) {
        try {
            //  YelpAPICLI yelpApiCli = new YelpAPICLI();
            //new JCommander(yelpApiCli, args);

            FoursquareAPI yelpApi = new FoursquareAPI();
            //String searchResponseJSON = yelpApi.search("city", -27.56, 152.34);
            //String searchResponseJSON1 = yelpApi.search("city", -28.636765,153.637283);//-27.497835,153.017472);
            //String searchResponseJSON = yelpApi.search("city", -27.497835,153.017472);//);
//            double[] tempR = yelpApi.convertGoogleToLatLong("Queens, NY, United States", null, null);
            double tempR[]=yelpApi.convertGoogleToLatLong("St Lucia", "Australia", null);            
            if (tempR != null) {
                System.out.println("lat=" + tempR[0] + "\t" + "long=" + tempR[1]);
            }
            double x[]=yelpApi.getGeoByPostCode("4072");
           // System.out.println("x="+x[0]+"\ty="+x[1]);
            //JSONObject searchResponseJSON = yelpApi.getAuStateCity(-18.73493058,138.6715754);//);
            //JSONObject searchResponseJSON = yelpApi.getAuStateCity(-28.156192,153.6387356);//);
            //-20.62312633	Lo:151.23978967
            //-32.2010191	:	121.7808822
            String [] searchPost = yelpApi.getAuStateCity(-27.45426064,153.0982, -27.5386, 152.967);//);
            for (String tempx:searchPost){
                System.out.println(tempx);
            }
            //select distinct postcode,state from postcodes_geo where latitude<=-27.43426064 and latitude>=-27.4956 and longitude>=152.867  and longitude<=152.998
            
            JSONObject searchResponseJSON = yelpApi.getAuStateCity(39.78225, -84.364132);//);
            JSONObject searchResponseJSON4 = yelpApi.getAuStateCity(-5.899762, 144.264132);//);
            
            yelpApi.Close();
//            System.exit(0);
            //JSONObject searchResponseJSON = yelpApi.searchGoogleMap("city", -5.899762, 144.264132);//);
            //System.out.println(response);
            /*        JSONParser parser = new JSONParser();
             JSONObject response=null;
             try {
             response = (JSONObject) parser.parse(searchResponseJSON);
             } catch (ParseException pe) {
             System.err.println("Error: could not parse JSON response:");
             System.err.println(searchResponseJSON);
             System.exit(1);
             }
            
             JSONObject temp= (JSONObject) response.get("response");
             //        for (    Object key : temp.keySet()) {
             //            System.out.println((String)key +":"+temp.get(key));
             //          System.out.println("---------------");
             //      }
            
             JSONArray businesses = (JSONArray) temp.get("venues");
             JSONObject firstBusiness = (JSONObject) businesses.get(0);
             JSONObject Location =  (JSONObject)firstBusiness.get("location");
             */

            String country_code = (String) searchResponseJSON.get("country_code");
            String city_code = (String) searchResponseJSON.get("city_name");
            String state_code = (String) searchResponseJSON.get("state_code");
            String post_code = (String) searchResponseJSON.get("post_code");

            //String firstBusinessID = firstBusiness.get("id").toString();
            //System.out.println(String.format(
            //      "%s businesses found, querying business info for the top result \"%s\" ...",
            //    businesses.size(), firstBusinessID));
            // Select the first business and display business details
            //    System.out.println(String.format("Result for business \"%s\" found:", firstBusinessID));
            //      String businessResponseJSON = yelpApi.searchByBusinessId(firstBusinessID.toString());
//        System.out.println(businessResponseJSON);
            //String loudScreaming = firstBusiness.getJSONObject("LabelData").getString("slogan");
            //JSONObject json = new JSONObject(businessResponseJSON);
            System.out.println(String.format("post_code= \"%s\" :", post_code));
            System.out.println(String.format("city_code= \"%s\" :", city_code));
            System.out.println(String.format("state_code= \"%s\" :", state_code));
            System.out.println(String.format("country_code= \"%s\" :", country_code));
            System.out.println(searchResponseJSON.toString());
            //queryAPI(yelpApi, yelpApiCli);
        } catch (JSONException ex) {
            System.err.println( ex);
        }
    }

    public JSONObject getPostCodeByGeo(Double v_Latitude, Double v_Longtitude) {
        boolean searchAgain = true;
        JSONObject businesses = null;
        if (v_Latitude == null) {
            return null;
        }
//        businesses = yelpApi.search4Yelp("city", v_Latitude, v_Longtitude);//-27.497835,153.017472);                      

/*        if (searchAgain) {
            businesses = search4Square("city", v_Latitude, v_Longtitude);
            searchAgain = false;
        }
        if (businesses == null) {
            searchAgain = true;
        } else if (businesses.length() < 1) {
            searchAgain = true;
        }
*/        
        if (searchAgain) {
            searchAgain = false;
            System.out.println("La:" + v_Latitude + "\tLo:" + v_Longtitude);
            businesses = searchGoogleMap("city", v_Latitude, v_Longtitude);
            if (businesses == null) {
                //                                System.out.println("\t" + v_tweet_Country_Code + "\t:" + v_tweet_Place_Name);
                searchAgain = true;
            } else if (businesses.length() < 1) {
                //System.out.println("\t" + v_tweet_Country_Code + "\t:" + v_tweet_Place_Name);
                searchAgain = true;
            }
        }

        return businesses;
    }

    public String [] getAuStateCity(Double v_Latitude, Double v_Longtitude, Double x2, Double y2 ) {
        
         
        try {
            
            

                double normal_La = v_Latitude.doubleValue();
                double normal_Lo = v_Longtitude.doubleValue();
                String sql = "select distinct postcode,state from postcodes_geo where latitude<=" + v_Latitude.toString() + " and latitude>=" + x2 + " and longitude>=" + y2 + "  and longitude<=" + v_Longtitude.toString();
                        
                    System.err.println(sql);
                    int rows=0;
                  ResultSet rs = stmt.executeQuery(sql);
                    rs.last();
                     rows = rs.getRow();
                     rs.beforeFirst();                

                
                //String returnStr[] = new String[2];
                double Max_dis = Double.MAX_VALUE;
                String country_code = "AU";
                String city_code = null;
                String state_code = null;
                String post_code = null;
                int index=0;
                //JSONObject businesses = new JSONObject();
                String returnStr[]=new String[rows];
                while(rs.next()){
                    //Retrieve by column name
                        state_code = rs.getString("state");
                        post_code = rs.getString("postcode");
                        returnStr[index++]=post_code;
//                        businesses.put("country_code", "AU");
//                        businesses.put("state_code", city_code);
//                        businesses.put("post_code", post_code);
                        
                        
                } ;
                
//                if (Max_dis > 100) {
  //                  System.err.println("It is impossible so distance, another country" + Max_dis);
    //                return getPostCodeByGeo(v_Latitude, v_Longtitude);
      //          }
                rs.close();
                
                
                
                return returnStr;
                


            
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return null;
    }

    
    public JSONObject getAuStateCity(Double v_Latitude, Double v_Longtitude) {
        
         
        try {
            
            double rateLat=1; 
            double rateLong=1; 
            char Direction_flag='T';
            boolean searchAgain=false;
            String sql=null;
            if (v_Latitude>0)
                sql = "select min(latitude),min(longitude) from postcodes_geo where latitude>="+v_Latitude + " and longitude >="+ v_Longtitude;
            else
                sql = "select min(latitude),min(longitude) from postcodes_geo where latitude>="+v_Latitude + " and longitude >="+ v_Longtitude;
            
            ResultSet rs = null;
            rs = stmt.executeQuery(sql);                       
            if (rs.next()) {
                    Double tempd=rs.getDouble(1);                    
                 //   System.err.println(tempd+"->"+sql);            
                    if (tempd<v_Latitude){
                        rateLat =(double) tempd;
                        rateLong =(double)rs.getDouble(2);                
                        Direction_flag='R';
                    }else  searchAgain=true;                                    
            }else searchAgain=true;
            rs.close();
            if (searchAgain)
            {
                searchAgain=false;
                sql = "select min(abs(latitude-"+v_Latitude+")),min(abs(longitude-"+v_Longtitude+")) from postcodes_geo where latitude<="+v_Latitude + " and longitude <="+ v_Longtitude;
              //  System.err.println("again..."+sql);                
                rs = stmt.executeQuery(sql);           
                if (rs.next()) {
                    Double tempd=rs.getDouble(1);
                    Double tempd1=rs.getDouble(2);
                    if (tempd!=0||tempd1!=0){                    
                        rateLat =tempd;
                        rateLong =tempd1;                
                        Direction_flag='L';
                    }else searchAgain=true;                        
                }
                rs.close();
                if (searchAgain)
                {                    
                    searchAgain=false;
                    sql = "select min(abs(latitude-"+v_Latitude+")),min(abs(longitude-"+v_Longtitude+")) from postcodes_geo where latitude<="+v_Latitude + " and longitude >="+ v_Longtitude;
//                    System.err.println(sql);                
                    rs = stmt.executeQuery(sql);           
                    if (rs.next()) {
                        Double tempd=rs.getDouble(1);
                        Double tempd1=rs.getDouble(2);
                        if (tempd!=0||tempd1!=0){                    
                            rateLat =tempd;
                            rateLong =tempd1;                
                            Direction_flag='S';
                            }else searchAgain=true;                      
                    } 
                    rs.close();                    
                }
            }
            rs.close();
            
//            System.err.println(Direction_flag+"\t"+rateLat+"\t"+rateLong);
            if (rateLat< rateLong)rateLat=rateLong;
            if (rateLat!=0) rateLat*=4;
            
            try {
                double normal_La = v_Latitude.doubleValue();
                double normal_Lo = v_Longtitude.doubleValue();
                double small_La = normal_La;
                double small_Lo =normal_Lo;                
                    if (Direction_flag=='R'){                        
                        small_La+=rateLat;
                        small_Lo+=rateLat;
                        sql = "select postcode,suburb,state,latitude,longitude from postcodes_geo where latitude<=" + Double.toString(small_La) + " and latitude>=" + normal_La + " and longitude>=" + normal_Lo + "  and longitude<=" + Double.toString(small_Lo);
                    } else if (Direction_flag=='L'){
                        small_La-=rateLat;
                        small_Lo-=rateLat;
                        sql = "select postcode,suburb,state,latitude,longitude from postcodes_geo where latitude>=" + Double.toString(small_La) + " and latitude<=" + normal_La + " and longitude<=" + normal_Lo + "  and longitude>=" + Double.toString(small_Lo);
                        
                    }else if (Direction_flag=='S'){
                        small_La-=rateLat;
                        small_Lo+=rateLat;
                        sql = "select postcode,suburb,state,latitude,longitude from postcodes_geo where latitude>=" + Double.toString(small_La) + " and latitude<=" + normal_La + " and longitude>=" + normal_Lo + "  and longitude<=" + Double.toString(small_Lo);                        
                    }else{
                        small_La+=rateLat;
                        small_Lo-=rateLat;
                        sql = "select postcode,suburb,state,latitude,longitude from postcodes_geo where latitude<=" + Double.toString(small_La) + " and latitude>=" + normal_La + " and longitude<=" + normal_Lo + "  and longitude>=" + Double.toString(small_Lo);                                                
                    }
                        
                  //  System.err.println(sql);
                    rs = stmt.executeQuery(sql);
                    if (!rs.next()) {
                        //  System.err.println("geoDB did not find"+v_Latitude+"\t"+ v_Longtitude);                                        
                        rs.close();
                        return getPostCodeByGeo(v_Latitude, v_Longtitude);
                    }
                
                String returnStr[] = new String[2];
                double Max_dis = Double.MAX_VALUE;
                String country_code = "AU";
                String city_code = null;
                String state_code = null;
                String post_code = null;
                do {
                    //Retrieve by column name
                    double x = rs.getDouble("latitude");
                    double y = rs.getDouble("longitude");
                    double dis = Math.sqrt((x - normal_La) * (x - normal_La) + (y - normal_Lo) * (y - normal_Lo));
                    if (dis < Max_dis) {
                        Max_dis = dis;
                        city_code = rs.getString("suburb");
                        state_code = rs.getString("state");
                        post_code = rs.getString("postcode");
                    }
                } while (rs.next());
                
                if (Max_dis > 100) {
                    System.err.println("It is impossible so distance, another country" + Max_dis);
                    return getPostCodeByGeo(v_Latitude, v_Longtitude);
                }
                rs.close();
                
                JSONObject businesses = new JSONObject();
                businesses.put("country_code", "AU");
                businesses.put("city_name", state_code);
                businesses.put("state_code", city_code);
                businesses.put("post_code", post_code);
                
                return businesses;
                
            }  catch (JSONException ex) {
                Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
            }
            return null;
            
        } catch (SQLException ex) {
            Logger.getLogger(FoursquareAPI.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean Close() {
        try {
            if (stmt != null) {
                stmt.close();
            }

        } catch (SQLException ex) {
            System.err.println("mysql close " + ex);
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
                return false;
            }//end finally try            
        }
        return true;
    }

public    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    //static final String DB_URL = "jdbc:mysql://10.33.0.161/twitter";
public    static final String DB_URL = "jdbc:mysql://127.0.0.1/twitter";

    //  Database credentials
public    static final String USER = "zgh";
public    static final String PASS = "mypass";

    private Connection conn = null;
    private Statement stmt = null;

    private double dDouble[]={0,0};
    public double[] getGeoByPostCode(String PostCode) {
        int BaseNum = 10;
        String sql=null;
        try {
            ResultSet rs = null;
//            double normal_La=v_Latitude.doubleValue();
            //          double normal_Lo=v_Longtitude.doubleValue();
            sql = "select postcode,suburb,state,latitude,longitude from postcodes_geo where postcode like '" + PostCode+"'";
            // System.err.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()){
                String returnStr[] = new String[2];
                double Max_dis = Double.MAX_VALUE;
                String country_code = "AU";
                String city_code = null;
                String state_code = null;
                String post_code = null;
                //Retrieve by column name
                double x = rs.getDouble("latitude");
                double y = rs.getDouble("longitude");
                city_code = rs.getString("suburb");
                state_code = rs.getString("state");
                post_code = rs.getString("postcode");
                dDouble[0]=x;
                dDouble[1]=y;
            }
            rs.close();

            return dDouble;

        } catch (SQLException ex) {
            
            System.err.println(sql+"MySQL:getAuStateCity: " + ex);
        }
        return null;
    }

}
