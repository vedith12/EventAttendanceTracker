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
import java.sql.SQLException;

/**
 * Servlet implementation class AddNewEvent
 */
//@WebServlet("/AddNewEvent")
public class AddNewEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewEvent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			int count = Integer.parseInt(request.getParameter("rollsCount"));
			for(int i = 0; i < count; i++) {
				PreparedStatement ps = conn.prepareStatement("INSERT INTO records (roll, name, date, hours, proof, section_id) VALUES (?, ?, ?, ?, ?, ?)");
				ps.setString(1, request.getParameter("rolls" + i));
				ps.setString(2, request.getParameter("eventName"));
				ps.setString(3, request.getParameter("date"));
				ps.setInt(4, Integer.parseInt(request.getParameter("hours")));
				ps.setString(5, request.getParameter("proof"));
				ps.setInt(6, id);
				int nr = ps.executeUpdate();
				if (nr >= 1) {
					//
				} else {
					response.sendRedirect("newEvent.jsp?status=failed");
					return;
				}
			}
			response.sendRedirect("newEvent.jsp?status=success");
			
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
