<%@ page import ="java.sql.*, java.text.SimpleDateFormat" %>
<%






String flight_num = request.getParameter("flight_num");
String two_letter_id = request.getParameter("two_letter_id");
String new_flight_num = request.getParameter("new_flight_num");
String new_two_letter_id = request.getParameter("new_two_letter_id");

// parsing times
SimpleDateFormat format = new SimpleDateFormat("HH:mm");
String departureTimeString = request.getParameter("new_departure_time");
java.util.Date parsedDate = format.parse(departureTimeString);
Time new_departure_time = new Time(parsedDate.getTime());
String arrivalTimeString = request.getParameter("new_arrival_time");
parsedDate = format.parse(departureTimeString);
Time new_arrival_time = new Time(parsedDate.getTime());

// parsing dates
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date new_departure_date = new java.sql.Date(dateFormat.parse(request.getParameter("new_departure_date")).getTime());
Date new_arrival_date = new java.sql.Date(dateFormat.parse(request.getParameter("new_arrival_date")).getTime());

String new_departure_airport = request.getParameter("new_departure_airport");
String new_destination_airport = request.getParameter("new_destination_airport");
String new_aircraft_id = request.getParameter("new_aircraft_id");
String new_days_of_operation = request.getParameter("new_days_of_operation");
boolean new_is_domestic = Boolean.parseBoolean(request.getParameter("new_is_domestic"));
float new_price = Float.parseFloat(request.getParameter("new_price"));
int new_num_of_stops = Integer.parseInt(request.getParameter("new_num_of_stops"));

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");

String sql = "update flight_search_operated_by set flight_num = ?, two_letter_id = ?, departure_time = ?, arrival_time = ?, departure_date = ?, arrival_date = ?, departure_airport = ?, destination_airport = ?, aircraft_id = ?, days_of_operation = ?, is_domestic = ?, price = ?, num_of_stops = ? where flight_num = ? and two_letter_id = ?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, new_flight_num);
ps.setString(2, new_two_letter_id);
ps.setTime(3, new_departure_time);
ps.setTime(4, new_arrival_time);
ps.setDate(5, new_departure_date);
ps.setDate(6, new_arrival_date);
ps.setString(7, new_departure_airport);
ps.setString(8, new_destination_airport);
ps.setString(9, new_aircraft_id);
ps.setString(10, new_days_of_operation);
ps.setBoolean(11, new_is_domestic);
ps.setFloat(12, new_price);
ps.setInt(13, new_num_of_stops);
ps.setString(14, flight_num);
ps.setString(15, two_letter_id);
int affectedRows = ps.executeUpdate();
out.println(affectedRows + " flight edited :) <a href='customerrepwelcome.jsp'>go back</a>");










/*
	try {

	} catch (Exception e) {
		out.println("error! <a href='customerrepwelcome.jsp'>go back</a> <br>" + e);
	}
*/
	


	%>