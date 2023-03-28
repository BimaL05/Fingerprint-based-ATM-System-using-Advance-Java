package com.atm;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/personalInformation")
public class PersonalInformation extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//int phone = Integer.parseInt(request.getParameter("phone"));
		HttpSession session = request.getSession();
		String phone = (String) session.getAttribute("phone");

		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			con = ConnectionManager.jdbcConnection();
			st = con.prepareStatement("SELECT * FROM account JOIN customer ON account.customer_id=customer.customer_id WHERE customer.phone = ?");
			st.setString(1, phone);
			
			rs = st.executeQuery();

			if (rs.next()) {
				String firstname = rs.getString("firstname");
				String lastname = rs.getString("lastname");
				int accNum = rs.getInt("accNum");
				String accType = rs.getString("accType");
				String gender = rs.getString("gender");
				String email = rs.getString("email");
				String DOB = rs.getString("DOB");
				String address = rs.getString("address");
				String city = rs.getString("city");
				String state = rs.getString("state");
				String country = rs.getString("country");
				String postalCode= rs.getString("postalCode");
				
				session.setAttribute("firstname", firstname);
				session.setAttribute("lastname", lastname);
				session.setAttribute("accNum", accNum);
				session.setAttribute("accType", accType);
				session.setAttribute("phone", phone);
				session.setAttribute("gender", gender);
				session.setAttribute("email", email);
				session.setAttribute("DOB", DOB);
				session.setAttribute("address", address);
				session.setAttribute("city", city);
				session.setAttribute("state", state);
				session.setAttribute("country", country);
				session.setAttribute("postalCode", postalCode);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("personal_information.jsp");
				dispatcher.forward(request, response);
	/*			
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("<h1> <u> Personal Information</u></h1><hr>");
				out.println("<br><hr>Account Name :" + firstname + " " + lastname);
				out.println("<br><hr>Account Number :" + accNum);
				out.println("<br><hr>Account Type :" + accType);
				out.println("<h3><br>Phone Number:" + phone);
				out.println("<br><hr>E-mail :" + email);
				out.println("<br><hr>Date of Birth: " + DOB);
				out.println("<br><hr>Gender :" + gender);
				out.println("<br><hr>Address :" + address + "," + city +"," + state + "-" + postalCode);
				out.println("<br><hr>Country :" + country);
*/
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
