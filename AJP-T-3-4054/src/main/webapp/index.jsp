<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="com.vignan.BusBooking" %>
<%@ page import="com.helper.FactoryProvider" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seat Selection</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; position: relative; }
        h1 { color: #333; }

        .home-icon {
            position: absolute;
            top: 10px;
            left: 15px;
            font-size: 24px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }

        .home-icon:hover {
            color: #0056b3;
        }

        .bus-layout {
            display: grid;
            grid-template-columns: repeat(4, 60px);
            gap: 10px;
            justify-content: center;
            margin-top: 40px;
        }

        .seat {
            width: 60px;
            height: 60px;
            background-color: green;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .blocked {
            background-color: red;
            cursor: not-allowed;
            pointer-events: none;
        }
    </style>
</head>
<body>

    <!-- Home Icon for Navigation -->
<!-- Icons for navigation -->
    <div class="icon-container">
        <a href="busManagement.jsp" class="icon home-icon"><h1>🏠</h1></a>
     
    </div>
   
    <h1>Select a Seat</h1>

    <div class="bus-layout" id="busSeats">
        <%
            Session hibernateSession = FactoryProvider.getFactory().openSession();
            List<Integer> blockedSeats = hibernateSession.createQuery("SELECT seatNumber FROM BusBooking", Integer.class).list();
            hibernateSession.close();

            int totalSeats = 20;  // Modify based on the bus capacity
            for (int i = 1; i <= totalSeats; i++) {
                boolean isBlocked = blockedSeats.contains(i);
        %>
                <div class="seat <%= isBlocked ? "blocked" : "" %>" data-seat="<%= i %>">
                    <%= i %>
                </div>
        <%
            }
        %>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            document.querySelectorAll(".seat").forEach(seat => {
                seat.addEventListener("click", function() {
                    if (this.classList.contains("blocked")) {
                        alert("This seat is already booked. Please select another seat.");
                    } else {
                        let seatNumber = this.getAttribute("data-seat");
                        window.location.href = "createBus.jsp?seat=" + seatNumber;
                    }
                });
            });
        });
    </script>

</body>
</html>
