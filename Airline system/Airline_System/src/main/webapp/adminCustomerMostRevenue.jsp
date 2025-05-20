<%@ page import ="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select acc_id, most_revenue from (select acc_id, sum(booking_fee) as most_revenue from ticket_economy_business_first_changes_buys group by acc_id) as customer_totals order by most_revenue desc limit 1");
	if (rs.next()) {
		out.println("Highest spending customer's account id and their expenses: <h3>account id: " + rs.getString(1) + "</h3> <h3>expenditures: $" + rs.getFloat(2) + "</h3> <a href='adminwelcome.jsp'>go back</a>");
	} else {
		out.println("no customers found <a href='adminwelcome.jsp'>go back</a>");
	}
	%>
	
	

	
	
	