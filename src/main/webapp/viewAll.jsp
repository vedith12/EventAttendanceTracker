<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.List, java.util.Map" %>
 
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
<title>View all details</title>
<script>
    function makeRowClickable(url) {
        window.location.href = url;
    }
</script>
<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f8f9fa; /* Light gray background */
            font-family: Arial, sans-serif;
        }
        nav {
            display: flex;
            justify-content: space-between;
            background-color: aliceblue;
            padding: 10px;
        }

        .logo {
            height: 50px;
        }

        .btns {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btns a {
            text-decoration: none;
            height: 100%;
        }

        .button {
            height: 100%;
            background-color: rgb(193, 226, 255);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            border-radius: 20px;
            color: blue;
            font-weight: bold;
            font-size: 16px;
        }
        h1 {
            text-align: center;
            margin-top: 10px;
        }
        /* Basic table styling */
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        thead {
            background-color: #4CAF50;
            /* Dark green for the header */
            color: white;
        }

        thead th {
            padding: 12px;
            font-size: 1.1em;
        }

        tbody tr {
            text-align: center;
            cursor: pointer;
        }

        tbody td {
            padding: 10px;
            border: 1px solid #dddddd;
        }

        /* Alternating row colors */
        tbody tr:nth-child(even) {
            background-color: #f2f2f2;
            /* Light gray */
        }

        tbody tr:nth-child(odd) {
            background-color: #ffffff;
            /* White */
        }

        /* Hover effect for rows */
        tbody tr:hover {
            background-color: #d1e7dd;
            /* Light green on hover */
        }

        /* Optional: Styling for table borders */
        table,
        th,
        td {
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <nav>
        <img class="logo" src="CBIT-LOGO.png" alt="">
        <div class="btns">
            <a href="newEvent.jsp">
                <div class="button">
                    New Event
                </div>
            </a>
            <a href="ViewAllRecords">
                <div class="button">
                    View Events
                </div>
            </a>
            <a href="LogoutServlet">
                <div class="button">
                    Logout
                </div>
            </a>
        </div>
    </nav>
    <main>
        <h1>Event Attendance of IT - <%= id %></h1>
        <table>
            <thead>
                <tr>
                    <th>Roll Numbers</th>
                    <th>Number of Hours</th>
                </tr>
            </thead>
            <tbody>
                 <%
                    List<Map<String, Object>> records = (List<Map<String, Object>>) request.getAttribute("records");

                    if (records != null) {
                        for (Map<String, Object> record : records) {
                            String roll = record.get("roll").toString();
                            String total = record.get("total").toString();
                %>
                    <tr onclick="makeRowClickable('ViewIndividualRoll?roll=<%= roll %>')">
                        <td><%= roll %></td>
                        <td><%= total %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="2">No records found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </main>
</body>
</html>