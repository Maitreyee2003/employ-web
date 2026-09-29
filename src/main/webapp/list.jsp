<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.*, com.example.Employee" %>
        <%!
    String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>
            <%
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
    if (employees == null) employees = new ArrayList<>();

    String flashMsg = (String) session.getAttribute("flashMsg");
    String flashType = (String) session.getAttribute("flashType");
    session.removeAttribute("flashMsg");
    session.removeAttribute("flashType");

    double totalSalary = 0, maxSalary = 0;
    Set<String> depts = new HashSet<>();
    for (Employee e : employees) {
        totalSalary += e.getSalary();
        if (e.getSalary() > maxSalary) maxSalary = e.getSalary();
        depts.add(e.getDepartment().toLowerCase());
    }
    double avg = employees.isEmpty() ? 0 : totalSalary / employees.size();
%>
                <jsp:include page="header.jsp">
                    <jsp:param name="title" value="Employees" />
                    <jsp:param name="active" value="list" />
                </jsp:include>

                <div class="page-head">
                    <h1>Employee Directory</h1>
                    <p>Everyone in your organization, in one place</p>
                </div>

                <div class="container">
                    <div class="stats">
                        <div class="stat">
                            <div class="num">
                                <%= employees.size() %>
                            </div>
                            <div class="lbl">Total Employees</div>
                        </div>
                        <div class="stat">
                            <div class="num">
                                <%= depts.size() %>
                            </div>
                            <div class="lbl">Departments</div>
                        </div>
                        <div class="stat">
                            <div class="num">
                                <%= String.format("%.0f", avg) %>
                            </div>
                            <div class="lbl">Average Salary</div>
                        </div>
                        <div class="stat">
                            <div class="num">
                                <%= String.format("%.0f", maxSalary) %>
                            </div>
                            <div class="lbl">Highest Salary</div>
                        </div>
                    </div>

                    <% if (flashMsg != null) { %>
                        <div class="alert alert-<%= " success ".equals(flashType) ? "success " : "error " %>" id="flash">
                            <%= esc(flashMsg) %>
                        </div>
                        <% } %>

                            <div class="toolbar">
                                <input type="text" id="search" class="search" placeholder="🔍 Search by name, email or department...">
                                <div class="toolbar-right">
                                    <a class="btn btn-gray" href="export">⬇ Download CSV</a>
                                    <a class="btn btn-green" href="employees?action=new">+ Add Employee</a>
                                </div>
                            </div>

                            <div class="table-wrap">
                                <table id="empTable">
                                    <thead>
                                        <tr>
                                            <th data-col="0" data-type="num">ID<span class="arrow"></span></th>
                                            <th data-col="1" data-type="text">Employee<span class="arrow"></span></th>
                                            <th data-col="2" data-type="text">Department<span class="arrow"></span></th>
                                            <th data-col="3" data-type="text">Phone<span class="arrow"></span></th>
                                            <th data-col="4" data-type="text">Joined<span class="arrow"></span></th>
                                            <th data-col="5" data-type="num">Salary<span class="arrow"></span></th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (employees.isEmpty()) { %>
                                            <tr>
                                                <td colspan="7" class="empty">No employees yet. Click "Add Employee" to get started!</td>
                                            </tr>
                                            <% } else {
                for (Employee e : employees) {
                    String initial = e.getName().isEmpty() ? "?" : e.getName().substring(0, 1).toUpperCase();
                    int color = Math.abs(e.getDepartment().toLowerCase().hashCode()) % 5;
            %>
                                                <tr class="row">
                                                    <td data-sort="<%= e.getId() %>">#
                                                        <%= e.getId() %>
                                                    </td>
                                                    <td data-sort="<%= esc(e.getName().toLowerCase()) %>">
                                                        <div class="person">
                                                            <div class="avatar">
                                                                <%= esc(initial) %>
                                                            </div>
                                                            <div>
                                                                <%= esc(e.getName()) %>
                                                                    <small><%= e.getEmail().isEmpty() ? "-" : esc(e.getEmail()) %></small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td data-sort="<%= esc(e.getDepartment().toLowerCase()) %>">
                                                        <span class="badge b<%= color %>"><%= esc(e.getDepartment()) %></span>
                                                    </td>
                                                    <td data-sort="<%= esc(e.getPhone()) %>">
                                                        <%= e.getPhone().isEmpty() ? "-" : esc(e.getPhone()) %>
                                                    </td>
                                                    <td data-sort="<%= esc(e.getJoiningDate()) %>">
                                                        <%= e.getJoiningDate().isEmpty() ? "-" : esc(e.getJoiningDate()) %>
                                                    </td>
                                                    <td data-sort="<%= e.getSalary() %>">
                                                        <%= String.format("%.2f", e.getSalary()) %>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-blue" href="employees?action=edit&id=<%= e.getId() %>">Edit</a>
                                                        <a class="btn btn-red" href="employees?action=delete&id=<%= e.getId() %>" onclick="return confirm('Delete this employee?');">Delete</a>
                                                    </td>
                                                </tr>
                                                <% } } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="pagination" id="pagination"></div>
                            <div class="page-info" id="pageInfo"></div>
                </div>

                <script>
                    var PAGE_SIZE = 10;
                    var currentPage = 1;
                    var tbody = document.querySelector('#empTable tbody');

                    function allRows() {
                        return Array.prototype.slice.call(tbody.querySelectorAll('tr.row'));
                    }

                    // Rows that match the current search text
                    function matchingRows() {
                        var q = document.getElementById('search').value.toLowerCase();
                        return allRows().filter(function(r) {
                            return r.textContent.toLowerCase().indexOf(q) > -1;
                        });
                    }

                    // Show only the rows for the current page
                    function render() {
                        var matches = matchingRows();
                        var totalPages = Math.max(1, Math.ceil(matches.length / PAGE_SIZE));
                        if (currentPage > totalPages) currentPage = totalPages;

                        allRows().forEach(function(r) {
                            r.style.display = 'none';
                        });
                        var start = (currentPage - 1) * PAGE_SIZE;
                        matches.slice(start, start + PAGE_SIZE).forEach(function(r) {
                            r.style.display = '';
                        });

                        buildPagination(totalPages);

                        var info = document.getElementById('pageInfo');
                        if (matches.length === 0) {
                            info.textContent = allRows().length === 0 ? '' : 'No matching employees.';
                        } else {
                            info.textContent = 'Showing ' + (start + 1) + '-' +
                                Math.min(start + PAGE_SIZE, matches.length) + ' of ' + matches.length + ' employees';
                        }
                    }

                    function buildPagination(totalPages) {
                        var box = document.getElementById('pagination');
                        box.innerHTML = '';
                        if (totalPages <= 1) return;

                        function btn(label, page, disabled, isCurrent) {
                            var b = document.createElement('button');
                            b.textContent = label;
                            b.disabled = disabled;
                            if (isCurrent) b.className = 'current';
                            b.addEventListener('click', function() {
                                currentPage = page;
                                render();
                            });
                            box.appendChild(b);
                        }

                        btn('← Prev', currentPage - 1, currentPage === 1, false);
                        for (var i = 1; i <= totalPages; i++) {
                            btn(String(i), i, false, i === currentPage);
                        }
                        btn('Next →', currentPage + 1, currentPage === totalPages, false);
                    }

                    // Live search
                    document.getElementById('search').addEventListener('input', function() {
                        currentPage = 1;
                        render();
                    });

                    // Click a column header to sort
                    var direction = {};
                    document.querySelectorAll('#empTable th[data-col]').forEach(function(th) {
                        th.addEventListener('click', function() {
                            var col = parseInt(th.dataset.col);
                            var type = th.dataset.type;
                            direction[col] = !direction[col];

                            var rows = allRows();
                            rows.sort(function(a, b) {
                                var x = a.children[col].dataset.sort;
                                var y = b.children[col].dataset.sort;
                                if (type === 'num') {
                                    x = parseFloat(x) || 0;
                                    y = parseFloat(y) || 0;
                                    return direction[col] ? x - y : y - x;
                                }
                                return direction[col] ? x.localeCompare(y) : y.localeCompare(x);
                            });
                            rows.forEach(function(r) {
                                tbody.appendChild(r);
                            });

                            document.querySelectorAll('#empTable .arrow').forEach(function(a) {
                                a.textContent = '';
                            });
                            th.querySelector('.arrow').textContent = direction[col] ? '▲' : '▼';

                            currentPage = 1;
                            render();
                        });
                    });

                    // Hide the message after 4 seconds
                    var flash = document.getElementById('flash');
                    if (flash) {
                        setTimeout(function() {
                            flash.style.display = 'none';
                        }, 4000);
                    }

                    // If opened from the home page "View & Search" card, focus the search box
                    if (window.location.hash === '#search') {
                        document.getElementById('search').focus();
                    }

                    render();
                </script>

                <jsp:include page="footer.jsp" />