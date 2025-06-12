package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.helper.FactoryProvider;
import com.vignan.BusBooking;

@WebServlet("/BusBookingServlet")
public class BookBusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookBusServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            String passengerName = request.getParameter("passengerName"); 
            double payment = Double.parseDouble(request.getParameter("payment"));

            Session session = FactoryProvider.getFactory().openSession();
            Transaction tx = session.beginTransaction();

            // 1. Check if the seat is already booked
            List<BusBooking> existingBookings = session.createQuery("FROM BusBooking WHERE seatNumber = :seat", BusBooking.class)
                                                       .setParameter("seat", seatNumber)
                                                       .getResultList();
            
            if (!existingBookings.isEmpty()) {
                out.println("<h1 style='text-align:center; color:red;'>Seat " + seatNumber + " is already booked. Choose another seat.</h1>");
                out.println("<h1 style='text-align:center;'><a href='createBus.jsp'>Go back to the booking form</a></h1>");
                tx.rollback();
                session.close();
                return;
            }

            // 2. Validate Payment (₹500)
            if (payment != 500) {
                out.println("<h1 style='text-align:center; color:red;'>The payment must be ₹500. Please try again.</h1>");
                out.println("<h1 style='text-align:center;'><a href='createBus.jsp'>Go back to the booking form</a></h1>");
                tx.rollback();
                session.close();
                return;
            }

            // 3. Create & Save the Booking
            BusBooking booking = new BusBooking();
            booking.setSeatNumber(seatNumber);
            booking.setPersonName(passengerName); 
            booking.setPayment(payment);

            session.persist(booking);
            tx.commit();
            session.close();

            //  4. Success Message
            out.println("<h1 style='text-align:center;'>Seat " + seatNumber + " booked successfully</h1>");
            out.println("<h1 style='text-align:center;'><a href='listBookingss.jsp'>View all Bookings</a></h1>");

        } catch (NumberFormatException e) {
            showError(response, "Invalid input! Please check the entered details.");
        } catch (Exception e) {
            showError(response, "Error occurred while booking the bus seat. Please try again.");
            e.printStackTrace();
        }
    }

    private void showError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<h1 style='text-align:center; color:red;'>" + message + "</h1>");
            out.println("<h1 style='text-align:center;'><a href='createBus.jsp'>Go back to the booking form</a></h1>");
        }
    }
}
