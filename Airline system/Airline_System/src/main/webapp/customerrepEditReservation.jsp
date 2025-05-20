<%@ page import ="java.sql.*, java.text.SimpleDateFormat" %>
<%
	String acc_id = request.getParameter("acc_id");
	String ticket_number = request.getParameter("ticket_number");
	String new_flight_num = request.getParameter("new_flight_num");
	String businessUpgrade = request.getParameter("business");
	String firstClassUpgrade = request.getParameter("firstClass");
	String new_seat_number = request.getParameter("new_seat_number");
	float change_ticket_fee = 50;

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	String sql = "select * from ticket_economy_business_first_changes_buys where ticket_number = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, ticket_number);
	ResultSet rs = ps.executeQuery();
	if (rs.next()) {
		String old_flight_num = rs.getString("flight_num");
		String ticket_class = rs.getString("class");
		if (ticket_class.equals("economy")) { 
			// Adding the change ticket fee
			float booking_fee = rs.getFloat("booking_fee");
			booking_fee += change_ticket_fee;
			sql = "update ticket_economy_business_first_changes_buys set booking_fee = ? where ticket_number = ?";
			PreparedStatement ps2 = con.prepareStatement(sql);
			ps2.setFloat(1, booking_fee);
			ps2.setString(2, ticket_number);
			int rowsAffected = ps2.executeUpdate();
		}
		if (businessUpgrade != null && businessUpgrade.equals("business")) {
			// upgrading to business
			sql = "update ticket_economy_business_first_changes_buys set class = 'business' where ticket_number = ?";
			PreparedStatement ps3 = con.prepareStatement(sql);
			ps3.setString(1, ticket_number);
			int rowsAffected = ps3.executeUpdate();
		} 	else if (firstClassUpgrade != null && firstClassUpgrade.equals("firstClass")) {
				// upgrading to business
				sql = "update ticket_economy_business_first_changes_buys set class = 'firstClass' where ticket_number = ?";
				PreparedStatement ps3 = con.prepareStatement(sql);
				ps3.setString(1, ticket_number);
				int rowsAffected = ps3.executeUpdate();
		}
		
		// updating seat numbers of aircrafts, then updating ticket
		sql = "update aircraft join flight_search_operated_by on aircraft.aircraft_id = flight_search_operated_by.aircraft_id set num_seats = num_seats + 1 where flight_num = ?";
		PreparedStatement ps4 = con.prepareStatement(sql);
		ps4.setString(1, old_flight_num);
		int rowsAffected = ps4.executeUpdate();
		
		sql = "update aircraft join flight_search_operated_by on aircraft.aircraft_id = flight_search_operated_by.aircraft_id set num_seats = num_seats - 1 where flight_num = ?";
		PreparedStatement ps5 = con.prepareStatement(sql);
		ps5.setString(1, new_flight_num);
		rowsAffected = ps5.executeUpdate();
		
		sql = "update ticket_economy_business_first_changes_buys set flight_num = ?, seat_number = ? where ticket_number = ?";
		PreparedStatement ps6 = con.prepareStatement(sql);
		ps6.setString(1, new_flight_num);
		ps6.setString(2, new_seat_number);
		ps6.setString(3, ticket_number);
		rowsAffected = ps6.executeUpdate();
		
		out.println("Reservation updated ;) <a href='customerrepwelcome.jsp'>go back</a>");
	} else {
		out.println("No ticket found. DO BETTER. <a href='customerrepwelcome.jsp'>go back</a>");
	}
	%>
