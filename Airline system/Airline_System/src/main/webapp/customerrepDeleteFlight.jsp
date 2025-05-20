<%@ page import ="java.sql.*" %>
<%
	String flight_num = request.getParameter("flight_num");
	String two_letter_id = request.getParameter("two_letter_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	
	String sql = "delete from flight_search_operated_by where flight_num = ? and two_letter_id = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, flight_num);
	ps.setString(2, two_letter_id);
	int affectedRows = ps.executeUpdate();
	out.println("flight deleted :) <a href='customerrepwelcome.jsp'>go back</a>");
	

	%>