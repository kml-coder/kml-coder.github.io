<%@ page import ="java.sql.*" %>
<%
	String acc_id = request.getParameter("acc_id");
	String new_username = request.getParameter("new_username");
	String new_password = request.getParameter("new_password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from customer where acc_id='" + acc_id + "'");
	if (rs.next()) {
		String sql = "update customer set username = ?, password = ? where acc_id = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, new_username);
		ps.setString(2, new_password);
		ps.setString(3, acc_id);
		int affectedRows = ps.executeUpdate();
		response.sendRedirect("adminwelcome.jsp");
	} else {
		out.println("bruh <a href='adminwelcome.jsp'>go back</a>");
	}


	%>