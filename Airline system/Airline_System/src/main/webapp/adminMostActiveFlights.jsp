<%@ page import ="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select flight_num, count(ticket_number) as activity from ticket_economy_business_first_changes_buys group by flight_num order by activity desc");
	while (rs.next()){
		out.println("flight number: " + rs.getString(1) + "; tickets sold: " + rs.getInt(2) + "<br>");
	}
	out.println(" <a href='adminwelcome.jsp'>go back</a>");
	%>
	
	