<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
		<script type="text/javascript" src="scripts/validation.js"></script>
	</head>
	<body>
<%
	if ( (request.getParameter("fail") != null) && request.getParameter("fail").equals("true") ) {
%>
	<h1 style="color:#BB0000">User ID already in use!</h1>
<%
	}
%>
	<form name="registerUser" action="/createUser" method="POST" onSubmit="return validateRegisterForm()">
		<div>
			<label for="userId">Login ID:</label>
			<input style="margin-left: 79px" type="text" name="userId"/>
			<br/>
			<label for="userName">Display Name:</label>
			<input style="margin-left: 35px" type="text" name="userName"/>
			<br/>
			<label for="password">Password:</label>
			<input style="margin-left: 71px" type="password" name="password"/>
			<br/>
			<label for="cpassword">Confirm Password:</label>
			<input style="margin-left: 2px" type="password" name="cpassword"/>
			<br/>
			<label for="email">E-mail:</label>
			<input style="margin-left: 96px" type="text" name="email"/>
			<br/>
			<input type="submit" value="Register"/>
		</div>
	</form>
	</body>
</html>