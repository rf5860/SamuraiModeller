<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
		<script type="text/javascript" src="scripts/validation.js"></script>
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

	Query queryUser = new Query("User");
	Query queryFragment = new Query("Fragment");
	Iterable<Entity> fragments = datastore.prepare(queryFragment).asIterable();
	String user = (String) session.getAttribute("user");
%>
	<table border="2" width="500">
	<tr>
		<th width="25%">Fragment</th><th width="25%">Held By</th><th width="25%">Time Held</th><th>Action</th>
	</tr>
<%
	for (Entity fragment : fragments) {
		String fragmentName = (String)fragment.getProperty("fragmentName");
		String holder = (String)fragment.getProperty("holder");
%>
	<tr>
	<td width="25%"><%= fragmentName %></td>
<%
		if (holder == null) {
%>
		<td width="25%">Nobody</td>
		<td width="25%">500 hours</td>
<%
			if ( user != null ) {
%>
		<td width="25%"><input type="button" name="<%= fragmentName %>" value="Commandeer"/></td>
<%
			} else {
%>
		<td width="25%">Sign in to action fragment</td>
<%
			}
 		} else {
%>
		<td width="25%"><%= holder %></td>
		<td width="25%">500 hours</td>
<%
			if (user != null) {
				if (user.equals(holder)) {
%>
					<td width="25%"><input type="button" name="<%= fragmentName %>" value="Release"/></td>
<%
				} else {
%>
					<td width="25%">Contact <%= holder%> at <%= fragment.getProperty("email") %> to request fragment.</td>
<%
				}
			} else {
%>
			<td width="25%">Sign in to action fragment</td>
<%
			}
		}
%>
	</tr>
<%
	}
%>
	</table>
	<br/>
<%
if ( user != null ) {
%>
	<!--  Form to create a new fragment, which will be added to the list. -->
	<form action="/createFragment" name="createFragment" method="POST" onSubmit="return validateFragmentForm()">
		<div>
			<label for="newFragment">New Fragment:</label>
			<input type="text" style="margin-left: 19px" name="newFragment"/>
			<br/>
			<input type="submit" value="Create Fragment"/>
		</div>
	</form>
	<br/>
	<p><a href="/logout">Logout</a></p>
<%
	} else {
%>
	<p><a href="/login.jsp">Login</a> or <a href="/register.jsp">Sign Up</a> to claim fragments.</p>
<%
	}
%>
	</body>
</html>