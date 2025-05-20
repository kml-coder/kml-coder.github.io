<%@ page import ="java.sql.*" %>
<%
	String two_letter_id = request.getParameter("two_letter_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(booking_fee) from flight_search_operated_by join ticket_economy_business_first_changes_buys on ticket_economy_business_first_changes_buys.flight_num = flight_search_operated_by.flight_num where two_letter_id ='" + two_letter_id + "'");
	if (rs.next()) {
		out.println("Revenue from airline " + two_letter_id + ": $" + rs.getFloat(1) + " <a href='adminwelcome.jsp'>go back</a>");
	} else {
		out.println("bruh <a href='adminwelcome.jsp'>go back</a>");
	}
	%>
	
	
	