<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.vignan.BusBooking" %>
<%@ page import="com.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Bus Booking</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        h1 { color: #333; }
        form {
            max-width: 400px;
            margin: 20px auto;
            background: #f4f4f4;
            padding: 20px;
            border-radius: 5px;
        }
        label { display: block; margin-bottom: 5px; text-align: left; }
        input, select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover { background-color: #0056b3; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <h1>Create Bus Booking</h1>

    <% 
        String error = request.getParameter("error");
        if (error != null) { 
    %>
        <p class="error"><%= error %></p>
    <% } %>
<!-- Icons for navigation -->
    <div class="icon-container">
        <a href="busManagement.jsp" class="icon home-icon"><h1>🏠</h1></a>
        <a href="index.jsp" class="icon bus-icon"><h1>🚌</h1></a>
    </div>
    <form action="BusBookingServlet" method="post" accept-charset="UTF-8">
        <label for="seatNumber">Seat Number:</label>
        <input type="number" name="seatNumber" id="seatNumber" required>

        <label for="personName">Passenger Name:</label>
        <input type="text" name="passengerName" id="passengerName" required>

        <label for="payment">Payment (₹):</label>
        <input type="number" name="payment" id="payment" step="0.01" required>

        <input type="submit" value="Create Booking">
    </form>
</body>
</html>
