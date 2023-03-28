package com.atm;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Deposit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String phone = request.getParameter("phone");
		int deposit=Integer.parseInt(request.getParameter("deposit"));

		try {
			Connection con = ConnectionManager.jdbcConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone = ?");
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) 
			{
				int accNum = rs.getInt("accNum");
				int avail = rs.getInt("available");
				
				avail = avail + deposit;
				
				String fname = rs.getString("firstname");
				String lname = rs.getString("lastname");
				
				String updateQuery = "UPDATE account SET available = ? where accNum = ?";
				PreparedStatement updatePs = con.prepareStatement(updateQuery);
				updatePs.setInt(1, avail);
				updatePs.setInt(2, accNum);
			    updatePs.executeUpdate();
				
			    String insertQuery = "INSERT INTO transaction (transaction_type, transaction_date, amount, accNum, receiverAccNum) VALUES (?, ?, ?, ?, ?)";
			    PreparedStatement insertPs = con.prepareStatement(insertQuery);
			    insertPs.setString(1, "Credit");
			    // set transaction date to current timestamp
			    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
			    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    String date = dateFormat.format(currentTimestamp);
			    insertPs.setString(2, date);
			    // set amount and account number parameters
			    insertPs.setInt(3, deposit);
			    insertPs.setInt(4, accNum);
			    insertPs.setString(5, "-");
			    insertPs.executeUpdate();
			    
			    HttpSession session = request.getSession();
			    session.setAttribute("fname", fname);
				session.setAttribute("lname", lname);
				session.setAttribute("accNum", accNum);
				session.setAttribute("phone", phone);
				session.setAttribute("deposit", deposit);
			    
				RequestDispatcher dispatcher = request.getRequestDispatcher("deposit_display.jsp");
				dispatcher.forward(request, response);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
