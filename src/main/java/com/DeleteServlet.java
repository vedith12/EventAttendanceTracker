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
 * Servlet implementation class DeleteServlet
 */
//@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteServlet() {
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
			Integer event_id = Integer.parseInt(request.getParameter("e_id"));
			PreparedStatement ps = conn.prepareStatement("DELETE FROM records WHERE id=?");
			ps.setInt(1, event_id);
			int nr = ps.executeUpdate();
			if(nr >= 1) {
				response.sendRedirect("ViewIndividualRoll?roll=" + request.getParameter("roll") +"&deleted=true");
			} else {
				response.sendRedirect("ViewIndividualRoll?roll=" + request.getParameter("roll") +"&deleted=false");
			}
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
