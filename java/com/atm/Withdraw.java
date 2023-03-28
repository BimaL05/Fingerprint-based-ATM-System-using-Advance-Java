package com.atm;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String phone = request.getParameter("phone");
		int withdrawAmt = Integer.parseInt(request.getParameter("withdraw"));
		
		try {
			Connection con = ConnectionManager.jdbcConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone = ?");
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();

			HttpSession session = request.getSession();
			if (rs.next()) {
				int accNum = rs.getInt("accNum");
				int avail = rs.getInt("available");
				int withdraw = rs.getInt("withdraw");

				if (withdrawAmt < (avail - withdraw)) {
					withdraw = withdraw + withdrawAmt;

					String fname = rs.getString("firstname");
					String lname = rs.getString("lastname");

					String updateQuery = "UPDATE account SET withdraw = ? where accNum = ?";
					PreparedStatement updatePs = con.prepareStatement(updateQuery);
					updatePs.setInt(1, withdraw);
					updatePs.setInt(2, accNum);
					updatePs.executeUpdate();

					String insertQuery = "INSERT INTO transaction (transaction_type, transaction_date, amount, accNum, receiverAccNum) VALUES (?, ?, ?, ?, ?)";
					PreparedStatement insertPs = con.prepareStatement(insertQuery);
					insertPs.setString(1, "Debit");
					// set transaction date to current timestamp
					Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String date = dateFormat.format(currentTimestamp);
					insertPs.setString(2, date);
					insertPs.setInt(3, withdrawAmt);
					insertPs.setInt(4, accNum);
					insertPs.setString(5, "-");
					insertPs.executeUpdate();

					int amount = withdrawAmt;
					
					session.setAttribute("fname", fname);
					session.setAttribute("lname", lname);
					session.setAttribute("accNum", accNum);
					session.setAttribute("phone", phone);
					session.setAttribute("withdrawAmt", amount);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("withdraw_display.jsp");
					dispatcher.forward(request, response);	
				}
				else {
					 request.setAttribute("error", "Balance not available !");
					 RequestDispatcher dispatcher = request.getRequestDispatcher("withdraw.jsp");
			         dispatcher.forward(request, response); 
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
