<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
		<script type="text/javascript">
		function validate_required(field, msg)
		{
			with (field) {
				if ( (value==null) || (value=="") ) {
					alert(msg);
					return false;
				} else {
					return true;
				}
			}
		}
		
		function validateForm()
		{
			with (document.forms["registerUser"]) {
				if ( (validate_required(userId, "Login ID must be supplied.") == false ) {
					userId.focus();
					return false;
				} else if ( (validate_required(userName, "Display Name must be supplied.") == false ) {
					userName.focus();
					return false;
				} else if ( (validate_required(email, "E-mail must be supplied.") == false ) {
					email.focus();
					return false;
				} else if ( (validate_required(password, "Password must be supplied.") == false ) {
					password.focus();
					return false;
				} else if ( (validate_required(cpassword, "Confirmation Password must be supplied.") == false ) {
					cpassword.focus();
					return false;
				} else if (password.value != cpassword.value) { 
					alert("Your password and confirmation password do not match.");
					cpassword.focus();
					return false; 
				}
			}
			
		}
		</script>
	</head>
	<body>
	<form name="registerUser" action="/createUser" method="POST" onSubmit="validateForm()">
		<div>
			<label for="userId">Login ID:</label>
			<input type="text" name="userId"/>
			<br/>
			<label for="userName">Display Name:</label>
			<input type="text" name="userName"/>
			<br/>
			<label for="password">Password:</label>
			<input type="password" name="password"/>
			<br/>
			<label for="cpassword">Confirm Password:</label>
			<input type="password" name="cpassword"/>
			<br/>
			<label for="email">E-mail:</label>
			<input type="text" name="email"/>
			<br/>
			<input type="submit" value="Create Fragment"/>
		</div>
	</form>
	</body>
</html>