<%@ page import ="java.sql.*" %>
<%
	String username = request.getParameter("user");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from customer where username = '" + username +"'");
	if (!rs.next()) {
		out.println("No upcoming flights with this username! " + username + " <a href='customerwelcome.jsp'>go back</a>");

	} else {
		String acc_id = rs.getString("acc_id");
		// THIS QUERY IS GOOD FOR DATES BUT NOT DATETIMES
		String sql = "select * from ticket_economy_business_first_changes_buys join flight_search_operated_by on ticket_economy_business_first_changes_buys.flight_num = flight_search_operated_by.flight_num where ticket_economy_business_first_changes_buys.acc_id = ? and departure_date >= CURRENT_TIMESTAMP";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, acc_id);
		ResultSet rs2 = ps.executeQuery();
		if (!rs2.next()) {
			out.println("No upcoming flights! <a href='customerwelcome.jsp'>go back</a>");
		} else {
			do {
				
				//boolean is_first = false;
				//boolean is_economy = rs2.getBoolean("is_economy");
				//boolean is_business = rs2.getBoolean("is_business");
				//if (!is_economy && !is_business) is_first = true;
				String classType = rs2.getString(11);
				
				// ticket info
				acc_id = rs2.getString("acc_id");
				int total_fare = rs2.getInt("total_fare");
				String passenger_first = rs2.getString("passenger_first");
				String passenger_last = rs2.getString("passenger_last");
				Timestamp purchase_date_time = rs2.getTimestamp("purchase_date_time");
				float booking_fee = rs2.getFloat("booking_fee");
				String seat_number = rs2.getString("seat_number");
				String ticket_number = rs2.getString("ticket_number");
				// flight info
				String flight_num = rs2.getString("flight_num");
				Time arrival_time = rs2.getTime("arrival_time");
				Time departure_time = rs2.getTime("departure_time");
				Date arrival_date = rs2.getDate("arrival_date");
				Date departure_date = rs2.getDate("departure_date");
				boolean is_domestic = rs2.getBoolean("is_domestic");
				String departure_airport = rs2.getString("departure_airport");
				String destination_airport = rs2.getString("destination_airport");
				
				// airline company info
				String two_letter_id = rs2.getString("two_letter_id");
				
				out.println("<h3>ticket number: " + ticket_number + "</h3> <h5>flight number: " + flight_num + "</h5> <h5> account id: " + acc_id + "</h5><h5> price: " + total_fare + " " + "</h5><h5> first name: " 
				+ passenger_first + "</h5><h5> last name: " + passenger_last + "</h5><h5> purchase date and time: " + purchase_date_time + "</h5><h5> booking fee: " + booking_fee + 
				 "</h5><h5> seat number: " + seat_number + "</h5><h5> ticket class " + classType
				+ "</h5><h5> arrival time: " + arrival_time + "</h5><h5> departure time: " + departure_time + "</h5><h5> arrival date: " + arrival_date + "</h5><h5> departure date: " + departure_date + " " +
				 "</h5><h5> departure airport: " + departure_airport + "</h5><h5> destination airport: " + destination_airport + 
				"</h5><br>");
			} while (rs2.next());
			out.println("<a href='customerwelcome.jsp'>go back</a>");
		}
	}
%>
	
	
	