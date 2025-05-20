<%@ page import="java.sql.*" %>
<%
    String acc_id = request.getParameter("acc_id");
    String flight_number = request.getParameter("flight_number");
    String two_letter_id = request.getParameter("two_letter_id");
    String passenger_first = request.getParameter("passenger_first");
    String passenger_last = request.getParameter("passenger_last");
    String id_number = request.getParameter("id_number");
    String seat_number = request.getParameter("seat_number");
    String ticket_class = request.getParameter("ticket_class");

    /* boolean isEconomy = false;
    boolean isBusiness = false;

    if (ticket_class.equals("economy")) {
        isEconomy = true;
    } else if (ticket_class.equals("business")) {
        isBusiness = true;
    }*/

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

        /* pstmt = con.prepareStatement("UPDATE flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id SET num_seats = num_seats - 1 WHERE flight_num = ?");
        pstmt.setString(1, flight_number);
        pstmt.executeUpdate(); */

        String ticketNumber = acc_id + flight_number + two_letter_id;

        pstmt = con.prepareStatement("INSERT INTO ticket_economy_business_first_changes_buys (ticket_number, acc_id, flight_num, passenger_first, passenger_last, id_number, seat_number, class, purchase_date_time, booking_fee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 25)");
        pstmt.setString(1, ticketNumber);
        pstmt.setString(2, acc_id);
        pstmt.setString(3, flight_number);
        pstmt.setString(4, passenger_first);
        pstmt.setString(5, passenger_last);
        pstmt.setString(6, id_number);
        pstmt.setString(7, seat_number);
        pstmt.setString(8, ticket_class);
        pstmt.executeUpdate();

        out.println("Reservation successful! Ticket number: " + ticketNumber + " <a href='customerrepwelcome.jsp'>go back</a>");
   		
        // if they were on the waiting list, remove them from waiting list
        String sql = "delete from waiting_list where acc_id = ? and flight_num = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, acc_id);
        ps.setString(2, flight_number);
        int affectedRows = ps.executeUpdate();
        if (affectedRows >= 1) {
        	System.out.println("bro is removed from waiting list");
        } else {
        	System.out.println("nobody removed from da waiting list");
        }
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
