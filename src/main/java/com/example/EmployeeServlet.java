package com.example;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/employees")
public class EmployeeServlet extends HttpServlet {

    private EmployeeDAO dao = new EmployeeDAO();

    // Message shown once on the list page after a redirect
    private void flash(HttpServletRequest req, String type, String msg) {
        req.getSession().setAttribute("flashType", type);
        req.getSession().setAttribute("flashMsg", msg);
    }

    private String clean(String s) {
        return s == null ? "" : s.trim();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    req.getRequestDispatcher("/form.jsp").forward(req, resp);
                    break;

                case "edit":
                    int editId = Integer.parseInt(req.getParameter("id"));
                    req.setAttribute("employee", dao.getById(editId));
                    req.getRequestDispatcher("/form.jsp").forward(req, resp);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(req.getParameter("id"));
                    dao.delete(deleteId);
                    flash(req, "success", "Employee deleted successfully.");
                    resp.sendRedirect("employees");
                    break;

                default:
                    req.setAttribute("employees", dao.getAll());
                    req.getRequestDispatcher("/list.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String idText = clean(req.getParameter("id"));
        String name = clean(req.getParameter("name"));
        String department = clean(req.getParameter("department"));
        String email = clean(req.getParameter("email"));
        String phone = clean(req.getParameter("phone"));
        String joiningDate = clean(req.getParameter("joiningDate"));
        String salaryText = clean(req.getParameter("salary"));

        int id = idText.isEmpty() ? 0 : Integer.parseInt(idText);

        // ---------- Validation ----------
        String error = null;
        double salary = 0;

        try {
            salary = Double.parseDouble(salaryText);
        } catch (NumberFormatException e) {
            error = "Salary must be a valid number.";
        }

        if (name.isEmpty()) {
            error = "Name is required.";
        } else if (department.isEmpty()) {
            error = "Department is required.";
        } else if (!email.matches("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$")) {
            error = "Please enter a valid email address.";
        } else if (!phone.matches("\\d{10}")) {
            error = "Phone number must be exactly 10 digits.";
        } else if (error == null && salary < 0) {
            error = "Salary cannot be negative.";
        } else if (joiningDate.isEmpty()) {
            error = "Joining date is required.";
        } else {
            try {
                LocalDate.parse(joiningDate);
            } catch (Exception e) {
                error = "Joining date is not valid.";
            }
        }

        Employee emp = new Employee(id, name, department, salary, email, phone, joiningDate);

        if (error != null) {
            // Go back to the form and keep what the user typed
            req.setAttribute("error", error);
            req.setAttribute("employee", emp);
            req.getRequestDispatcher("/form.jsp").forward(req, resp);
            return;
        }

        try {
            if (id == 0) {
                dao.add(emp);
                flash(req, "success", "Employee added successfully!");
            } else {
                dao.update(emp);
                flash(req, "success", "Employee updated successfully!");
            }
            resp.sendRedirect("employees");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}