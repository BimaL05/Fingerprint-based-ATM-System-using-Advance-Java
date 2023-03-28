package com.atm;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.imageio.ImageIO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/LoginFinger")
@MultipartConfig
public class Login_Finger extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String phone = request.getParameter("phone");
		Part imagePart = request.getPart("finger");
		BufferedImage inputImage = ImageIO.read(imagePart.getInputStream());
		
	//	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	//	response.setHeader("Pragma", "no-cache");
	//	response.setDateHeader("Expires", 0);
		
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		RequestDispatcher rd = null;
		HttpSession session = request.getSession();
		

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = ConnectionManager.jdbcConnection();
			statement = connection.prepareStatement("SELECT * FROM customer JOIN account ON customer.customer_id=account.customer_id WHERE customer.phone = ?");
			statement.setString(1, phone);
			resultSet = statement.executeQuery();
			
			if (resultSet.next()) {
				BufferedImage referenceImage = ImageIO.read(resultSet.getBinaryStream("fingerprint"));
				if (compareImages(inputImage, referenceImage)) {
					// Login success
					
					String fname = resultSet.getString("firstname");
					String lname = resultSet.getString("lastname");
					int accNum = resultSet.getInt("accNum");
					
					session.setAttribute("fname", fname);
					session.setAttribute("lname", lname);
					session.setAttribute("accNum", accNum);
					session.setAttribute("phone", phone);
					
					rd = request.getRequestDispatcher("menu.jsp");
					rd.forward(request, response);
				} 
				else {
					// Login failed
					request.setAttribute("error", "Invalid Phone No. or Fingerprint"); // Invalid Phone no. or // Fingerprint
					request.getRequestDispatcher("loginFinger.jsp").forward(request, response);
				}
			} else {
				// Phone number not found
				request.setAttribute("error", "Incorrect Phone No."); // Incorrect Phone no.
				request.getRequestDispatcher("loginFinger.jsp").forward(request, response);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// Fingerprint not found
			try {
				if (resultSet != null)
					resultSet.close();
				if (statement != null)
					statement.close();
				if (connection != null)
					connection.close();
				if ((imagePart.getSize() == 0)) {
					request.setAttribute("error", "Incorrect Fingerprint");
					request.getRequestDispatcher("loginFinger.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private boolean compareImages(BufferedImage image1, BufferedImage image2) {
		// Compare the dimensions of the two images
		//if (image1.getWidth() != image2.getWidth() || image1.getHeight() != image2.getHeight()) {
	//		return false;
		//}

		// Get the histograms of the two images
		int[] histogram1 = getHistogram(image1);
		int[] histogram2 = getHistogram(image2);

		// Compare the histograms
		double sum = 0;
		for (int i = 0; i < 256; i++) {
			sum += Math.abs(histogram1[i] - histogram2[i]);
		}

		// Return true if the histograms are equal (sum is close to zero)
		return sum < 0.1;
	}

	private int[] getHistogram(BufferedImage image) {
		// Initialize the histogram
		int[] histogram = new int[256];
		for (int i = 0; i < 256; i++) {
			histogram[i] = 0;
		}

		// Calculate the histogram
		for (int x = 0; x < image.getWidth(); x++) {
			for (int y = 0; y < image.getHeight(); y++) {
				int color = image.getRGB(x, y) & 0xff;
				histogram[color]++;
			}
		}

		return histogram;
	}

}
