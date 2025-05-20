<%@ page import ="java.sql.*" %>
<%
	String acc_id = request.getParameter("acc_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(booking_fee) from ticket_economy_business_first_changes_buys where acc_id ='" + acc_id + "'");
	if (rs.next()) {
		out.println("Revenue from customer " + acc_id + ": $" + rs.getFloat(1) + " <a href='adminwelcome.jsp'>go back</a>");
	} else {
		out.println("bruh <a href='adminwelcome.jsp'>go back</a>");
	}
	%>
	
	
	