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
	</head>
	<body>
<%
	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

	Query queryUser = new Query("User");
	Query queryFragment = new Query("Fragment");
	Iterable<Entity> users    = datastore.prepare(queryUser).asIterable();
	Iterable<Entity> fragments = datastore.prepare(queryFragment).asIterable();
	
%>
	<table border="2" width="500">
	<tr>
		<th width="25%">Fragment</th><th width="25%">Held By</th><th width="25%">Time Held</th><th>Action</th>
	</tr>
<%
	for (Entity fragment : fragments) {
		%>
		<tr>
		<td width="25%"><%= fragment.getProperty("fragmentName") %></td><td width="25%">
		<%
		if (fragment.getProperty("holder") == null) {
		%>
		Nobody</td>
		<% } else { %>
		<%= fragment.getProperty("holder") %></td>
		<%
		}
		%>
		<td width="25%">500 hours</td><td width="25%"><input type="button" value="Release"/></td>
		</tr>
		<%
		}
		%>
	</table>
	<br/>
	<!--  Form to create a new fragment, which will be added to the list. -->
	<form action="/createFragment" method="POST">
		<div>
			<label for="newFragment">New Fragment:</label>
			<input type="text" style="margin-left: 19px" name="newFragment"/>
			<br/>
			<input type="submit" value="Create Fragment"/>
		</div>
	</form>
	<br/>
<%
	if ( session.getAttribute("user") == null ) {
%>	
	<p><a href="/login.jsp">Login</a> or <a href="/register.jsp">Sign Up</a> to claim fragments.</p>
<%
	} else {
%>
	<p><a href="/logout">Logout</a></p>
<%
	}
%>
	</body>
</html>