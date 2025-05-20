<%@ page import ="java.sql.*" %>
<%
	String username = request.getParameter("user");
	String ticket_number = request.getParameter("ticket_number");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from customer where username = '" + username +"'");
	if (!rs.next()) {
		out.println("No reservations with this username! " + username + " <a href='customerwelcome.jsp'>go back</a>");

	} else {
		String acc_id = rs.getString("acc_id");
		
		String sql = "select * from ticket_economy_business_first_changes_buys where acc_id = ? and ticket_number = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, acc_id);
		ps.setString(2, ticket_number);
		ResultSet rs2 = ps.executeQuery();
		

		if (rs2.next()) {
			String ticket_class = rs2.getString("class");
			if (!(ticket_class.equals("economy"))) {
				sql = "delete from ticket_economy_business_first_changes_buys where acc_id = ? and ticket_number = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, acc_id);
				ps.setString(2, ticket_number);
				int affectedRows = ps.executeUpdate();
				out.println("Reservation canceled! <a href='customerwelcome.jsp'>go back</a>");
			
			} else {
				out.println("You sneaky little economy rider, you tried to cancel, didn't you? Well, you can't! Hahahaha. <br> <a href='customerwelcome.jsp'>go back</a>");
			}
		} else {
			out.println("No reservations! <a href='customerwelcome.jsp'>go back</a>");
		}
		

	}
%>
	
	
	