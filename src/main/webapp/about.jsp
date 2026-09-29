<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String ctx = request.getContextPath(); %>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="About" />
            <jsp:param name="active" value="about" />
        </jsp:include>

        <div class="page-head">
            <h1>About This Project</h1>
            <p>A simple web app to manage employee records</p>
        </div>

        <div class="container">
            <div class="split">
                <div><img src="<%= ctx %>/images/people.svg" alt="Team illustration"></div>
                <div>
                    <h2>What is EmpHub?</h2>
                    <p>EmpHub is an Employee Management System that supports full CRUD operations (Create, Read, Update, Delete) on employee data stored in a MySQL database. It includes login, search, sorting, pagination and CSV export.</p>
                </div>
            </div>
        </div>

        <div class="container" style="max-width:800px; padding-top:0;">
            <div class="about-box">
                <h3>🛠️ Technologies Used</h3>
                <div class="tags">
                    <span>Java</span><span>JSP</span><span>Servlet</span><span>JDBC</span>
                    <span>MySQL</span><span>Maven</span><span>HTML &amp; CSS</span><span>JavaScript</span>
                </div>
            </div>

            <div class="about-box">
                <h3>🧩 Architecture (MVC + DAO)</h3>
                <ul>
                    <li><b>Model:</b> Employee.java</li>
                    <li><b>View:</b> JSP pages (index, list, form, login, about)</li>
                    <li><b>Controller:</b> EmployeeServlet, LoginServlet, LogoutServlet, ExportServlet</li>
                    <li><b>Data access:</b> EmployeeDAO.java using JDBC</li>
                    <li><b>Security:</b> AuthFilter protects pages behind login</li>
                </ul>
            </div>
        </div>

        <jsp:include page="footer.jsp" />