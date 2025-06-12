<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bus Management</title>
    <style>
        /* Add your CSS styles here */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .operation-links {
            margin-top: 20px;
        }
        .operation-links a {
            display: inline-block;
            margin: 10px;
            text-decoration: none;
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
            border-radius: 5px;
        }
        .operation-links a:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Bus Management</h1>
   <!-- Icons for navigation -->
    <div class="icon-container">
              <a href="index.jsp" class="icon bus-icon"><h1>🚌</h1></a>
    </div>
    <div class="operation-links">
        
        <a href="listBookingss.jsp">List Buses</a>
        <a href="updateBus.jsp">Update Bus</a>
        <a href="deleteBus.jsp">Delete Bus</a>
    </div>
</body>
</html>
