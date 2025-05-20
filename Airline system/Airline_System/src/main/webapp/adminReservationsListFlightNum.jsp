<%@ page import ="java.sql.*" %>
<%
	String flight_num = request.getParameter("flight_num");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from flight_search_operated_by join ticket_economy_business_first_changes_buys on flight_search_operated_by.flight_num = ticket_economy_business_first_changes_buys.flight_num where flight_search_operated_by.flight_num ='" + flight_num + "'");
	
	if (!rs.next()) {
		out.println("Bruh <a href='adminwelcome.jsp'>go back</a>");
	} else {
		do {
			// ticket info
			String ticket_number = rs.getString("ticket_number");
			String acc_id = rs.getString("acc_id");
			int total_fare = rs.getInt("total_fare");
			String passenger_first = rs.getString("passenger_first");
			String passenger_last = rs.getString("passenger_last");
			Timestamp purchase_date_time = rs.getTimestamp("purchase_date_time");
			float booking_fee = rs.getFloat("booking_fee");
			float change_ticket_fee = rs.getFloat("change_ticket_fee");
			String seat_number = rs.getString("seat_number");
			boolean is_economy = rs.getBoolean("is_economy");
			boolean is_business = rs.getBoolean("is_business");
			
			// flight info
			flight_num = rs.getString("flight_num");
			Time arrival_time = rs.getTime("arrival_time");
			Time departure_time = rs.getTime("departure_time");
			Date arrival_date = rs.getDate("arrival_date");
			Date departure_date = rs.getDate("departure_date");
			String aircraft_id = rs.getString("aircraft_id");
			String days_of_operation = rs.getString("days_of_operation");
			boolean is_domestic = rs.getBoolean("is_domestic");
			String departure_airport = rs.getString("departure_airport");
			String destination_airport = rs.getString("destination_airport");
			boolean is_flexible = rs.getBoolean("is_flexible");
			
			// airline company info
			String two_letter_id = rs.getString("two_letter_id");
			
			out.println("<h3>flight number: " + flight_num + "</h3> ticket number: " + ticket_number + " account id: " + acc_id + " total_fare: " + total_fare + " " + " first name: " 
			+ passenger_first + " last name: " + passenger_last + " purchase date time: " + purchase_date_time + " booking fee: " + booking_fee + " change ticket fee: " + 
			change_ticket_fee + " seat number: " + seat_number + " is economy? " + is_economy + " is business? " + is_business + " arrival time: " 
			+ arrival_time + " departure time: " + departure_time + " arrival date: " + arrival_date + " departure date: " + departure_date + " aircraft id: " + aircraft_id + " days of operation: " +
			days_of_operation + " is domestic? " + is_domestic + " departure airport: " + departure_airport + " destination airport: " + destination_airport + "<br>");
				
		} while (rs.next());
		out.println("<a href='adminwelcome.jsp'>go back</a>");
	}
	
	%>