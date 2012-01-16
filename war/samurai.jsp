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
		<th width="50%">Fragment</th><th width="50%">Held By</th>
	</tr>
<%
	for (Entity fragment : fragments) {
		%>
		<tr>
		<td width="50%"><%= fragment.getProperty("fragmentName") %></td><td width="50%">
		<%
		if (fragment.getProperty("holder") == null) {
		%>
		Nobody
		<% } else { %>
		<%= fragment.getProperty("holder") %>
		<%
		}
		%>
		</td></tr>
		<%
		}
		%>
	</table>
	<br/><br/>
	<table border="2" width="500">
		<tr>
			<th width="25%">User ID</th><th width="25%">Display Name</th><th width="50%">Held Fragments</th>
		</tr>
<%
		for (Entity user : users) {
			%>
			<tr>
			<td width="25"><%= user.getProperty("userid") %></td><td width="25"><%= user.getProperty("username") %></td><td width="50%">
			<%
			if (user.getProperty("fragments") == null) {
			%>
			None
			<% } else { %>
			<%= user.getProperty("fragments") %>
			<%
			}
			%>
			</td></tr>
			<%
			}
			%>
		</table>	
	<form action="/createFragment" method="post" style="position: fixed; top: 100 px; left: 525 px;">
		<div><label for="fragmentName">Fragment</label><input type="text" style="margin-left: 2em" name="fragmentName"/></div><div><input type="submit" value="Add Fragment"/></div>
	</form>
	<form action="/createUser" method="post" style="position: fixed; top: 160 px; left: 525 px;">
		<div><label for="id">Id</label><input type="text" style="margin-left: 3em" name="userid"/></div>
		<div><label for="name">Name</label><input type="text" style="float: right;" name="username"/></div>
		<div><input type="submit" value="Add User"/></div>
	</form>
	<form action="/commandeer" method="post" style="position: fixed; top: 25 px; left: 525 px;">
	<div>
		<select name="fragment">
			<!-- Read a list of different fragments that are available -->
<%
	for (Entity fragment : fragments) {
		%>
		<option value="<%= fragment.getProperty("fragmentName") %>"><%= fragment.getProperty("fragmentName") %></option>
		<%
	}
%>
		</select>
		<select name="user">
			<!-- Read a list of different users that are available -->
<%
	for (Entity user : users) {
		%>
		<option value="<%= user.getProperty("userid") %>"><%= user.getProperty("username") %></option>
		<%
	}
%>
		</select>
	</div>
	<div><input type="submit" value="Commandeer fragment"/></div>
	</form>
	<form action="/release" method="post" style="position: fixed; top: 250 px; left: 525 px;">
	<div>
		<select name="fragment">
			<!-- Read a list of different fragments that are available -->
<%
	for (Entity fragment : fragments) {
		%>
		<option value="<%= fragment.getProperty("fragmentName") %>"><%= fragment.getProperty("fragmentName") %></option>
		<%
	}
%>
		</select>
		<select name="user">
			<!-- Read a list of different users that are available -->
<%
	for (Entity user : users) {
		%>
		<option value="<%= user.getProperty("userid") %>"><%= user.getProperty("username") %></option>
		<%
	}
%>
		</select>
	</div>
	<div><input type="submit" value="Release fragment"/></div>
	</form>
	</body>
</html>