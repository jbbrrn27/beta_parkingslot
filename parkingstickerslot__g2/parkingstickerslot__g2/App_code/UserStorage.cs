using System;
using System.Collections.Generic;

public class User
{
    public string Username { get; set; }
    public string Password { get; set; }
    public string AccountType { get; set; } // Employee, Student, Teacher
    public string Email { get; set; }
    public string Address { get; set; }
    public DateTime DateOfBirth { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }

    public User(string username, string password, string accountType, string email, string address, DateTime dateOfBirth, string firstName, string lastName)
    {
        Username = username;
        Password = password;
        AccountType = accountType;
        Email = email;
        Address = address;
        DateOfBirth = dateOfBirth;
        FirstName = firstName;
        LastName = lastName;
    }
}

public static class UserStorage
{
    public static List<User> Users = new List<User>
    {
        new User("student123", "password123", "Student", "student@school.edu", "123 University Ave", new DateTime(2001, 6, 15), "John", "Doe"),
        new User("employee001", "password001", "Employee", "employee@company.com", "456 Company St", new DateTime(1990, 3, 22), "Jane", "Smith"),
        new User("teacher789", "password789", "Teacher", "teacher@school.edu", "789 Teacher Lane", new DateTime(1985, 12, 5), "Emily", "Johnson")
    };
}
