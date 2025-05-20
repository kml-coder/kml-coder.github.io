<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    String acc_id = request.getParameter("acc_id");
    String flight_number = request.getParameter("flight_number");
    String two_letter_id = request.getParameter("two_letter_id");

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

        // Check for available seats on the flight
        pstmt = con.prepareStatement("SELECT aircraft.num_seats FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE flight_num = ? and two_letter_id = ?");
        pstmt.setString(1, flight_number);
        pstmt.setString(2, two_letter_id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
        	System.out.println("if activated!");
            int availableSeats = rs.getInt("num_seats");
            System.out.println("available seats: " + availableSeats);

            if (availableSeats >= 0) {
            	System.out.println("activeAvailabletSeats!?");
                // Display form to collect passenger information and seat choice
                
                
                // Retrieve available seat numbers

                pstmt = con.prepareStatement("SELECT seat_number FROM ticket_economy_business_first_changes_buys JOIN flight_search_operated_by ON ticket_economy_business_first_changes_buys.flight_num = flight_search_operated_by.flight_num WHERE ticket_economy_business_first_changes_buys.flight_num = ? and two_letter_id = ?");
                pstmt.setString(1, flight_number);
                pstmt.setString(2, two_letter_id);
                rs = pstmt.executeQuery();
                                
                // Create a list of available seats
                List<String> takenSeats = new ArrayList<>();
                while (rs.next()) {
                      System.out.println("taken seat: " + rs.getString("seat_number"));
                      takenSeats.add(rs.getString("seat_number"));
                }
                
                if (takenSeats.size() >= availableSeats) {
                    // Ask if the user wants to be placed on the waiting list
                    out.println("No available seats. Do you want to be placed on the waiting list?");
                    out.println("<form action='cusrep_add_to_waiting_list.jsp' method='post'>");
                    out.println("<input type='hidden' name='acc_id' value='" + acc_id + "' />");
                    out.println("<input type='hidden' name='flight_number' value='" + flight_number + "' />");
                    out.println("<input type='submit' value='Add to Waiting List' />");
                    out.println("</form>");
                } else {%>
                                <html>
                <head>
                    <title>Flight Reservation</title>
                </head>
                <body>
                    <h2>Enter Passenger Information</h2>
                    <form action="cusrep_create_ticket.jsp" method="post">
                        <input type="hidden" name="acc_id" value="<%= acc_id %>">
                        <input type="hidden" name="flight_number" value="<%= flight_number %>">
                        <input type="hidden" name="two_letter_id" value="<%= two_letter_id %>">
                        First Name: <input type="text" name="passenger_first" required><br>
                        Last Name: <input type="text" name="passenger_last" required><br>
                        <!--  ID Number: <input type="text" name="id_number" required><br> -->
                        <p>Available Seats:</p>
                        <select name="seat_number">
                            <% 

                                // Display available seats for selection
                                for (int i = 1; i <= availableSeats; i++) {
                                	// System.out.println("haha index: " + i);
                                    String seat = String.valueOf(i);
                                    if (!takenSeats.contains(seat)) { // Check if seat is available
                                    	// System.out.println("i: " + i);
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
                	
                <%}%>

<%
            } else {

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
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
