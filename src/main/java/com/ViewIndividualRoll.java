package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@WebServlet("/ViewIndividualRoll")
public class ViewIndividualRoll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ViewIndividualRoll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Integer id;
			HttpSession session = request.getSession(false); // 'false' means don't create a new session if one doesn't exist

		    if (session != null) {
		        id = (Integer) session.getAttribute("id");
		        if (id == null) {
		        	response.sendRedirect("login.jsp");
		        	return;
		        }
		    } else {
		        response.sendRedirect("login.jsp");
		        return;
		    }

			// Get the roll number from the request
			String roll = request.getParameter("roll");
			if (roll == null || roll.isEmpty()) {
				response.sendRedirect("viewallrecords.jsp"); // Redirect if roll number is missing
				return;
			}

			// Database connection
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eam", "root", "admin");

			// Prepare SQL query to fetch individual records for the roll number
			PreparedStatement ps = conn.prepareStatement("SELECT id, name, hours, date, proof FROM records WHERE roll = ?");
			ps.setString(1, roll);

			ResultSet rs = ps.executeQuery();
			
			// Store results in a list of maps
			List<Map<String, Object>> eventList = new ArrayList<>();
			while (rs.next()) {
				Map<String, Object> event = new HashMap<>();
				event.put("e_id", rs.getInt("id"));
				event.put("name", rs.getString("name"));
				event.put("hours", rs.getInt("hours"));
				event.put("date", rs.getDate("date"));
				event.put("proof", rs.getString("proof"));
				eventList.add(event);
			}

			// Close the resources
			rs.close();
			ps.close();
			conn.close();

			// Pass the event list and roll number to the JSP page
			request.setAttribute("eventList", eventList);
			request.setAttribute("roll", roll);

			// Forward request to the JSP page for display
			request.getRequestDispatcher("viewIndi.jsp").forward(request, response);

		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
