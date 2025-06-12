package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.query.Query;
import com.helper.FactoryProvider;
import com.vignan.BusBooking;

@WebServlet("/updateBusBookingServlet")
public class UpdateBusBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
        String personName = request.getParameter("personName");
        String seatStatus = request.getParameter("seatStatus"); // Booked or Available
        double payment = Double.parseDouble(request.getParameter("payment"));

        Session session = FactoryProvider.getFactory().openSession();

        try {
            session.beginTransaction();
            BusBooking booking = session.get(BusBooking.class, bookingId);

            if (booking != null) {
                // Validation: Check payment amount
                if (payment != 500) {
                    request.setAttribute("error", "Payment must be exactly 500.");
                    request.getRequestDispatcher("updateBus.jsp").forward(request, response);
                    return;
                }

                // Validation: Check if seat is already booked
                if ("Booked".equalsIgnoreCase(booking.getSeatStatus())) {
                    request.setAttribute("error", "This seat is already booked.");
                    request.getRequestDispatcher("updateBus.jsp").forward(request, response);
                    return;
                }

                // Validation: Check if the seat number is already assigned to another booking
                Query<Long> query = session.createQuery("SELECT COUNT(*) FROM BusBooking WHERE seatNumber = :seatNumber AND id != :bookingId", Long.class);
                query.setParameter("seatNumber", seatNumber);
                query.setParameter("bookingId", bookingId);
                long count = query.uniqueResult();

                if (count > 0) {
                    request.setAttribute("error", "This seat is already booked. Please choose another seat.");
                    request.getRequestDispatcher("updateBus.jsp").forward(request, response);
                    return;
                }

                // Update booking details
                booking.setSeatNumber(seatNumber);
                booking.setPersonName(personName);
                booking.setSeatStatus(seatStatus);
                booking.setPayment(payment);
                session.merge(booking);

                session.getTransaction().commit();

                response.sendRedirect("updateBus.jsp?success=Booking updated successfully!");
            } else {
                request.setAttribute("error", "Booking Not Found.");
                request.getRequestDispatcher("updateBus.jsp").forward(request, response);
            }
        } finally {
            session.close();
        }
    }
}
