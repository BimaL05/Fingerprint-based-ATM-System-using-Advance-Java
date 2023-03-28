<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- <meta charset="UTF-8"> -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="css/registration.css">
  <title>Registration Form</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  
  
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
    /*
    $(document).ready(function () {
        function disableBack() {
            window.history.forward()
        }
        window.onload = disableBack();
        window.onpageshow = function (evt) {
            if (evt.persisted)
                disableBack()
        }
    });
    */
    </script>
</head>

<script>
  $(document).ready(function() {
  
  $("#account-select").change(function() {
    $("#show-address").show('slide');
    window.scrollTo(0,document.body.scrollHeight);
  });
  $("#show-address").click(function(){
    $("#address-history").show('slide');
    $("#current-address").show('slide');
    window.scrollTo(0,document.body.scrollHeight);
  });
//  $("#current-address").click(function(){
    //$("#your-consent").show('slide');
  //  $("#submit-app").show('slide');
    //window.scrollTo(0,document.body.scrollHeight);
  //});
 
  //$('#app-form').on('submit', function(){
  //  var arr = $(this).serializeArray();
    //console.log(arr);
    //return false;
  //});
   var ph = document.querySelector('#phone');
   ph.addEventListener('input',restrictNumber);
   function restrictNmber(e) {
     var newValue = this.value.replace(new RegExp(/[^*\d]/,'ig'), "");
     this.value=newValue;
   }
});
  function onlyNumberKey(evt) {
      // Only ASCII character in that range allowed
      var ASCIICode = (evt.which) ? evt.which : evt.keyCode
      if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
          return false;
      return true;
      
      
  }
</script>
<body>
  <div class="container">
    <h1 class="main-header">Account Registration Form</h1>
    <a class="sub-heading" href="loginFinger.jsp">Return to Login Page </a>
    <hr>

    <form id="app-form" action="register" method="post" enctype="multipart/form-data" name="myform" onsubmit="return validateform()">
      <fieldset class="sub-container" id="basic-details">
        <h2 class="sub-heading">Personal Details</h2>
          <hr>

          <label for="dropdown" class="standard-label">
            Title<span class="required">*</span>
            <br>
            <select  id="dropdown" class="standard-select" name="title" required>
              <option value="select" disabled selected>Select</option>
              <option value="Mr">Mr</option>
              <option value="Mrs">Mrs</option>
              <option value="Miss">Miss</option>
              <option value="Ms">Ms</option>
              <option value="Dr">Dr</option>
              <option value="Prof">Prof</option>
            </select>
          </label>
        
          <label for="firstname" class="standard-label">
            First Name<span class="required">*</span>
            <input class="standard-input" name="firstname" id="firstname" type="text" placeholder="First name"  required>
          </label>
          
          <label for="middlename" class="standard-label">
            Middle Name
            <input class="standard-input" name="middlename" id="middlename" type="text" placeholder="Middle names">
          </label>
        
          <label for="lastname" class="standard-label">
            Last Name<span class="required">*</span>
            <input class="standard-input" name="lastname" id="lastname" type="text" placeholder="Last name" required>
          </label>
          
          <label for="dropdown" class="standard-label">
            Gender<span class="required">*</span>
            <br>
            <select  id="dropdown" class="standard-select" name="gender" required>
              <option value="select" disabled selected>Select</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
            </select>
          </label>
        
          <label for="DOB" class="standard-label">
            Date of Birth<span class="required">*</span>
            <input class="standard-input" type="date" name="DOB" id="DOB" required>
          </label>
        
          <label for="phone-number" class="standard-label">
            Phone Number<span class="required">*</span>
            <input class="standard-input" type="tel" id="phone" name="phone" placeholder="Example: 9859991110" id="phone" name="phone"  onkeypress="return onlyNumberKey(event)" maxlength="10" required>
          </label>
          
          <label for="email-address" class="standard-label">
            Email<!--<span class="required">*</span> -->
            <input class="standard-input" id="email-address" type="email" name="email" placeholder="Your Email Address" required>
          </label>
          
          <label for="accountno" class="standard-label">
            Account Number<span class="required">*</span>
            <input class="standard-input" id="account-no" type="number" name="accNum" placeholder="Your Account Number" required>
          </label>

          <label for="pin" class="standard-label">
            PIN<span class="required">*</span>
            <input class="standard-input" id="pin" type="number" name="pin" placeholder="Enter a PIN" required>
          </label>
          
          <label for="accounttype" class="standard-label">
            What type of account are you applying for?<span class="required">*</span>
            <br>
            <select  id="account-select" class="standard-select" name="accType" required>
              <option value="select" disabled selected>Choose Account</option>
              <option value="Saving">Saving</option>
              <option value="Current">Current</option>
            </select>
          </label>

          <button type="button" id="show-address">Continue</button>
      </fieldset>
      
      <fieldset class="sub-container" id="address-history">
        <div id="current-address">
          <h3 class="small-heading">Current Address</h3>
          <label for="line1" class="standard-label">
            Address line 1<span class="required">*</span>
            <input class="standard-input" type="text" name="address" required>
          </label>
          <label for="line2" class="standard-label">
            Address line 2
            <input class="standard-input" type="text" name="address2">
          </label>
          <label for="town-city" class="standard-label">
            Town/City<span class="required">*</span>
            <input class="standard-input" type="text" name="city" required>
          </label>
          <label for="state" class="standard-label">
            State<span class="required">*</span>
            <input class="standard-input" type="text" name="state" required>
          </label>
          <label for="county" class="standard-label">
            Country<span class="required">*</span>
            <input class="standard-input" type="text" name="country">
          </label>
          <label for="postcode" class="standard-label">
            Postal Code<span class="required">*</span>
            <input class="standard-input" type="text" maxlength="8" name="postalCode" required>
          </label>

          <label for="finger" class="standard-label">
            Fingerprint
            <input class="standard-input" type="file" name="finger">
          </label>

          <input id="submit-app" type="submit" name="submit" value="Submit Application" onclick="logValues()"> 
        </div>
      </fieldset>
    </form>
  </div>
 <!--
  <script>
    function validateForm() {
    	var phone = document.getElementById("phone").value;
    	var accno = document.getElementById("account-no").value;
    
    	// Check if the phone and account numbers already exist
    	if (checkDuplicate(phone, accno)) {
    		alert("User already exist!");
    		return false;
    	}
    	// If everything is valid, return true to submit the form
    	return true;
    }
  </script>
  -->
  
    <!-- <script>
        function onlyNumberKey(evt) {
            var ASCIICode = (evt.which) ? evt.which : evt.keyCode
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
                return false;
            return true;
        }
    </script> -->
</body>
</html>