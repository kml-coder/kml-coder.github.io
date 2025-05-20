<%@ page import ="java.sql.*" %>
<%
	
	System.out.println("yoyoyo");
	String three_letter_id = request.getParameter("three_letter_id");
	String new_three_letter_id = request.getParameter("new_three_letter_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from airport where three_letter_id='" + three_letter_id + "'");
	if (rs.next()) {
		do {
			String sql = "update airport set three_letter_id = ? where three_letter_id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, new_three_letter_id);
			ps.setString(2, three_letter_id);
			int affectedRows = ps.executeUpdate();
			out.println("airport edited :) <a href='customerrepwelcome.jsp'>go back</a>");
		} while (rs.next());
	} else {
		out.println("bruh <a href='customerrepwelcome.jsp'>go back</a>");
	}



	%>