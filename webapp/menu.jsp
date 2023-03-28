<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
   
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/menu.css">

    <title>Welcome to e-ATM</title>
    
    <%--   Prevent User to previous page      --%>
    <script
        src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
    <script
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            function disableBack() {
                window.history.forward()
            }
            window.onload = disableBack();
            window.onpageshow = function(evt) {
                if (evt.persisted)
                    disableBack()
            }
        });
	</script>
  </head>

  <body>
    <%
    if (session.getAttribute("phone") == null)
        response.sendRedirect("loginFinger.jsp");
    //access all attributes
    String fname = (String) session.getAttribute("fname");
    String lname = (String) session.getAttribute("lname");
    Integer accNumInt = (Integer) session.getAttribute("accNum");
    int accNum = (accNumInt != null) ? accNumInt.intValue() : 0;
    //int accNum = ((Integer)session.getAttribute("accNum")).intValue();
   // Integer accNumInt = (Integer) session.getAttribute("accNum");
    //int accNum = accNumInt.intValue();
    String phone = (String) session.getAttribute("phone");
    %>
  <!-- navbar --> 
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <a class="navbar-brand" >e-ATM</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <a class="nav-link">HOME</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="logout">LOGOUT</a>
              </li>
            </ul>
          </div>
    </nav>
  
      <div class="container-fluid">
      
            <div class="row intro py-1">
              <div class="col-sm-12 col-md">
                <div class="heading text-center my-5">
                  <h3>Welcome to</h3>
                  <h1>e-ATM</h1>
                </div>
              </div>
              <div class="col-sm-12 col-md img text-center">
                <img class="im" src="images/bank.png" class="img-fluid pt-2">
              </div>
            </div>

          <br>
          <br>
          <br>
          <!-- 
            <p>Account Name: <%=fname + " " + lname%></p>
            <p>Account Number: <%=accNum%></p>
            <p>Phone Number: <%=phone%></p>
             -->
          <h3 class="action" >
            <span style="font-family: 'Roboto Slab', serif">CHOOSE AN ACTION</span>
         </h3>
          
            <div class="column activity text-center">      
                <div class="main">
                
                        <div class="menu1">
                            <a href="balance.jsp"><button class="btn">BALANCE</button></a><br>
                            <a href="Menu_Deposit"><button class="btn">DEPOSIT</button></a><br>
                            <a href="Menu_Withdraw"><button class="btn">WITHDRAW</button></a><br>
                        </div>
                        <div class="menu2">
                            <a href="Menu_Transfer"><button class="btn">TRANSFER</button></a><br>
                            <a href="mini_statement.jsp"><button class="btn">MINI STATEMENT</button></a><br>
                            <a href="personalInformation"><button class="btn">ACCOUNT INFO</button></a><br>
                        </div>
                </div>          
            </div>
           
      </div>
      
      <br>
      <!-- 
      <footer class="text-center mt-5 py-2">
        <p>A Project by <b>BIMAL</b> <br> </p>
      </footer>
     -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
  </body>
</html>