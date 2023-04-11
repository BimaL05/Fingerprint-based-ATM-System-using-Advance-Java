<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transfer</title>

<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="css/transfer.css" />

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
    padding: 40px;
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
    margin-top: 20px;
    cursor: pointer;
    font-size:10px;
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
    
      <!-- Amount less than 0-->
    <script>
                    function checkAmount() {
                        var amount = document.getElementById("transfer").value;
                        if (amount <= 0) {
                            document.getElementById("custom-alert").style.display = "block";
                            return false;
                        }
                            return true;
                    }
    </script>
        <!-- Amount less than 0-->
    <div id="custom-alert" class="custom-alert">
          <p class="heading">Error</p>
          <p>Enter a valid amount !!</p>
          <button onclick="closeAlert()">Close</button>
    </div> 
    <script>                    
                    function closeAlert() {
                        document.getElementById("custom-alert").style.display = "none";
                   }
    </script>
    
    <!-- Amount MORE than Available -->
    <div id="balance-alert" class="custom-alert"
            <% String error = (String) request.getAttribute("error");
            if(error != null){ %>
            style="display: block;"
            <% } else { %>
            style="display: none;"
            <% } %>
        >
            <p class="heading">Error</p>
           <p><%= (String) request.getAttribute("error") %></p>
            <button onclick="closeAlert2()">Close</button>
    </div>
    <script>                    
                    function closeAlert2() {
                        document.getElementById("balance-alert").style.display = "none";
                   }
    </script>
    
    <!-- Invalid Acc No. -->
    <div id="account-alert" class="custom-alert"
            <% error = (String) request.getAttribute("error");
            if(error != null){ %>
            style="display: block;"
            <% } else { %>
            style="display: none;"
            <% } %>
    >
            <p class="heading">Error</p>
            <p><%= (String) request.getAttribute("error") %></p>
            <button onclick="closeAlert3()">Close</button>
    </div>
    <script>
                    function closeAlert3() {
                        document.getElementById("account-alert").style.display = "none";
                   }
    </script>
    
    <nav class="navbar navbar-expand-lg navbar-dark text-light nav-bk">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item"><a class="nav-link text-light disabled mr-5">e-ATM</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="menu.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="balance.jsp">Balance</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="deposit.jsp">Deposit</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="withdraw.jsp">Withdraw</a></li>
        <li class="nav-item active"><a class="nav-link text-light">Transfer</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="mini_statement.jsp">Mini Statement</a></li>
        <li class="nav-item"><a class="nav-link text-light" href="personalInformation">Account Information</a></li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link text-light" href="logout">LOGOUT</a></li>
        </ul>
    </nav>
    
    <h3 class="action">
        <span style="font-family: 'Roboto Slab', serif">Transfer Money</span>
    </h3>
    
    <form action="Transfer" method="post" onsubmit="return checkAmount()">
        <div class="main">

            <p>Account Holder: <%=fname + " " + lname%></p>
            <p>Account Number: <%=accNum%></p>
            <p>Phone Number: <%=phone%></p>
            <br>
            
            <input type="hidden" name="phone" value="<%=phone%>">
            <input type="hidden" name="accNum" value="<%=accNum%>">
            <div class="form-row">
                    <label for="amount">Enter the account number to transfer: </label>
                    <input type="number" id="accNum2" name="accNum2" required />            
            </div>
            <div class="form-row">
                    <label for="amount">Enter the amount: </label>
                    <input type="number" id="transfer" name="transfer" required />
            </div>
            <button class="btn" type="submit">Transfer</button>
            
            <input type="hidden" name="fname" value="<%=fname%>"> 
            <input type="hidden" name="lname" value="<%=lname%>">
        </div>
    </form>
</body>
</html>