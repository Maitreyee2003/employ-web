<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.example.Employee" %>
        <%!
    String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
            <%
    Employee emp = (Employee) request.getAttribute("employee");
    String error = (String) request.getAttribute("error");
    boolean isEdit = (emp != null && emp.getId() > 0);
    String pageTitle = isEdit ? "Edit Employee" : "Add Employee";
    String activeTab = isEdit ? "list" : "add";
%>
                <jsp:include page="header.jsp">
                    <jsp:param name="title" value="<%= pageTitle %>" />
                    <jsp:param name="active" value="<%= activeTab %>" />
                </jsp:include>

                <div class="page-head" style="padding-bottom:70px;">
                    <h1>
                        <%= isEdit ? "✏️ Edit Employee" : "➕ Add New Employee" %>
                    </h1>
                    <p>
                        <%= isEdit ? "Update the details below" : "Fill in the details to add a team member" %>
                    </p>
                </div>

                <div class="form-card">

                    <% if (error != null) { %>
                        <div class="alert alert-error" style="margin:0 0 10px;">
                            <%= esc(error) %>
                        </div>
                        <% } %>

                            <form action="employees" method="post">
                                <input type="hidden" name="id" value="<%= isEdit ? emp.getId() : " " %>">

                                <label>Full Name</label>
                                <input type="text" name="name" required placeholder="e.g. Rahul Sharma" value="<%= emp != null ? esc(emp.getName()) : " " %>">

                                <label>Email</label>
                                <input type="email" name="email" required placeholder="e.g. rahul@company.com" value="<%= emp != null ? esc(emp.getEmail()) : " " %>">

                                <label>Phone (10 digits)</label>
                                <input type="text" name="phone" required pattern="\d{10}" maxlength="10" placeholder="e.g. 9876543210" value="<%= emp != null ? esc(emp.getPhone()) : " " %>">

                                <label>Department</label>
                                <input type="text" name="department" required placeholder="e.g. Engineering" value="<%= emp != null ? esc(emp.getDepartment()) : " " %>">

                                <label>Salary</label>
                                <input type="number" name="salary" step="0.01" min="0" required placeholder="e.g. 50000" value="<%= emp != null ? String.valueOf(emp.getSalary()) : " " %>">

                                <label>Joining Date</label>
                                <input type="date" name="joiningDate" required value="<%= emp != null ? esc(emp.getJoiningDate()) : " " %>">

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-green"><%= isEdit ? "Update" : "Save" %></button>
                                    <a href="employees">Cancel</a>
                                </div>
                            </form>
                </div>

                <jsp:include page="footer.jsp" />