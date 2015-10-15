<%-- 
    Document   : mysqlTest
    Created on : 18/09/2015, 4:27:54 PM
    Author     : uqgzhu1
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/twitter"
     user="zgh"  password="mypass"/>

--%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<html>
<head>
<title>SELECT Operation</title>
</head>
<body>
 
 

<sql:query dataSource="jdbc/MyTopic" var="result">
       select postcode,suburb,state,latitude,longitude from postcodes_geo where postcode like '4072';
</sql:query>
 
<table border="1" width="100%">
<tr>
   <th>Emp ID</th>
   <th>First Name</th>
   <th>Last Name</th>
   <th>Age</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td><c:out value="${row.postcode}"/></td>
   <td><c:out value="${row.suburb}"/></td>
   <td><c:out value="${row.state}"/></td>
   <td><c:out value="${row.latitude}"/></td>
</tr>
</c:forEach>
</table>
 
</body>
</html>