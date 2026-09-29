package com.example;

public class Employee {

    private int id;
    private String name;
    private String department;
    private double salary;
    private String email;
    private String phone;
    private String joiningDate;

    public Employee(int id, String name, String department, double salary,
                    String email, String phone, String joiningDate) {
        this.id = id;
        this.name = name == null ? "" : name;
        this.department = department == null ? "" : department;
        this.salary = salary;
        this.email = email == null ? "" : email;
        this.phone = phone == null ? "" : phone;
        this.joiningDate = joiningDate == null ? "" : joiningDate;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getDepartment() { return department; }
    public double getSalary() { return salary; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getJoiningDate() { return joiningDate; }
}