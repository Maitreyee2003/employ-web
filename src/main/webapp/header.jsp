<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%
    String pageTitle = request.getParameter("title");
    String active = request.getParameter("active");
    if (pageTitle == null) pageTitle = "Home";
    if (active == null) active = "";
    String ctx = request.getContextPath();
    boolean loggedIn = session.getAttribute("user") != null;
%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>
                <%= pageTitle %> | EmpHub</title>
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="<%= ctx %>/css/style.css">
        </head>

        <body>
            <nav class="navbar">
                <a class="logo" href="<%= ctx %>/index.jsp">Emp<span>Hub</span></a>
                <div class="nav-links">
                    <a href="<%= ctx %>/index.jsp" class="<%= active.equals(" home ") ? "active " : " " %>">Home</a>
                    <a href="<%= ctx %>/employees" class="<%= active.equals(" list ") ? "active " : " " %>">Employees</a>
                    <a href="<%= ctx %>/employees?action=new" class="<%= active.equals(" add ") ? "active " : " " %>">Add Employee</a>
                    <a href="<%= ctx %>/about.jsp" class="<%= active.equals(" about ") ? "active " : " " %>">About</a>
                    <% if (loggedIn) { %>
                        <a href="<%= ctx %>/logout" class="logout-link">Logout (<%= session.getAttribute("user") %>)</a>
                        <% } %>
                </div>
            </nav>
            <main>