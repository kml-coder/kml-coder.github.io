<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
	String user = request.getParameter("user");
    String flight_number = request.getParameter("flight_number");

    Connection con = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String acc_id = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

        // Check for available seats on the flight
        pstmt = con.prepareStatement("SELECT aircraft.num_seats FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE flight_num = ?");
        pstmt.setString(1, flight_number);
        pstmt1 = con.prepareStatement("SELECT acc_id FROM customer WHERE username = ?");
        pstmt1.setString(1, user);
        rs = pstmt.executeQuery();
        rs1 = pstmt1.executeQuery();

        if (rs.next() && rs1.next()) {
            int availableSeats = rs.getInt("num_seats");
            // String currentWaitingList = rs.getString("waiting_list");
            acc_id = rs1.getString("acc_id");

            if (availableSeats > 0) {
                // Display form to collect passenger information and seat choice
%>
                <html>
                <head>
                    <title>Flight Reservation</title>
                </head>
                <body>
                    <h2>Enter Passenger Information</h2>
                    <form action="cus_create_ticket.jsp" method="post">
                        <input type="hidden" name="acc_id" value="<%= acc_id %>">
                        <input type="hidden" name="flight_number" value="<%= flight_number %>">
                        First Name: <input type="text" name="passenger_first" required><br>
                        Last Name: <input type="text" name="passenger_last" required><br>
                        ID Number: <input type="text" name="id_number" required><br>
                        <p>Available Seats:</p>
                        <select name="seat_number">
                            <% // Retrieve available seat numbers
                                pstmt = con.prepareStatement("SELECT seat_number FROM ticket_economy_business_first_changes_buys WHERE flight_num = ?");
                                pstmt.setString(1, flight_number);
                                rs = pstmt.executeQuery();

                                // Create a list of available seats
                                List<String> takenSeats = new ArrayList<>();
                                while (rs.next()) {
                                    takenSeats.add(rs.getString("seat_number"));
                                }

                                // Display available seats for selection
                                for (int i = 1; i <= availableSeats; i++) {
                                    String seat = String.valueOf(i);
                                    if (!takenSeats.contains(seat)) { // Check if seat is available
                                        out.println("<option value='" + seat + "'>" + seat + "</option>");
                                    }
                                }
                            %>
                        </select><br>
                        <p>Choose Ticket Type:</p>
                        <input type="radio" name="ticket_class" value="economy" required> Economy
                        <input type="radio" name="ticket_class" value="business"> Business
                        <input type="radio" name="ticket_class" value="firstClass"> First<br>
                        <input type="submit" value="Reserve Ticket">
                    </form>
                </body>
                </html>
<%
            } else {
                // Ask if the user wants to be placed on the waiting list
                out.println("No available seats. Do you want to be placed on the waiting list?");
                out.println("<form action='cus_add_to_waiting_list.jsp' method='post'>");
                out.println("<input type='hidden' name='acc_id' value='" + acc_id + "' />");
                out.println("<input type='hidden' name='flight_number' value='" + flight_number + "' />");
                out.println("<input type='submit' value='Add to Waiting List' />");
                out.println("</form>");
            }
        } else {
            out.println("Flight not found.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (rs1 != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (pstmt1 != null) pstmt1.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
