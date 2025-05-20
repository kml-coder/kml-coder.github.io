<%@ page import ="java.sql.*" %>
<%
	String aircraft_id = request.getParameter("aircraft_id");
	String new_num_seats = request.getParameter("new_num_seats");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from aircraft where aircraft_id='" + aircraft_id + "'");
	if (rs.next()) {
		do {
			String sql = "update aircraft set num_seats = ? where aircraft_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, new_num_seats);
			ps.setString(2, aircraft_id);
			int affectedRows = ps.executeUpdate();
			out.println("aircraft edited :) <a href='customerrepwelcome.jsp'>go back</a>");
		} while (rs.next());
	} else {
		out.println("bruh <a href='customerrepwelcome.jsp'>go back</a>");
	}



	%>