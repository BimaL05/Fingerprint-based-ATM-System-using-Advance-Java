<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Deposit</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="css/deposit.css" />
<style>
.custom-alert {
    font-family: Arial, sans-serif;
    font-size:20px;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #f2f2f2;
    border: 1px solid #888;
    padding: 50px;
    box-shadow: 0px 0px 10px #888;
    border-radius: 10px;
    display: none;
    z-index: 1;
}
.heading {
    color: #fb6d6d;
    /*margin: 0;*/
    font-family: 'Roboto Slab', serif;
    font-size:20px;
}
.custom-alert button {
    background-color: #fb6d6d;
    color: #fff;
    border: none;
    padding: 10px 10px;
    border-radius: 5px;
    margin-top: 30px;
    cursor: pointer;
    font-size:10px;
    position: absolute;
    right: 0;
    bottom: 0;
    margin-bottom: 10px;
    margin-right: 30px;
    margin-top: 20px;
}
</style>
</head>

<body>
    <%
    if (session.getAttribute("phone") == null)
        response.sendRedirect("loginFinger.jsp");
    
    String fname = (String) session.getAttribute("fname");
    String lname = (String) session.getAttribute("lname");
    Integer accNumInt = (Integer) session.getAttribute("accNum");
    int accNum = accNumInt.intValue();
    String phone = (String) session.getAttribute("phone");
    %>
    <script>
    <!-- Amount less than 0-->
        function checkAmount() {
        	var amount = document.getElementById("deposit").value;
        	if (amount <= 0) {
        		document.getElementById("custom-alert").style.display = "block";
        		return false;
        	}
        	return true;
        }
        function closeAlert() {
        	document.getElementById("custom-alert").style.display = "none";
        }
	</script>
	<div id="custom-alert" class="custom-alert">
          <p class="heading">Error</p>
          <p>Enter a valid amount !! </p>
          <button onclick="closeAlert()">Close</button>
    </div>
    
    <nav class="navbar navbar-expand-lg navbar-dark text-light nav-bk">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item"><a class="nav-link text-light disabled mr-5">e-ATM</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="menu.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="balance.jsp">Balance</a></li>
        <li class="nav-item active"><a class="nav-link text-light">Deposit</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="withdraw.jsp">Withdraw</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="transfer.jsp">Transfer</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="mini_statement.jsp">Mini Statement</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="personalInformation">Account Information</a></li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link text-light" href="logout">LOGOUT</a></li>
        </ul>
    </nav>
    
    <h3 class="action">
        <span style="font-family: 'Roboto Slab', serif">Deposit</span>
    </h3>
    
    <form action="Deposit" method="post" onsubmit="return checkAmount()">
        <div class="main">

            <p>Account Holder: <%=fname + " " + lname%></p>
            <p>Account Number: <%=accNum%></p>
            <p>Phone Number: <%=phone%></p>
            <br>
            
            <input type="hidden" name="phone" value="<%=phone%>">
            <div class="form-row">
                <label for="amount">Enter the amount: </label>
                <input type="number" id="deposit" name="deposit" required />
            </div>
            <button class="btn" type="submit">Deposit</button>
            
            <input type="hidden" name="accNum" value="<%=accNum%>"> 
            <input type="hidden" name="fname" value="<%=fname%>"> 
            <input type="hidden" name="lname" value="<%=lname%>">
        </div>
    </form>
    
</body>
</html>