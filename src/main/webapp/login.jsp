<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - EAM</title>
<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: rgb(3, 17, 34);;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login {
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
        .submit-btn {
        	padding: 4px;
        	cursor: pointer;
        }
        .error-msg {
        	color: red;
        	margin-top: 2px;
        }
    </style>
</head>
<body>
	<div class="login">
        <img src="CBIT-LOGO.png" alt="cbit">
        <h1>Department Of Information Technology</h1>
        <form class="form" action="LoginServlet" method="POST">
            <select class="section" name="section">
                <option value="" disabled selected>Select</option>
                <option value="it1">IT-1</option>
                <option value="it2">IT-2</option>
                <option value="it3">IT-3</option>
            </select> <br>
            <input class="pass" name="password" type="password" placeholder="Enter Password"><br>
            <input class="submit-btn" type="submit" placeholder="submit">
        </form>
        <!-- Display error message if the 'error' query parameter is present -->
        <c:if test="${param.error != null}">
            <div class="error-msg">${param.error}</div>
        </c:if>
    </div>
</body>
</html>