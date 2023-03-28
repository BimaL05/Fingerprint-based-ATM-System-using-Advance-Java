package com.atm;

import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Balance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String phone = request.getParameter("phone");

		try {
			Connection con = ConnectionManager.jdbcConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM account JOIN customer ON account.customer_id=customer.customer_id WHERE customer.phone = ?");
			ps.setString(1, phone);
			ResultSet rs = ps.executeQuery();
			HttpSession session = request.getSession();
			
			if (rs.next()) {
				int accNum = rs.getInt("accNum");
				int avail = rs.getInt("available");
				int withdraw = rs.getInt("withdraw");
				
				int balance = avail - withdraw;
				
				String fname = rs.getString("firstname");
				String lname = rs.getString("lastname");
				
				session.setAttribute("fname", fname);
				session.setAttribute("lname", lname);
				session.setAttribute("accNum", accNum);
				session.setAttribute("phone", phone);
				session.setAttribute("avail", balance);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("balance_display.jsp");
				dispatcher.forward(request, response);
/*
				PrintWriter out = response.getWriter();
				
/*			String query2 = "SELECT * from account where phone=" + ph + " ";
				Statement st2 = con.createStatement();
				ResultSet rs2 = st2.executeQuery(query2);
				
				response.setContentType("text/html");

				out.println("<html><head>	<link rel=\"stylesheet\" type=\"text/css\" href=\"\" ></link>	</head>");
				out.println("<body style='background-color: #B5B3B3;'>");

				out.println("<div style=' font-family: Arial, sans-serif;display: flex;flex-direction: column;align-items: center; justify-content: center;height: 60vh;line-height:0;font-size: 20px;font-weight: bolder; '>");
				out.println("<p><u> Balance Details </u></p><hr>");
				out.println("<p>Account Name: " + fname + " " + lname + "</p>");
				out.println("<p>Account Number: " + accNum + "</p><hr>");
				out.println("</div>");

				out.println("</body>");
				out.println("</html>");
*/
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}

	}
}
