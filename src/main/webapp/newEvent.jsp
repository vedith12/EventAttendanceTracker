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
<title>Add an event - EAM</title>
<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: rgb(3, 17, 34);
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

        .main {
            display: flex;
            display: flex;
            justify-content: center;
            padding-top: 30px;
        }

        .event {
            background-color: aliceblue;
            border-radius: 35px;
            padding: 10px 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 12px;
            color: blue;
        }
        h2 {
        	text-align: center;
            margin-bottom: 12px;
            color: blue;
        }

        .form {
            margin: 12px 0px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .eventName {
            width: 450px;
        }

        .tem {
            display: flex;
            gap: 6px;
        }

        .tem input {
            width: 100%;
        }

        .submit {
            width: 100px;
            padding-left: 0px;
        }

        .add {
            width: 120px;
            height: 30px;
        }

        /* Style for the dynamically added selects */
        .rollnos {
            margin-bottom: 10px;
        }

        select {
            margin-bottom: 10px;
        }
        .rollnos-container {
            display: flex;
            flex-direction: column;
        }
        input, select {
            height: 30px;
            padding-left: 6px;
        }
        .add, .submit {
            border-radius: 900px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 40px;
            background-color: rgb(147, 212, 250);
            color: blue;
            font-weight: bold;
            cursor: pointer;
        }
        .add-submit {
            display: flex;
            flex-direction: column;
            gap: 6px;
            align-items: center;
            width: 100%;
        }
        .event {
            margin-bottom: 10px;
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
    <div class="main">
        <div class="event">
            <h1>Add Event Details</h1>
            <h2>IT-<%= id %></h2>
            <hr>
            <form class="form" action="AddNewEvent" method="POST">
                <input class="eventName" type="text" name="eventName" placeholder="Enter event name">
                <div class="tem">
                    <input type="date" name="date">
                    <input type="number" name="hours" placeholder="Number of hours">
                </div>
                <input type="text" name="proof" placeholder="Enter proof">
                <!-- Container for dynamically added select elements -->
                <div class="rollnos-container">
                    
                </div>
                <input type="hidden" id="rollsCount" name="rollsCount" value="0">
                <div class="add-submit">
                    <button class="add" type="button">Add Roll No.</button>
                    <input class="submit" type="submit">
                </div>
            </form>
        </div>
    </div>
    <script>
        let count = 0;  // Keeps track of the number of select elements

        const addButton = document.querySelector(".add");
        const rollsContainer = document.querySelector(".rollnos-container");
        const rollsCountInput = document.querySelector("#rollsCount");

        // Add event listener to the button
        addButton.addEventListener('click', (event) => {
            event.preventDefault();  // Prevents form submission

            // Create a new <select> element
            const newSelect = document.createElement("select");
            newSelect.name = "rolls" + count;  // Set the name attribute dynamically for each select
            newSelect.id = "rolls" + count;

            // Create new option elements
            const newOption1 = document.createElement("option");
            newOption1.value = "";
            newOption1.textContent = "SELECT";
            newSelect.appendChild(newOption1); // Add the first option

            for (let i = 141; i <= 207; i++) {
                const newOption2 = document.createElement("option");
                const rollNumber = "160123737" + i;  // Combine the full roll number
                newOption2.value = rollNumber;
                newOption2.textContent = rollNumber;
                newSelect.appendChild(newOption2); // Add the second option
            }
            for (let i = 315; i <= 320; i++) {
                const newOption2 = document.createElement("option");
                const rollNumber = "160123737" + i;
                //console.log(rollNumber) // Combine the full roll number
                newOption2.value = rollNumber;
                newOption2.textContent = rollNumber;
                newSelect.appendChild(newOption2); // Add the second option
            }

            // Append the new select dropdown to the rollnos-container
            rollsContainer.appendChild(newSelect);

            // Increment the count to track the next select element
            count++;
            rollsCountInput.value = count;
        });
    </script>
</body>
</html>