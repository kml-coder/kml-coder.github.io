<%@ page import ="java.sql.*" %>
<%
	String passenger_first = request.getParameter("passenger_first");
	String passenger_last = request.getParameter("passenger_last");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from flight_search_operated_by join ticket_economy_business_first_changes_buys on flight_search_operated_by.flight_num = ticket_economy_business_first_changes_buys.flight_num where passenger_first ='" + passenger_first + "' and passenger_last = '" + passenger_last + "'");
	
	if (!rs.next()) {
		out.println("Bruh <a href='adminwelcome.jsp'>go back</a>");
	} else {
		do {
			// ticket info
			String ticket_number = rs.getString("ticket_number");
			String acc_id = rs.getString("acc_id");
			int total_fare = rs.getInt("total_fare");
			String id_number = rs.getString("id_number");
			passenger_first = rs.getString("passenger_first");
			passenger_last = rs.getString("passenger_last");
			Timestamp purchase_date_time = rs.getTimestamp("purchase_date_time");
			float booking_fee = rs.getFloat("booking_fee");
			float change_ticket_fee = rs.getFloat("change_ticket_fee");
			String seat_number = rs.getString("seat_number");
			boolean is_economy = rs.getBoolean("is_economy");
			boolean is_business = rs.getBoolean("is_business");
			
			// flight info
			String flight_num = rs.getString("flight_num");
			Time arrival_time = rs.getTime("arrival_time");
			Time departure_time = rs.getTime("departure_time");
			Date arrival_date = rs.getDate("arrival_date");
			Date departure_date = rs.getDate("departure_date");
			// String waiting_list = rs.getString("waiting_list");
			String aircraft = rs.getString("aircraft");
			int num_seats = rs.getInt("num_seats");
			String days_of_operation = rs.getString("days_of_operation");
			boolean is_domestic = rs.getBoolean("is_domestic");
			String departure_airport = rs.getString("departure_airport");
			String destination_airport = rs.getString("destination_airport");
			boolean is_flexible = rs.getBoolean("is_flexible");
			
			// airline company info
			String two_letter_id = rs.getString("two_letter_id");
			
			out.println("account id: " + acc_id + " first name: " + passenger_first + " last name: " + passenger_last + " flight number: " + flight_num + " ticket number: " + ticket_number + " " + total_fare + " " + id_number  
			 + " " + purchase_date_time + " " + booking_fee + " " + 
			change_ticket_fee + " " + seat_number + " " + is_economy + " " + is_business + " " 
			+ arrival_time + " " + departure_time + " " + arrival_date + " " + departure_date + " " + aircraft + " " + num_seats + " " +
			days_of_operation + " " + is_domestic + " " + departure_airport + " " + destination_airport + " " + 
			is_flexible + "<br>");
		} while (rs.next());
		out.println("<a href='adminwelcome.jsp'>go back</a>");
	}
	
	%>