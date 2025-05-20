<%@ page import ="java.sql.*, java.text.SimpleDateFormat" %>
<%

	try {
		String flight_num = request.getParameter("flight_num");
		String two_letter_id = request.getParameter("two_letter_id");
		
		
		// parsing times
		SimpleDateFormat format = new SimpleDateFormat("HH:mm");
		String departureTimeString = request.getParameter("departure_time");
		java.util.Date parsedDate = format.parse(departureTimeString);
		Time departure_time = new Time(parsedDate.getTime());
		String arrivalTimeString = request.getParameter("arrival_time");
		parsedDate = format.parse(departureTimeString);
		Time arrival_time = new Time(parsedDate.getTime());
		float price = Float.parseFloat(request.getParameter("price"));
		
		// parsing dates
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date departure_date = new java.sql.Date(dateFormat.parse(request.getParameter("departure_date")).getTime());
		Date arrival_date = new java.sql.Date(dateFormat.parse(request.getParameter("arrival_date")).getTime());
		
		String departure_airport = request.getParameter("departure_airport");
		String destination_airport = request.getParameter("destination_airport");
		String aircraft_id = request.getParameter("aircraft_id");
		String days_of_operation = request.getParameter("days_of_operation");
		boolean is_domestic = Boolean.parseBoolean(request.getParameter("is_domestic"));
		int num_of_stops = Integer.parseInt(request.getParameter("num_of_stops"));
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
		
		
		String sql = "insert ignore into flight_search_operated_by(flight_num, two_letter_id, departure_time, arrival_time, departure_date, arrival_date, departure_airport, destination_airport, aircraft_id, days_of_operation, is_domestic, price, num_of_stops) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, flight_num);
		ps.setString(2, two_letter_id);
		ps.setTime(3, departure_time);
		ps.setTime(4, arrival_time);
		ps.setDate(5, departure_date);
		ps.setDate(6, arrival_date);
		ps.setString(7, departure_airport);
		ps.setString(8, destination_airport);
		ps.setString(9, aircraft_id);
		ps.setString(10, days_of_operation);
		ps.setBoolean(11, is_domestic);
		ps.setFloat(12, price);
		ps.setInt(13, num_of_stops);
		int affectedRows = ps.executeUpdate();
		out.println(affectedRows + " flight added :) <a href='customerrepwelcome.jsp'>go back</a>");
		

	} catch (Exception e) {
		out.println("error! <a href='customerrepwelcome.jsp'>go back</a>");
	}

 

	%>
	