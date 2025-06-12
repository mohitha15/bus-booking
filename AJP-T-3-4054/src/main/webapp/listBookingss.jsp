<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.vignan.BusBooking" %>
<%@ page import="com.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List Bus Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .top-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .icon-link {
            display: inline-block;
            font-size: 24px;
            text-decoration: none;
            padding: 10px;
            border-radius: 50%;
        }
        .home {
            color: #28a745;
        }
        .bus {
            color: #007bff;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 3px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .icon-container {
        position: absolute;
        top: 10px; /* Adjust the distance from the top */
        right: 20px; /* Adjust the distance from the right */
        display: flex;
        gap: 15px; /* Space between icons */
    }

    .icon {
        text-decoration: none;
        font-size: 24px; /* Adjust size if needed */
        transition: transform 0.2s;
    }

    .icon:hover {
        transform: scale(1.2); /* Slight zoom on hover */
    }
    </style>
</head>
<body>

   <!-- Icons for navigation -->
    <div class="icon-container">
        <a href="busManagement.jsp" class="icon home-icon"><h1>🏠</h1></a>
        <a href="index.jsp" class="icon bus-icon"><h1>🚌</h1></a>
    </div>
<br><br>
    <h1>List of Bus Bookings</h1>
    
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Seat Number</th>
            <th>Person Name</th>
            <th>Payment</th>
            <th>Action</th>
        </tr>
        
        <% 
            Session session2 = FactoryProvider.getFactory().openSession();
            
            try {
                session2.beginTransaction();
                List<BusBooking> bookings = session2.createQuery("from BusBooking", BusBooking.class).getResultList();
                
                for (BusBooking booking : bookings) {
        %>
                <tr>
                    <td><%= booking.getId() %></td>
                    <td><%= booking.getSeatNumber() %></td>
                    <td><%= booking.getPersonName() %></td>
                    <td><%= booking.getPayment() %></td>
                    <td>
                        <a href="updateBus.jsp?id=<%= booking.getId() %>" class="btn">Update</a>
                    </td>
                </tr>
        <%
                }
                session2.getTransaction().commit();
            } finally {
                session2.close();
            }
        %>
    </table>

</body>
</html>
