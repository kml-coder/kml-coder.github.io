<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.ArrayList" %>
<%
	if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="triplelogin.jsp">Please Login</a>
<%} else {
%>

<%
String username = (String) session.getAttribute("user");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from customer where username = '" + username +"'");
if (rs.next()) {
	String acc_id = rs.getString("acc_id");
	session.setAttribute("acc_id", acc_id);
	Statement st2 = con.createStatement();
	ResultSet rs2 = st2.executeQuery("select * from waiting_list where acc_id = '" + acc_id + "'");
	while (rs2.next()) {
		String flight_num = rs2.getString("flight_num");
		String sql = "select * from flight_search_operated_by join aircraft on flight_search_operated_by.aircraft_id = aircraft.aircraft_id where flight_num = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, flight_num);
		ResultSet rs3 = ps.executeQuery();
		if (rs3.next()) {
			int num_seats = rs3.getInt("num_seats");
			
			// get a list of all tickets associated with the flight, iterate through all seat numbers.
			// if there is a seat number not in the list, there's an open seat.
			sql = "select seat_number from ticket_economy_business_first_changes_buys where flight_num = ?";
			PreparedStatement psTix = con.prepareStatement(sql);
			psTix.setString(1, flight_num);
			ResultSet ticketResult = psTix.executeQuery();
			
			ArrayList<String> takenSeats = new ArrayList<String>();
			while (ticketResult.next()) {
				System.out.println("found ticket!");
				String seatNumber = ticketResult.getString("seat_number");
				takenSeats.add(seatNumber);
				System.out.println("Seat Number: " + seatNumber);
			}
			
			String availableSeat = null;
			for(int i = 1; i <= num_seats; i++) {
				if (!takenSeats.contains(String.valueOf(i))) {
					availableSeat = String.valueOf(i);
					break;
				}
			}
			
			
			
			if (availableSeat != null) {
				out.println("<h4> THERE ARE SEATS AVAILABLE FOR FLIGHT " + flight_num + "!</h4>");
			}
		}
	}
}
%>

Welcome Customer <%=session.getAttribute("user")%> 
<a href='logout.jsp'>Log out</a>

<form action="customerCheckReplies.jsp" method="post">
    <input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    <input type="submit" value="Check Question and Answer" />
</form>

<form action="customerCheckRepliesKeyword.jsp" method="post">
    <input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    Input Keyword Here: <input type="text" name="keyword" /><br/>
    <input type="submit" value="Check Question and Answer by Keyword" />
</form>

 <!--  <h2>Make Flight Reservation</h2>
    <form action="customer_make_reservation.jsp" method="post">
    	<input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    	Flight number: <input type="text" name="flight_number" /><br/>
    	<input type="submit" value="Make Flight Reservation" />
    </form> -->
    
    <form action="customerpurchase.jsp" method="post">
    	<input type="submit" value="Make Flight Reservation" />
    </form>

<form action="customerPostQuestions.jsp" method="post">
    Input Question Here: <input type="text" name="question" /><br/>
    Type in username: <input type="text" name="username" /><br/>
    Type in password: <input type="text" name="password" /><br/>
    <input type="submit" value="Submit Question!" />
</form>

<form action="customerViewPastReservations.jsp" method="post">
    <input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    <input type="submit" value="View Past Reservations" />
</form>

<form action="customerViewUpcomingReservations.jsp" method="post">
    <input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    <input type="submit" value="View Upcoming Reservations" />
</form>

<form action="customerCancelReservation.jsp" method="post">
    Input Ticket Number to Cancel: <input type="text" name="ticket_number" /><br/>
    <input type="hidden" name="user" value="<%=session.getAttribute("user")%>" />
    <input type="submit" value="Cancel Reservation" />
</form>

<%
	}
%>