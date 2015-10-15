/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mytopicdetected;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author uqgzhu1
 */
@WebServlet(name = "showtopicstrees", urlPatterns = {"/showtopicstrees"})
public class showTopicsTreesServlet extends HttpServlet {
    private DataSource ds=null;

    /**
     * @see Servlet#init(ServletConfig)
     */
    public void init(ServletConfig config) throws ServletException {
        try {
            InitialContext initContext = new InitialContext();

            Context env = (Context)initContext.lookup("java:comp/env");

            ds = (DataSource) env.lookup("jdbc/MyTopic");

        } catch (NamingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            String ExportTopicName = request.getParameter("KeyTopics");
            String postcode = request.getParameter("postcode");
            HttpSession tempSession=request.getSession();
            String menuCmd=(String)tempSession.getAttribute("cmd");
            
            Connection conn = ds.getConnection();
            
            //Class.forName(util.FoursquareAPI.JDBC_DRIVER);
            //conn = DriverManager.getConnection(util.FoursquareAPI.DB_URL, "zgh", "mypass");
              
            // create a sql date object so we can use it in our INSERT statement
            Calendar calendar = Calendar.getInstance();
            java.sql.Date startDate = new java.sql.Date(calendar.getTime().getTime());
            // the mysql insert statement   date_created, date_ended, 
            StringBuffer query = new StringBuffer(" select  P_Name,date_created, Postcode, KeywordList, WeightList, TwIdList, TwNumber  from TopicsTweets");
            if (ExportTopicName!=null&&!ExportTopicName.isEmpty()){
                query.append(" where P_Name like '" );
                query.append(ExportTopicName );
                query.append('\'' );
            }else{
                if (menuCmd != null&&!menuCmd.contains("root")) {
                    query.append(" where P_Name like '" );
                    query.append(menuCmd );
                    query.append('\'' );

                }                
            }
            
            System.out.println(query);
            // create the mysql insert preparedstatement
            Statement stmt = conn.createStatement();

            ResultSet rs = stmt.executeQuery(query.toString());

            // Extract data from result set
            TopicTree myTree = new TopicTree();
            while (rs.next()) {
                //Retrieve by column name
                String KeywordList = rs.getString("KeywordList");
                int TwNumber = rs.getInt("TwNumber");

                String TwIdList = rs.getString("TwIdList");
                String Postcode = rs.getString("Postcode");
                
//                System.out.println(ExportTopicName + "\t into :" + tempStr + "\t" + valueStr + "\t" + twListStr);
                String tempKeywords[]=KeywordList.split(",");
                for (String keyword:tempKeywords)
                    myTree.addTopic(keyword, Double.valueOf(TwNumber), 'X', Postcode, TwIdList);

                //Display values
            }

            // Clean-up environment
            rs.close();
            stmt.close();
            conn.close();

            try {

            //    out.println("<!DOCTYPE html>");
          //      out.println("<html>");
        //        out.println("<head>");
      //          out.println("<title>Servlet showTopicsTreesServlet</title>");
    //            out.println("</head>");
  //              out.println("<body>");
//                out.println("<h1>Servlet showTopicsTreesServlet at " + request.getContextPath() + "</h1>");
                out.println(myTree.prntJson());
              //  out.println("</body>");
                //out.println("</html>");
            } finally {
                out.close();
            }

        }  catch (SQLException ex) {
            Logger.getLogger(showTopicsTreesServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
