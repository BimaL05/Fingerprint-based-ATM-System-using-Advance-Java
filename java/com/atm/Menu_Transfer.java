package com.atm;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Menu_Transfer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String phone = (String) session.getAttribute("phone");

		Connection con = null;
		PreparedStatement statement = null;
		ResultSet result = null;

		try {
			con = ConnectionManager.jdbcConnection();
			statement = con.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone = ?");
			statement.setString(1, phone);

			// Execute the query
			result = statement.executeQuery();

			// Process the result
			if (result.next()) {
			    String fname = result.getString("firstname");
			    String lname = result.getString("lastname");
			    int accNum = result.getInt("accNum");

			    session.setAttribute("fname", fname);
			    session.setAttribute("lname", lname);
			    session.setAttribute("accNum", accNum);
			    session.setAttribute("phone", phone);

			    RequestDispatcher dispatcher = request.getRequestDispatcher("transfer.jsp");
			    dispatcher.forward(request, response);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
