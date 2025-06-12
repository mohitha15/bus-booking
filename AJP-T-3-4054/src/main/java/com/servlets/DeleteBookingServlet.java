package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import com.helper.FactoryProvider;
import com.vignan.BusBooking;

@SuppressWarnings("serial")
@WebServlet("/deleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
            return;
        }

        int bookingId = Integer.parseInt(idParam);
        Session session = FactoryProvider.getFactory().openSession();

        try {
            session.beginTransaction();

            BusBooking booking = session.find(BusBooking.class, bookingId);
            if (booking != null) {
                session.remove(booking);
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<h1 style='text-align:center;'>Booking Not Found</h1>");
                out.println("<h1 style='text-align:center;'><a href='listBookings.jsp'>View all Bookings</a></h1>");
            }

            session.getTransaction().commit();
        } finally {
            session.close();
        }

        response.sendRedirect("deleteBus.jsp");
    }
}
