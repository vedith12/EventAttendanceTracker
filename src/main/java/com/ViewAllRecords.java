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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet implementation class ViewAllRecords
 */
//@WebServlet("/ViewAllRecords")
public class ViewAllRecords extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewAllRecords() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			Integer id;
			 HttpSession session = request.getSession(false); // 'false' means don't create a new session if one doesn't exist

		        if (session != null) {
		            // Invalidate the session to clear all session data
		            id = (Integer) session.getAttribute("id");
		        } else {
		        // Redirect to the login page or home page after logging out
		        	response.sendRedirect("login.jsp");
		        	return;
		        }
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eam", "root", "admin");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT roll, SUM(hours) as total FROM records GROUP BY roll ORDER BY roll ASC");
			 // Store the results in a list of maps (you could also use a custom object)
            List<Map<String, Object>> records = new ArrayList<>();

            while (rs.next()) {
                Map<String, Object> record = new HashMap<>();
                record.put("roll", rs.getString("roll"));
                record.put("total", rs.getInt("total"));
                records.add(record);
            }

            // Pass the result set data to the JSP
            request.setAttribute("records", records);

            // Forward to JSP
            request.getRequestDispatcher("viewAll.jsp").forward(request, response);
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
