<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	HttpSession sess = request.getSession(false);
    //	HttpSession session = request.getSession(false); // Get the session without creating a new one
    if (sess == null || sess.getAttribute("id") == null) {
        // No session or username attribute, redirect to login page
        response.sendRedirect("login.jsp");
        return;
    } 
        // Session exists, display welcome message
        Integer id = (Integer) session.getAttribute("id");
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Navigate - EAM</title>
<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: rgb(3, 17, 34);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .margin {
            background-color: white;
            padding: 35px;
            border-radius: 25px;
            display: flex;
            flex-direction: column;
        }
        .pass {
            margin: 10px 0px;
            height: 25px;
            padding: 5px;
        }
        .section {
            height: 25px;
        }
        h1 {
            margin-bottom: 10px;
            color: rgb(180, 19, 19);
        }
        img {
            height: 100px;
        }
        .links {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 10px;
            font-size: 18px;
            gap: 8px
        }
        a {
            text-decoration: none; 
            color: rgb(50, 119, 50); 
            font-weight: bold;
        }
        a:visited {
            text-decoration: none; 
            color: rgb(50, 119, 50); 
            font-weight: bold;
        }
        h1 {
            margin-bottom: 10px;
            color: rgb(180, 19, 19);
        }
        h2 {
        	text-align: center;'
        }
    </style>
</head>
<body>
	<div class="margin">
        <img src="CBIT-LOGO.png" alt="cbit">
        <h1>Department Of Information Technology</h1>
        <h2>IT-<%= id %></h2>
        <div class="links">
            <a href="newEvent.jsp">Enter new event details</a>
            <a href="ViewAllRecords">View event details</a>
        </div>
    </div>
</body>
</html>