<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<%
    String airport_id = request.getParameter("airport_id");
    String date = request.getParameter("date");

    String url = "jdbc:mysql://localhost:3306/dbFinal";
    String username = "root";
    String password = "RUscr3w420!";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        String departingFlightQuery = "SELECT two_letter_id, flight_num, departure_time " +
                "FROM flight_search_operated_by " +
                "WHERE departure_date = ? AND departure_airport = ?";
        pstmt = conn.prepareStatement(departingFlightQuery);
        pstmt.setString(1, date);
        pstmt.setString(2, airport_id);
        rs = pstmt.executeQuery();

        out.println("<h3>Departures:</h3>");
        out.println("<table border='1'>");
        out.println("<tr><th>Airline Company ID</th><th>Flight Number</th><th>Departure Time</th></tr>");
        while (rs.next()) {
            String airline_id = rs.getString("two_letter_id");
            String flight_num = rs.getString("flight_num");
            String departure_time = rs.getString("departure_time");
            out.println("<tr><td>" + airline_id + "</td><td>" + flight_num + "</td><td>" + departure_time + "</td></tr>");
        }
        out.println("</table>");

        String arrivingFlightQuery = "SELECT two_letter_id, flight_num, arrival_time, departure_airport " +
                "FROM flight_search_operated_by " +
                "WHERE arrival_date = ? AND destination_airport = ?";
        pstmt = conn.prepareStatement(arrivingFlightQuery);
        pstmt.setString(1, date);
        pstmt.setString(2, airport_id);
        rs = pstmt.executeQuery();

        out.println("<h3>Arrivals:</h3>");
        out.println("<table border='1'>");
        out.println("<tr><th>Airline Company ID</th><th>Flight Number</th><th>Arrival Time</th><th>Departure Airport</th></tr>");
        while (rs.next()) {
            String airline_id = rs.getString("two_letter_id");
            String flight_num = rs.getString("flight_num");
            String arrival_time = rs.getString("arrival_time");
            String departure_airport = rs.getString("departure_airport");
            out.println("<tr><td>" + airline_id + "</td><td>" + flight_num + "</td><td>" + arrival_time + "</td><td>" + departure_airport + "</td></tr>");
        }
        out.println("</table>");
        out.println("<a href='customerrepwelcome.jsp'>go back</a></br>");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
