<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.vignan.BusBooking" %>
<%@ page import="com.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Bus Booking</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        h1 { color: #333; }
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .btn { padding: 5px 10px; background-color: #007bff; color: white; text-decoration: none; border-radius: 3px; }
        .btn:hover { background-color: #0056b3; }
        form { max-width: 400px; margin: 20px auto; background: #f4f4f4; padding: 20px; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px; }
        input[type="submit"] { background-color: #28a745; color: white; border: none; padding: 10px; cursor: pointer; }
        input[type="submit"]:hover { background-color: #218838; }
        
        /* Icons on top-right */
        .top-right-icons {
            position: absolute;
            top: 10px;
            right: 20px;
        }
        .icon {
            display: inline-block;
            margin-left: 15px;
            font-size: 24px;
            text-decoration: none;
            color: #333;
        }
        .icon:hover {
            color: #007bff;
        }
    </style>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    
<!-- Icons for navigation -->
    <div class="icon-container">
        <a href="busManagement.jsp" class="icon home-icon"><h1>🏠</h1></a>
        <a href="index.jsp" class="icon bus-icon"><h1>🚌</h1></a>
    </div>

    <h1>Update Bus Booking</h1>

    <!-- Display Error or Success Messages -->
    <% if (request.getAttribute("error") != null) { %>
        <p style="color: red; font-weight: bold;"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getParameter("success") != null) { %>
        <p style="color: green; font-weight: bold;"><%= request.getParameter("success") %></p>
    <% } %>

    <h2>List of Bookings</h2>
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
            hibernateSession.beginTransaction();
            List<BusBooking> bookings = hibernateSession.createQuery("from BusBooking", BusBooking.class).list();

            for (BusBooking booking : bookings) {
        %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getSeatNumber() %></td>
                    <td><%= booking.getPersonName() %></td>
                    <td><%= booking.getPayment() %></td>
                    <td>
                        <a href="updateBus.jsp?id=<%= booking.getId() %>&seatNumber=<%= booking.getSeatNumber() %>&personName=<%= booking.getPersonName() %>&seatStatus=<%= booking.getSeatStatus() %>&payment=<%= booking.getPayment() %>" class="btn">Update</a>
                    </td>
                </tr>
        <%
            }
            hibernateSession.getTransaction().commit();
        } finally {
            hibernateSession.close();
        }
        %>
    </table>

    <h2>Update Booking</h2>
    <form action="updateBusBookingServlet" method="post">
        <label for="id">Booking ID:</label>
        <input type="text" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" readonly required>
        
        <label for="seatNumber">Seat Number:</label>
        <input type="number" name="seatNumber" value="<%= request.getParameter("seatNumber") != null ? request.getParameter("seatNumber") : "" %>" required>
        
        <label for="personName">Person Name:</label>
        <input type="text" name="personName" value="<%= request.getParameter("personName") != null ? request.getParameter("personName") : "" %>" required>
        
        <label for="payment">Payment:</label>
        <input type="number" step="0.01" name="payment" value="<%= request.getParameter("payment") != null ? request.getParameter("payment") : "" %>" required>
        
        <input type="submit" value="Update Booking">
    </form>
</body>
</html>
