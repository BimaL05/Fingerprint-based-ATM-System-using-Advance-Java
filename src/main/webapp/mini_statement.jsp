<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mini Statement</title>
    <%@ page import="java.sql.*" %>
    <%@ page import= "com.atm.ConnectionManager" %>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/mini_statement.css">
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
    <nav class="navbar navbar-expand-lg navbar-dark text-light nav-bk">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item"><a class="nav-link text-light disabled mr-5">e-ATM</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="menu.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="balance.jsp">Balance</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="deposit.jsp">Deposit</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="withdraw.jsp">Withdraw</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="transfer.jsp">Transfer</a></li>
        <li class="nav-item active"><a class="nav-link text-light">Mini Statement</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="personalInformation">Account Information</a></li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link text-light" href="logout">LOGOUT</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2 class="text-center pt-4">Mini Statement</h2>
        
        <div class="main">
            <p>Account Holder: <%=fname + " " + lname%></p>
            <p>Account Number: <%=accNum%></p>
            <p>Phone Number: <%=phone%></p><hr>
        </div>
        
        <div class="table-responsive-sm">
            <table class="table table-hover table-striped table-condensed table-bordered">
                <thead>
                    <tr>
                        <th class="text-center">Transaction ID</th>
                        <th class="text-center">Transaction Type</th>
                        <th class="text-center">Amount</th>
                        <th class="text-center">Sender Account Number</th>
                        <th class="text-center">Receiver Account Number</th>                        
                        <th class="text-center">Date/Time</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    Connection con = ConnectionManager.jdbcConnection();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM transaction WHERE (accNum = ? OR receiverAccNum = ?) AND accNum != receiverAccNum ORDER BY transaction_date DESC LIMIT 5;");
                    ps.setInt(1, accNum);
                    ps.setInt(2, accNum);
                    ResultSet rs = ps.executeQuery();
                    //SELECT * FROM transaction where accNum = ? ORDER BY transaction_date DESC LIMIT 5;
                    while (rs.next()) {
                    	int transaction_id = rs.getInt("transaction_id");
                    	String transaction_type = rs.getString("transaction_type");
                    	String Receiver_Account = rs.getString("receiverAccNum");
                    	String Sender_Account = rs.getString("accNum");
                    	int amount = rs.getInt("amount");
                    	Timestamp transaction_date = rs.getTimestamp("transaction_date");                        
                    %>
                    <tr>
                        <td class="py-2"><%=transaction_id%></td>
                        <td class="py-2"><%=transaction_type%></td>
                        <td class="py-2"><%=amount%></td>
                        <td class="py-2"><%=Sender_Account%></td>
                        <td class="py-2"><%=Receiver_Account%></td>
                        <td class="py-2"><%=transaction_date%></td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>