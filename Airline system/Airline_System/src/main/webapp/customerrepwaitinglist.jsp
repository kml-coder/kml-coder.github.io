<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Waiting List</title>
</head>
<body>

<%


String flight_number = request.getParameter("flight_number");

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

pstmt = con.prepareStatement("SELECT * FROM waiting_list JOIN customer ON waiting_list.acc_id = customer.acc_id WHERE flight_num = ?");
pstmt.setString(1, flight_number);
rs = pstmt.executeQuery();

out.println("<h2>Waiting List for Flight " + flight_number + "</h2> <a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a> <br>");
		
	while (rs.next()) {
		String acc_id = rs.getString("acc_id");
		String username = rs.getString("username");
		String flight_num = rs.getString("flight_num");
		
		out.println("flight number: " + flight_num + " acc_id: " + acc_id + " username: " + username + "<br>");
		
	}











/*
    try {
        Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

        pstmt = con.prepareStatement("SELECT waiting_list FROM flight_search_operated_by WHERE flight_num = ?");
        pstmt.setString(1, flight_number);
        rs = pstmt.executeQuery();

        String waitingList = "";

        if (rs.next()) {
            waitingList = rs.getString("waiting_list");
        }

        out.println("<h2>Waiting List for Flight " + flight_number + "</h2>");

        if (waitingList != null && waitingList.contains(acc_id)) {
            out.println("<p>You are on the waiting list for this flight.</p>");
        } else {
            out.println("<p>You are not currently on the waiting list for this flight.</p>");
            out.println("<form action='add_to_waiting_list.jsp'>");
            out.println("<input type='hidden' name='acc_id' value='" + acc_id + "' />");
            out.println("<input type='hidden' name='flight_number' value='" + flight_number + "' />");
            out.println("<input type='submit' value='Add Me to Waiting List' />");
            out.println("</form>");
        }

        out.println("<br/><a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
*/
%>

</body>
</html>
