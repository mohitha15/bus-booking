package com.vignan;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "bus_bookings")
public class BusBooking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "bus_number")
    private String busNumber;

    @Column(name = "seat_number")
    private int seatNumber;

    @Column(name = "person_name")
    private String personName;

    @Column(name = "seat_status")
    private String seatStatus; // Blocked or Empty

    @Column(name = "payment")
    private double payment;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBusNumber() {
        return busNumber;
    }

    public void setBusNumber(String busNumber) {
        this.busNumber = busNumber;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getSeatStatus() {
        return seatStatus;
    }

    public void setSeatStatus(String seatStatus) {
        this.seatStatus = seatStatus;
    }

    public double getPayment() {
        return payment;
    }

    public void setPayment(double payment) {
        this.payment = payment;
    }

    public BusBooking(int id, String busNumber, int seatNumber, String personName, String seatStatus, double payment) {
        super();
        this.id = id;
        this.busNumber = busNumber;
        this.seatNumber = seatNumber;
        this.personName = personName;
        this.seatStatus = seatStatus;
        this.payment = payment;
    }

    public BusBooking() {
        super();
    }
}
