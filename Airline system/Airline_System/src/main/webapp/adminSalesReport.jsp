<%@ page import ="java.sql.*" %>
<%
	String month = request.getParameter("month");
	String year = request.getParameter("year");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(booking_fee) from ticket_economy_business_first_changes_buys where month(purchase_date_time) ='" + month + "' and year(purchase_date_time) ='" + year + "'");
	if (rs.next()) {
		out.println("You made " + rs.getInt(1) + " dollars in month " + month + " and year " + year + "! <a href='adminwelcome.jsp'>go back</a>");
	} else {
		out.println("You made NO MONEY! LOSER! <a href='adminwelcome.jsp'>go back</a>");
	}
	%>
	
	
	