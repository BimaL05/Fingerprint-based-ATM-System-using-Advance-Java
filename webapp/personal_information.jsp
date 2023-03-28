<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Information</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="css/personal_information.css">
</head>

<body>
    <%
    //check if session is active
    if (session.getAttribute("phone") == null)
        response.sendRedirect("loginFinger.jsp");
    %>
    <%
    String fname = (String) session.getAttribute("firstname");
    String lname = (String) session.getAttribute("lastname");
    Integer accNumInt = (Integer) session.getAttribute("accNum");
    int accNum = accNumInt.intValue();
    String accType = (String) session.getAttribute("accType");
    String phone = (String) session.getAttribute("phone");
    String gender = (String) session.getAttribute("gender");
    String email = (String) session.getAttribute("email");
    String DOB = (String) session.getAttribute("DOB");
    String address = (String) session.getAttribute("address");
    String city = (String) session.getAttribute("city");
    String state = (String) session.getAttribute("state");
    String country = (String) session.getAttribute("country");
    String postalCode = (String) session.getAttribute("postalCode");
    %>
    <nav class="navbar navbar-expand-lg navbar-dark text-light nav-bk">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link text-light disabled mr-5">e-ATM</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="menu.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="balance.jsp">Balance</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="deposit.jsp">Deposit</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="withdraw.jsp">Withdraw</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="transfer.jsp">Transfer</a></li>
            <li class="nav-item"><a class="nav-link text-light" href="mini_statement.jsp">Mini Statement</a></li>
            <li class="nav-item active"><a class="nav-link text-light">Account Information</a></li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link text-light" href="logout">LOGOUT</a></li>
        </ul>
    </nav>

    <h3 class="action">
        <span>Account Information</span>
    </h3>
    
    <div class="main">
           <p>Account Holder: <%=fname + " " + lname%></p>
            <p>Account Number: <%=accNum%></p>
            <p>Account Type: <%=accType%></p>
            <p>Phone Number: <%=phone%></p>
            <p>Gender: <%=gender%>
            <p>E-mail: <%=email%>
            <p>Date of Birth: <%=DOB%>
            <p>Address: <%=address + ", " + city + ", " + state + "-" + postalCode%>
            <p>Country: <%=country%></p>
    </div>
    
</body>
</html>