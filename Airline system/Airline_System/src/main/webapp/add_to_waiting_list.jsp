<%@ page import="java.sql.*" %>
<%
    String acc_id = request.getParameter("acc_id");
    String flight_number = request.getParameter("flight_number");
    
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
    	
    	pstmt = con.prepareStatement("Select * from waiting_list where acc_id = ? and flight_num = ?");
    	pstmt.setString(1, acc_id);
    	pstmt.setString(2, flight_number);
    	rs = pstmt.executeQuery();
    	if (rs.next()) {
    		out.println("you're already on the waiting list bruh. <a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a>");
    	} else {
        	PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO waiting_list VALUES (?, ?)");
        	pstmt2.setString(1, acc_id);
        	pstmt2.setString(2, flight_number);
        	int affectedRows = pstmt2.executeUpdate();
        	out.println("You have been added to the waiting list for the flight. <a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a>");
    	}
    	

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
%>

<% /*
        pstmt = con.prepareStatement("SELECT waiting_list FROM flight_search_operated_by WHERE flight_num = ?");
        pstmt.setString(1, flight_number);
        rs = pstmt.executeQuery();

        String currentWaitingList = null;

        if (rs.next()) {
            currentWaitingList = rs.getString("waiting_list");
        }

        if (currentWaitingList == null || !currentWaitingList.contains(acc_id)) {
            if (currentWaitingList == null) {
                currentWaitingList = acc_id;
            } else {
                currentWaitingList += "," + acc_id;
            }

            pstmt = con.prepareStatement("UPDATE flight_search_operated_by SET waiting_list = ? WHERE flight_num = ?");
            pstmt.setString(1, currentWaitingList);
            pstmt.setString(2, flight_number);
            pstmt.executeUpdate();

            out.println("You have been added to the waiting list for the flight. <a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a>");
        } else {
            out.println("You are already on the waiting list for this flight. <a href='customerrepwelcome.jsp'>Back to Customer Rep Welcome Page</a>");
        }
   */ %>