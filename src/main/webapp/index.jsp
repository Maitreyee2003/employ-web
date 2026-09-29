<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String ctx = request.getContextPath(); %>
        <jsp:include page="header.jsp">
            <jsp:param name="title" value="Home" />
            <jsp:param name="active" value="home" />
        </jsp:include>

        <section class="hero">
            <div class="emoji">👥</div>
            <h1>Manage Your Team,<br>Effortlessly.</h1>
            <p>EmpHub is a simple and fast employee management system. Add, view, update and organize your employees in one place.</p>
            <a class="btn btn-primary" href="employees">View Employees</a>
            <a class="btn btn-outline" href="employees?action=new">+ Add Employee</a>
        </section>

        <div class="container">
            <h2 class="section-title">What you can do</h2>
            <div class="cards">
                <a class="card" href="employees?action=new">
                    <div class="icon">➕</div>
                    <h3>Add Employees</h3>
                    <p>Register new team members with their department and salary in seconds.</p>
                    <span class="card-link">Add now →</span>
                </a>
                <a class="card" href="employees#search">
                    <div class="icon">📋</div>
                    <h3>View &amp; Search</h3>
                    <p>See everyone in a clean table and search instantly by name or department.</p>
                    <span class="card-link">Open directory →</span>
                </a>
                <a class="card" href="employees">
                    <div class="icon">✏️</div>
                    <h3>Update Details</h3>
                    <p>Change a department or salary. Click <b>Edit</b> on any employee in the list.</p>
                    <span class="card-link">Go to employees →</span>
                </a>
                <a class="card" href="employees">
                    <div class="icon">🗑️</div>
                    <h3>Remove Records</h3>
                    <p>Delete outdated records safely. Click <b>Delete</b> on any employee in the list.</p>
                    <span class="card-link">Go to employees →</span>
                </a>
            </div>
        </div>

        <div class="container">
            <div class="split">
                <div><img src="<%= ctx %>/images/people.svg" alt="Team illustration"></div>
                <div>
                    <h2>Everything your HR desk needs</h2>
                    <p>Keep every employee record tidy and easy to find, without spreadsheets or paperwork.</p>
                    <ul class="ticks">
                        <li>Complete profiles with email, phone and joining date</li>
                        <li>Live search and one-click column sorting</li>
                        <li>Pagination for large teams</li>
                        <li>Export the full list to CSV</li>
                    </ul>
                    <a class="btn btn-green" href="employees">Open directory</a>
                </div>
            </div>
        </div>

        <div class="container" style="padding-top:0;">
            <h2 class="section-title">How it works</h2>
            <div class="steps">
                <div class="step"><span>1</span>
                    <h3>Sign in</h3>
                    <p>Log in securely as the admin.</p>
                </div>
                <div class="step"><span>2</span>
                    <h3>Add your team</h3>
                    <p>Fill in a simple form for each employee.</p>
                </div>
                <div class="step"><span>3</span>
                    <h3>Manage &amp; export</h3>
                    <p>Search, edit, sort and download your data.</p>
                </div>
            </div>
        </div>

        <section class="cta">
            <h2>Ready to organise your team?</h2>
            <p>Add your first employee and see the dashboard come alive.</p>
            <a class="btn btn-primary" href="employees?action=new">Add your first employee</a>
        </section>

        <jsp:include page="footer.jsp" />