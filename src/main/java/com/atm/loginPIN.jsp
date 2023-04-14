<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to e-ATM</title>
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
    <link rel="stylesheet" type="text/css" href="css/loginPIN.css">
<!--===============================================================================================-->
<%--   Prevent User to previous page  --%>
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
    left: 47%;
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

<body>

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
    
    <script>
            var phoneInput = document.getElementById("phone");
            phoneInput.addEventListener("input", function () {
                this.value = this.value.replace(/[^\d]/g, "").slice(0, 10);
            });
    </script>

<div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <div class="login100-pic js-tilt" data-tilt>
                    <img src="images/user.png" alt="IMG">
                </div>

                <form class="login100-form validate-form" method="post" action="Login_PIN">
                    <span class="login100-form-title"> User Login</span>

                    <div class="wrap-input100 validate-input" > <!-- data-validate = "Valid email is required: ex@abc.xyz"> -->
                        <input class="input100" type="number" name="phone" id="phone" placeholder="Phone Number" pattern="[0-9]{10}" required>
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-phone" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="wrap-input100 validate-input" > <!-- data-validate = "Password is required"> -->
                        <input class="input100" type="password" name="pin" id="pin" placeholder="PIN" required>
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>
                    
                    <div class="container-login100-form-btn">
                        <button class="login100-form-btn">Login</button>
                    </div>

                    <div class="text-center p-t-12">
                        <span class="txt1"></span>
                        <a class="txt2" href="loginFinger.jsp">Login using Fingerprint</a>
                    </div>

                    <div class="text-center p-t-136">
                        <a class="txt2" href="registration.jsp">Create your Account
                        <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
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
    <script >
        $('.js-tilt').tilt({
            scale: 1.1
        })
    </script>
<!--===============================================================================================-->
    <!-- <script src="js/main.js"></script> -->
</body>
</html>