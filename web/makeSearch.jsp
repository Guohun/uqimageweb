<%-- 
    Document   : makeSearch
    Created on : 01/09/2015, 9:04:20 PM
    Author     : uqgzhu1
--%>

<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<HTML> 
         <link href="./css/main.css" rel="stylesheet" type="text/css" >    
    <BODY> 
        <%@include file="header.html" %>
        <%

            // Get username. 
            String email = request.getParameter("email");
            String myTextinput = request.getParameter("myTextinput");

        %> 

        <% if (myTextinput == null || myTextinput.equals("")) { %> 

        <h1> Please enter an email address again.  </h1>

        <% } else {%> 


        Thank you for making search keywords with us.  Your keywords is 
        : <%= myTextinput%> 

        You are made it at <%= new java.util.Date()%> 



        <!--  Also write out some HTML --> 

        Thank you.  
            <% if (email == null || email.equals("")) {
            
                    String result;
                    // Recipient's email ID needs to be mentioned.
                    String to = "u1017412@gmail.com";

                    // Sender's email ID needs to be mentioned
                    String from = "guohun.zhu.phd@ieee.org";

                    // Assuming you are sending email from localhost
                    String host = "localhost";

                    // Get system properties object
                    Properties properties = System.getProperties();

                    // Setup mail server
                    properties.setProperty("mail.smtp.host", host);

                    // Get the default Session object.
                    Session mailSession = Session.getDefaultInstance(properties);

                    try{
                       // Create a default MimeMessage object.
                       MimeMessage message = new MimeMessage(mailSession);
                       // Set From: header field of the header.
                       message.setFrom(new InternetAddress(from));
                       // Set To: header field of the header.
                       message.addRecipient(Message.RecipientType.TO,
                                                new InternetAddress(to));
                       // Set Subject: header field
                       message.setSubject("This is the Subject Line!");

                       // Send the actual HTML message, as big as you like
                       message.setContent("<h1>This is actual message</h1>",
                                             "text/html" );
                       // Send message
                       Transport.send(message);
                       result = "A confirmation email has been sent to your email .."+email +"when it was completed.";                       
                    }catch (MessagingException mex) {
                       mex.printStackTrace();
                       result = "Error: unable to send message....";
                    }            

            %>
             
            <%=result%>                
            
            <%
            }//end email
        }
        %> 
        <%@include file="footer.html" %>


    </BODY> 
</HTML> 