package com.atm;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		session.removeAttribute("phone");
		session.invalidate();
		
		// cache control headers to prevent caching of this page
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.
        response.setHeader("Surrogate-Control", "no-store");
		
        response.sendRedirect("loginFinger.jsp");


//        response.sendRedirect("loginFinger.jsp?nonce=" + System.currentTimeMillis());
		// response.setHeader("Cache-Control", "no-store");
		/*
		 * PrintWriter out = response.getWriter(); out.
		 * println("<script src=\"http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js\"></script>"
		 * ); out.
		 * println("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js\"></script>"
		 * ); out.println("$(document).ready(function () {\r\n" +
		 * "	            function disableBack() {\r\n" +
		 * "	                window.history.forward()\r\n" + "	            }\r\n" +
		 * "\r\n" + "	            window.onload = disableBack();\r\n" +
		 * "	            window.onpageshow = function (evt) {\r\n" +
		 * "	                if (evt.persisted)\r\n" +
		 * "	                    disableBack()\r\n" + "	            }\r\n" +
		 * "	        });");
		 */

	}

}
