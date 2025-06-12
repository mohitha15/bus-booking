<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.vignan.BusBooking" %>
<%@ page import="com.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Bus Booking</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        h1 { color: #333; }
        .icon-container { position: absolute; top: 10px; left: 15px; }
        .icon { font-size: 24px; text-decoration: none; margin-right: 15px; font-weight: bold; display: inline-block; transition: color 0.3s; }
        .home-icon { color: #007bff; } .bus-icon { color: #28a745; }
        .home-icon:hover { color: #0056b3; } .bus-icon:hover { color: #1e7e34; }
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .btn { padding: 5px 10px; background-color: #d9534f; color: white; text-decoration: none; border-radius: 3px; }
        .btn:hover { background-color: #c9302c; }
        form { max-width: 400px; margin: 20px auto; background: #f4f4f4; padding: 20px; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"] { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px; }
        input[type="submit"] { background-color: #d9534f; color: white; border: none; padding: 10px; cursor: pointer; }
        input[type="submit"]:hover { background-color: #c9302c; }
    </style>
</head>
<body>

<!-- Icons for navigation -->
    <div class="icon-container">
        <a href="busManagement.jsp" class="icon home-icon"><h1>🏠</h1></a>
        <a href="index.jsp" class="icon bus-icon"><h1>🚌</h1></a>
    </div>

    <h1>Delete Bus Booking</h1>

    <h2>List of Bus Bookings</h2>
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Seat Number</th>
            <th>Person Name</th>
            <th>Payment</th>
            <th>Action</th>
        </tr>
<%
    Session hibernateSession = FactoryProvider.getFactory().openSession();
    try {
        List<BusBooking> bookings = hibernateSession.createQuery("from BusBooking", BusBooking.class).list();
        for (BusBooking booking : bookings) {
%>
        <tr>
            <td><%= booking.getId() %></td>
            <td><%= booking.getSeatNumber() %></td>
            <td><%= booking.getPersonName() %></td>
            <td><%= booking.getPayment() %></td>
            <td>
                <form action="deleteBookingServlet" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= booking.getId() %>">
                    <input type="submit" value="Delete" class="btn">
                </form>
            </td>
        </tr>
<%
        }
    } finally {
        hibernateSession.close();
    }
%>
    </table>

    <h2>Delete Booking by ID</h2>
    <form action="deleteBookingServlet" method="post">
        <label for="id">Booking ID:</label>
        <input type="text" name="id" required>
        <input type="submit" value="Delete Booking">
    </form>

</body>
</html>
