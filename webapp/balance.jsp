<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Balance</title>

<%@ page import="java.sql.*" %>
<%@ page import= "com.atm.ConnectionManager" %>

<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="css/balance.css">
</head>

<body>
    <%
    if (session.getAttribute("phone") == null)
    	response.sendRedirect("loginFinger.jsp");

    String fname = (String) session.getAttribute("fname");
    String lname = (String) session.getAttribute("lname");
    String phone = (String) session.getAttribute("phone");
    
    Integer accNumInt = (Integer) session.getAttribute("accNum");
    int accNum = accNumInt.intValue();
    %>
    <%
    Connection con = ConnectionManager.jdbcConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM account JOIN customer ON account.customer_id=customer.customer_id WHERE customer.phone = ?");
    ps.setString(1, phone);
    ResultSet rs = ps.executeQuery();
    
    if (rs.next()) {
        int avail = rs.getInt("available");
        int withdraw = rs.getInt("withdraw");
        
        int balance = avail - withdraw;
    %>
    <nav class="navbar navbar-expand-lg navbar-dark text-light nav-bk">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item"><a class="nav-link text-light disabled mr-5">e-ATM</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="menu.jsp">Home</a></li>
        <li class="nav-item active"><a class="nav-link text-light">Balance</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="deposit.jsp">Deposit</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="withdraw.jsp">Withdraw</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="transfer.jsp">Transfer</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="mini_statement.jsp">Mini Statement</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="personal_information.jsp">Account Information</a></li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link text-light" href="logout">LOGOUT</a></li>
        </ul>
    </nav>

    <h3 class="action">
        <span>Balance</span>
    </h3>

    <div class="main">
        <p>Account Holder: <%=fname + " " + lname%></p>
        <p>Account Number: <%=accNum%></p>
        <p>Phone Number: <%=phone%></p><hr>
        <p>Available Balance: Rs. <%=balance%></p>
    </div>
    <%
    }
    %>
</body>
</html>