package com.example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/export")
public class ExportServlet extends HttpServlet {

    private EmployeeDAO dao = new EmployeeDAO();

    private String csv(String s) {
        if (s == null) return "";
        return "\"" + s.replace("\"", "\"\"") + "\"";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/csv;charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"employees.csv\"");

        try {
            List<Employee> list = dao.getAll();
            PrintWriter out = resp.getWriter();
            out.print('\uFEFF'); // helps Excel read UTF-8
            out.println("ID,Name,Email,Phone,Department,Salary,Joining Date");
            for (Employee e : list) {
                out.println(e.getId() + "," + csv(e.getName()) + "," + csv(e.getEmail()) + ","
                        + csv(e.getPhone()) + "," + csv(e.getDepartment()) + ","
                        + e.getSalary() + "," + csv(e.getJoiningDate()));
            }
            out.flush();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}