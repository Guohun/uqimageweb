/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package keyTopicPkg;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author uqgzhu1
 */
@WebServlet(name = "ueserkeywords", urlPatterns = {"/ueserkeywords"})
public class UeserInputKeywordsServlet extends HttpServlet {

    private ServletContext context;
    private UserTopicInputData compData = new UserTopicInputData();
    private HashMap <String, UserDefineKeywords> composers = compData.getDefineTopics();

    @Override
    public void init(ServletConfig config) throws ServletException {
     //   super.init(config); //To change body of generated methods, choose Tools | Templates.
        this.context = config.getServletContext();
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String targetId = request.getParameter("id");
        StringBuffer sb = new StringBuffer();
        
        if (targetId==null) targetId="3";
        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            context.getRequestDispatcher("/error.jsp").forward(request, response);
        }

         boolean namesAdded = false;
         
        JSONArray tempArray=new JSONArray();
     if (action==null||action.equals("complete")) {

        // check if user sent empty string
        if (!targetId.equals("")) {

            Iterator it = composers.keySet().iterator();
            
                
            while (it.hasNext()) {
                String id = (String) it.next();
                UserDefineKeywords composer =  composers.get(id);

                {
                    try//                if ( composer.getTopicName().toLowerCase().startsWith(targetId) ||
                    //                   composer.getKeywordsName().toLowerCase().concat(" ")
                    //                    .concat(composer.getCategory().toLowerCase()).startsWith(targetId))
                    {
                       // System.out.println(id);
                        JSONObject temp=new JSONObject();
                        temp.put("id", composer.getTopicName());
                        temp.put("Keywords", composer.getKeywordsName());
                        temp.put("Category", composer.getCategory());
                        tempArray.put(temp);
                        namesAdded = true;
                    } catch (JSONException ex) {
                        Logger.getLogger(UeserInputKeywordsServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }

        if (namesAdded) {
      //      response.setContentType("text/xml");
    //        response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write(tempArray.toString());
            System.out.println(tempArray.toString());
        } else {
            //nothing to show
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }
    }
/*    if (action.equals("lookup")) {

        // put the target composer in the request scope to display 
        if ((targetId != null) && composers.containsKey(targetId.trim())) {
            request.setAttribute("composer", composers.get(targetId));
            context.getRequestDispatcher("/composer.jsp").forward(request, response);
        }
    }
*/
     /*        response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         try {
  
         out.println("<!DOCTYPE html>");
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet UeserInputKeywords</title>");            
         out.println("</head>");
         out.println("<body>");
         out.println("<h1>Servlet UeserInputKeywords at " + request.getContextPath() + "</h1>");
         out.println("</body>");
         out.println("</html>");
         } finally {
         out.close();
         }
         */
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
    protected void XMLprocessRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String targetId = request.getParameter("id");
        StringBuffer sb = new StringBuffer();
        
        if (targetId==null) targetId="3";
        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            context.getRequestDispatcher("/error.jsp").forward(request, response);
        }

         boolean namesAdded = false;
         

     if (action==null||action.equals("complete")) {

        // check if user sent empty string
        if (!targetId.equals("")) {

            Iterator it = composers.keySet().iterator();

            while (it.hasNext()) {
                String id = (String) it.next();
                UserDefineKeywords composer =  composers.get(id);

//                if ( composer.getTopicName().toLowerCase().startsWith(targetId) ||
  //                   composer.getKeywordsName().toLowerCase().concat(" ")
    //                    .concat(composer.getCategory().toLowerCase()).startsWith(targetId)) 
                {
                    System.out.println(id);
                    sb.append("<composer>");
                    sb.append("<id>" + composer.getTopicName() + "</id>");
                    sb.append("<firstName>" + composer.getKeywordsName() + "</firstName>");
                    sb.append("<lastName>" + composer.getCategory() + "</lastName>");
                    sb.append("</composer>");
                    namesAdded = true;
                }
            }
        }

        if (namesAdded) {
            response.setContentType("text/xml");
            response.setHeader("Cache-Control", "no-cache");
            response.getWriter().write("<composers>" + sb.toString() + "</composers>");
                                System.out.println(sb.toString());
        } else {
            //nothing to show
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }
    }
/*    if (action.equals("lookup")) {

        // put the target composer in the request scope to display 
        if ((targetId != null) && composers.containsKey(targetId.trim())) {
            request.setAttribute("composer", composers.get(targetId));
            context.getRequestDispatcher("/composer.jsp").forward(request, response);
        }
    }
*/
     /*        response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         try {
  
         out.println("<!DOCTYPE html>");
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet UeserInputKeywords</title>");            
         out.println("</head>");
         out.println("<body>");
         out.println("<h1>Servlet UeserInputKeywords at " + request.getContextPath() + "</h1>");
         out.println("</body>");
         out.println("</html>");
         } finally {
         out.close();
         }
         */
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
