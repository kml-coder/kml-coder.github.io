<%@ page import ="java.sql.*" %>
<%
	String flight_num = request.getParameter("flight_num");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(booking_fee) from ticket_economy_business_first_changes_buys where flight_num ='" + flight_num + "'");
	if (rs.next()) {
		out.println("Revenue from flight " + flight_num + ": $" + rs.getFloat(1) + " <a href='adminwelcome.jsp'>go back</a>");
	} else {
		out.println("bruh <a href='adminwelcome.jsp'>go back</a>");
	}
	%>
	
	
	