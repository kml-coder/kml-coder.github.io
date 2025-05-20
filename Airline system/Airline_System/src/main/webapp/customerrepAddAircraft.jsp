<%@ page import ="java.sql.*" %>
<%
	String aircraft_id = request.getParameter("aircraft_id");
	String new_num_seats = request.getParameter("new_num_seats");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	
	String sql = "insert ignore into aircraft values (?, ?)";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, aircraft_id);
	ps.setString(2, new_num_seats);
	int affectedRows = ps.executeUpdate();
	out.println("aircraft added :) <a href='customerrepwelcome.jsp'>go back</a>");
	

	%>