<%@ page import ="java.sql.*" %>
<%
	String aircraft_id = request.getParameter("aircraft_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	
	String sql = "delete from aircraft where aircraft_id = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, aircraft_id);
	int affectedRows = ps.executeUpdate();
	out.println("aircraft deleted :) <a href='customerrepwelcome.jsp'>go back</a>");
	

	%>