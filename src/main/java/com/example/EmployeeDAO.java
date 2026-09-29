package com.example;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    private Employee map(ResultSet rs) throws SQLException {
        return new Employee(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("department"),
                rs.getDouble("salary"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("joining_date"));
    }

    private void setDate(PreparedStatement ps, int index, String value) throws SQLException {
        if (value == null || value.isEmpty()) {
            ps.setNull(index, java.sql.Types.DATE);
        } else {
            ps.setDate(index, Date.valueOf(value));
        }
    }

    public List<Employee> getAll() throws SQLException {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM employee ORDER BY id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public Employee getById(int id) throws SQLException {
        String sql = "SELECT * FROM employee WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    public void add(Employee e) throws SQLException {
        String sql = "INSERT INTO employee (name, department, salary, email, phone, joining_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getName());
            ps.setString(2, e.getDepartment());
            ps.setDouble(3, e.getSalary());
            ps.setString(4, e.getEmail());
            ps.setString(5, e.getPhone());
            setDate(ps, 6, e.getJoiningDate());
            ps.executeUpdate();
        }
    }

    public void update(Employee e) throws SQLException {
        String sql = "UPDATE employee SET name = ?, department = ?, salary = ?, "
                   + "email = ?, phone = ?, joining_date = ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getName());
            ps.setString(2, e.getDepartment());
            ps.setDouble(3, e.getSalary());
            ps.setString(4, e.getEmail());
            ps.setString(5, e.getPhone());
            setDate(ps, 6, e.getJoiningDate());
            ps.setInt(7, e.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM employee WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}