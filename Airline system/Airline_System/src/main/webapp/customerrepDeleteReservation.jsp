<%@ page import ="java.sql.*" %>
<%
	String ticket_number = request.getParameter("ticket_number");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	
	String sql = "delete from ticket_economy_business_first_changes_buys where ticket_number = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, ticket_number);
	int affectedRows = ps.executeUpdate();
	if (affectedRows >= 1) {
		out.println("reservation deleted :) <a href='customerrepwelcome.jsp'>go back</a>");
	} else {
		out.println("you are trying to delete a reservation that doesn't exist. Why would you do that. <a href='customerrepwelcome.jsp'>go back</a>");
	}

	

	%>