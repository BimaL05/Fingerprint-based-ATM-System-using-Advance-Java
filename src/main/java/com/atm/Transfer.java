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
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Transfer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String phone = request.getParameter("phone");
		int accNum = Integer.parseInt(request.getParameter("accNum"));
		int accNum2 = Integer.parseInt(request.getParameter("accNum2"));
		int transfer=Integer.parseInt(request.getParameter("transfer"));

		Connection con = null;

		try {
		    con = ConnectionManager.jdbcConnection();
		    PreparedStatement ps = con.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone=? AND account.accNum=?");
		    ps.setString(1, phone);
		    ps.setInt(2, accNum);
		    ResultSet rs = ps.executeQuery();

		    if(rs.next()) {
		        int avail = rs.getInt("available");
		        int withdraw = rs.getInt("withdraw");
		       // String fname = rs.getString("firstname");
		        //String lname = rs.getString("lastname");

		        // Prepare a statement to retrieve the available balance of the receiver account
		        PreparedStatement ps2 = con.prepareStatement("SELECT available FROM account WHERE accNum=?");
		        ps2.setInt(1, accNum2);
		        ResultSet rs2 = ps2.executeQuery();

		        if(rs2.next()) {
		            int receiverAvail = rs2.getInt("available");

		            // Start a transaction to update the balances of the sender and receiver accounts
		            con.setAutoCommit(false);

		            if (transfer < (avail - withdraw)) {

		                // Update the sender account balance
		                ps = con.prepareStatement("UPDATE account SET withdraw = ? WHERE accNum = ?");
		                ps.setInt(1, withdraw + transfer);
		                ps.setInt(2, accNum);
		                ps.executeUpdate();
		                ps.close();

		                // Update the receiver account balance
		                ps2 = con.prepareStatement("UPDATE account SET available = ? WHERE accNum = ?");
		                ps2.setInt(1, receiverAvail + transfer);
		                ps2.setInt(2, accNum2);
		                ps2.executeUpdate();
		                ps2.close();

		                ps = con.prepareStatement("INSERT INTO transaction (transaction_type, transaction_date, amount, accNum,receiverAccNum) VALUES (?, ?, ?,?,?)");
		                ps.setString(1, "Transfer");
		                Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
		                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		                String date = dateFormat.format(currentTimestamp);
		                ps.setString(2, date);
		                ps.setInt(3, transfer);
		                ps.setInt(4, accNum);
		                ps.setInt(5, accNum2);
		                ps.executeUpdate();
		                ps.close();

		                // Commit the transaction
		                con.commit();

		                HttpSession session = request.getSession();
		                //session.setAttribute("fname", fname);
		                //session.setAttribute("lname", lname);
		                session.setAttribute("accNum", accNum);
		                session.setAttribute("phone", phone);
		                session.setAttribute("transfer", transfer);

		                RequestDispatcher dispatcher = request.getRequestDispatcher("transfer_display.jsp");
		                dispatcher.forward(request, response);
		            }
		            else {
						request.setAttribute("error", "Balance not available !");
						RequestDispatcher dispatcher = request.getRequestDispatcher("transfer.jsp");
						dispatcher.forward(request, response); 
		            }
		        }
		        else {
					request.setAttribute("error", "Invalid Account No !");
					RequestDispatcher dispatcher = request.getRequestDispatcher("transfer.jsp");
					dispatcher.forward(request, response); 
	            }
		    }
		}
		catch (SQLException e) {
		    // Something went wrong, rollback the transaction
		    if (con != null) {
		        try {
		            con.rollback();
		        } catch (SQLException ex) {
		            ex.printStackTrace();
		        }
		    }
		    e.printStackTrace();
		} 
		catch (Exception e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}

	}
}
