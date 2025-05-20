<%@ page import ="java.sql.*" %>
<%
	String three_letter_id = request.getParameter("three_letter_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	
	String sql = "delete from airport where three_letter_id = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, three_letter_id);
	int affectedRows = ps.executeUpdate();
	out.println("airport deleted :) <a href='customerrepwelcome.jsp'>go back</a>");
	

	%>