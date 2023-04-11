<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Welcome to e-ATM</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
    href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
    href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
    href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
    href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
    href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="css/util.css">
<link rel="stylesheet" type="text/css" href="css/loginFinger.css">
<!--===============================================================================================-->
<%--   Prevent User to previous page --%>
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
    padding: 30px;
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
<body class="disable">
    
    <!-- Invalid Credentials -->
    <div id="login-alert" class="custom-alert"
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
                        document.getElementById("login-alert").style.display = "none";
                   }
    </script>

    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <div class="login100-pic js-tilt" data-tilt>
                    <img src="images/user.png" alt="IMG">
                </div>

                <form class="login100-form validate-form" method="post"
                    action="LoginFinger" enctype="multipart/form-data">
                    <span class="login100-form-title"> User Login
                    </span>

                    <div class="wrap-input100 validate-input m-b-26">
                        <%--  data-validate = "<%=errorPhone%>"--%>
                        <span class="label-input100">Phone No</span> <input
                            class="input100" type="number" name="phone"
                            id="phone" placeholder="Enter Phone Number"
                            required> <span
                            class="focus-input100"></span> <span
                            class="symbol-input100"> <i
                            class="fa fa-phone" aria-hidden="true"></i>
                        </span>
                    </div>

                    <p id="file-name"></p>

                    <div class="wrap-input100 validate-input m-b-18">
                        <%--  data-validate = "<%=errorLogin%>"--%>
                        <span class="label-input100">Fingerprint</span>

                        <input class="input100" id="fingerprint"
                            type="file" name="finger"> <label
                            for="fingerprint" id="fingerprint-label"></label>

                        <!-- <input type="file" id="fingerprint" style="opacity:0;">
						<label for="fingerprint">Upload</label> -->

                        <span class="focus-input100"></span> <span
                            class="symbol-input100"> <i
                            class="fa fa-fingerprint" aria-hidden="true"></i>
                        </span>
                    </div>

                    <!--[OLD INPUT]-->
                    <!-- <div class="wrap-input100 validate-input" data-validate = "Invalid Phone No.">
						<input class="input100" type="number" name="phone" placeholder="Phone No.">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-phone" aria-hidden="true"></i>
						</span>
					</div> -->
                    <!-- <div class="wrap-input100" data-validate = "Invalid Fingerprint">
						<input class="input100" id="actual-btn" type="file" name="finger" placeholder="Fingerprint">
						<span class="focus-input100"></span>
						<span class="symbol-input100">
							<i class="fa fa-fingerprint" aria-hidden="true"></i>
						</span>
					</div> -->

                    <div class="container-login100-form-btn">
                        <button class="login100-form-btn">
                            Login</button>
                    </div>

                    <div class="text-center p-t-12">
                        <span class="txt1"> </span> 
                        <a class="txt2" href="loginPIN.jsp">Login using PIN</a>
                        <span class="txt1"></span> 
                    </div>

                    <div class="text-center p-t-136">
                        <a class="txt2" href="registration.jsp">
                            Create your Account <i
                            class="fa fa-long-arrow-right m-l-5"
                            aria-hidden="true"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--===============================================================================================-->

    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/select2/select2.min.js"></script>
    <!--===============================================================================================-->
    <script src="vendor/tilt/tilt.jquery.min.js"></script>
    <script>
					$('.js-tilt').tilt({
						scale : 1.1
					})
				</script>

    <script>
					/*window.onload = function() {
					 if (error != null) { 
					 if (error == "Incorrect Phone No.") {
					 swal({
					 title: "Error",
					 text: "Please enter a valid Phone No.",
					 icon: "error",
					 button: "Ok"
					 });
					 } else if (error == "Incorrect Fingerprint") {
					 swal({
					 title: "Error",
					 text: "Please select a valid Fingerprint.",
					 icon: "error",
					 button: "Ok"
					 });
					 } else if (error == "Invalid Phone No. or Fingerprint") {
					 swal({
					 title: "Error",
					 text: "Please select a valid Phone No or Fingerprint.",
					 icon: "error",
					 button: "Ok"
					 });
					 }
					
					 } 
					 }*/
				</script>
    <!--===============================================================================================-->
    <%-- <script src="loginFinger.js"></script>
--%>
</body>
</html>