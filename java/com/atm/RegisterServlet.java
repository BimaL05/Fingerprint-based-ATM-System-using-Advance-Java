package com.atm;

import java.io.File;
import java.io.InputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class RegisterServlet extends HttpServlet{
	
	public boolean checkDuplicate(String phone, String accNum, Connection con) throws SQLException {
        PreparedStatement st = null;
        ResultSet rs = null;
        boolean isDuplicate = false;
        
        try {
            String query = "SELECT * FROM customer c INNER JOIN account a ON c.customer_id = a.customer_id WHERE c.phone=? OR a.accNum=?";
            st = con.prepareStatement(query);
            st.setString(1, phone);
            st.setString(2, accNum);
            rs = st.executeQuery();
            
            if (rs.next()) {
                isDuplicate = true;
            }
        } 
        finally {
            if (rs != null)
            	rs.close();
            if (st != null) 
            	st.close();
        }
        return isDuplicate;
	}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
    	
        res.setContentType("text/html;charset=UTF-8");
        PrintWriter out = res.getWriter();
        
        RequestDispatcher rd;
        
        String title=req.getParameter("title");
		String firstname=req.getParameter("firstname");
		String middlename=req.getParameter("middlename");
		String lastname=req.getParameter("lastname");
		String phone=req.getParameter("phone");
		String pin=req.getParameter("pin");
		String accNum=req.getParameter("accNum");
		String accType=req.getParameter("accType");
		String email=req.getParameter("email");
		String gender=req.getParameter("gender");
		String DOB=req.getParameter("DOB");
		String address=req.getParameter("address");
		String address2=req.getParameter("address2");
		String city=req.getParameter("city");
		String state=req.getParameter("state");
		String country=req.getParameter("country");
		String postalCode=req.getParameter("postalCode");

		InputStream inputStream = null; // input stream of the upload file
		Connection con = null;
		
        Part filePart = req.getPart("finger");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = ConnectionManager.jdbcConnection();
            
            // Check for duplicate customer
            if (checkDuplicate(phone, accNum, con)) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('User already exists.');");
                out.println("location='registration.jsp';");
                out.println("</script>");
                return;
            }

            // Prepare parameterized query for customer insertion
            String customerInsertQuery = "INSERT INTO customer (title, firstname, middlename, lastname, phone, pin, email, gender, DOB, address, address2, city, state, country, postalCode, fingerprint) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement customerInsertStatement = con.prepareStatement(customerInsertQuery, Statement.RETURN_GENERATED_KEYS);
            customerInsertStatement.setString(1, title);
            customerInsertStatement.setString(2, firstname);
            customerInsertStatement.setString(3, middlename);
            customerInsertStatement.setString(4, lastname);
            customerInsertStatement.setString(5, phone);
            customerInsertStatement.setString(6, pin);
            customerInsertStatement.setString(7, email);
            customerInsertStatement.setString(8, gender);
            customerInsertStatement.setString(9, DOB);
            customerInsertStatement.setString(10, address);
            customerInsertStatement.setString(11, address2);
            customerInsertStatement.setString(12, city);
            customerInsertStatement.setString(13, state);
            customerInsertStatement.setString(14, country);
            customerInsertStatement.setString(15, postalCode);
            customerInsertStatement.setBlob(16, inputStream);
            
            int customerInsertCount = customerInsertStatement.executeUpdate();
            
            if (customerInsertCount == 0) {
                rd = req.getRequestDispatcher("registration.jsp");
                rd.forward(req, res);
            } 
            else {
                ResultSet generatedKeys = customerInsertStatement.getGeneratedKeys();
                int customerId = 0;
                if (generatedKeys.next()) {
                    customerId = generatedKeys.getInt(1);
                }

                // Prepare parameterized query for account insertion
                String accountInsertQuery = "INSERT INTO account (accNum, customer_id, accType, available, withdraw) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement accountInsertStatement = con.prepareStatement(accountInsertQuery);
                accountInsertStatement.setString(1, accNum);
                accountInsertStatement.setInt(2, customerId);
                accountInsertStatement.setString(3, accType);
                accountInsertStatement.setInt(4, 0);
                accountInsertStatement.setInt(5, 0);
                accountInsertStatement.executeUpdate();

                rd = req.getRequestDispatcher("loginFinger.jsp");
                rd.forward(req, res);
            }
        }
        catch (Exception e) {
            out.println(e);
        } 
        finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }

    }
}