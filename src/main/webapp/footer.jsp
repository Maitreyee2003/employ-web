<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <% String ctx = request.getContextPath(); %>
        </main>
        <footer>
            <div class="foot">
                <div>
                    <div class="fbrand">Emp<span>Hub</span></div>
                    <p>A simple employee management system built with JSP, Servlets, JDBC and MySQL.</p>
                </div>
                <div>
                    <h4>Quick Links</h4>
                    <a href="<%= ctx %>/index.jsp">Home</a>
                    <a href="<%= ctx %>/employees">Employees</a>
                    <a href="<%= ctx %>/employees?action=new">Add Employee</a>
                </div>
                <div>
                    <h4>Project</h4>
                    <a href="<%= ctx %>/about.jsp">About</a>
                    <a href="<%= ctx %>/export">Download CSV</a>
                </div>
            </div>
            <div class="foot-bottom">&copy; 2026 EmpHub | Built with Java, JSP, Servlet &amp; JDBC</div>
        </footer>
        </body>

        </html>