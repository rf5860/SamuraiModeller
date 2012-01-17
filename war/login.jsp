<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
	</head>
	<body>
<%
	String fail = request.getParameter("fail");
	if (fail != null) {
		if ( fail.equals("baduid") ) {
%>
		<p style="color:#BB0000">Invalid login id supplied!</p>
<%
		} else if ( fail.equals("badpwd") ) {
%>
		<p style="color:#BB0000">Password doesn't match one entered on registration!</p>
<%
		} else if ( fail.equals("nouid") ) {
%>			
		<p style="color:#BB0000">Login ID cannot be blank!</p>
<%
		}
	}
%>
	<form name="login" action="/login" method="POST">
		<div>
			<label for="userId">Login ID:</label>
			<input style="margin-left: 79px" type="text" name="userId"/>
			<br/>
			<label for="password">Password:</label>
			<input style="margin-left: 71px" type="password" name="password"/>
			<br/>
			<input type="submit" value="Login"/>
		</div>
	</form>
	</body>
</html>