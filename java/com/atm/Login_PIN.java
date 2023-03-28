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
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Login_PIN extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String phone=request.getParameter("phone"); 
		 String pin=request.getParameter("pin");
		 
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet=null;
		RequestDispatcher rd=null;
		HttpSession session=request.getSession();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = ConnectionManager.jdbcConnection();
	
			PreparedStatement ps = connection.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone = ? and customer.pin = ?");
			 ps.setString(1, phone);
			 ps.setString(2, pin);	
			 resultSet = ps.executeQuery();
			 
			if(resultSet.next()) 
			{
				String fname = resultSet.getString("firstname");
				String lname = resultSet.getString("lastname");
				int accNum = resultSet.getInt("accNum");
				
				session.setAttribute("fname", fname);
				session.setAttribute("lname", lname);
				session.setAttribute("accNum", accNum);
				session.setAttribute("phone", phone);
				
				rd=request.getRequestDispatcher("menu.jsp");
				rd.forward(request, response);
			}
			else 
			{		  
				 request.setAttribute("status", "failed");
				 rd=request.getRequestDispatcher("loginPIN.jsp");
				 rd.forward(request, response);
			}
		} 
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
