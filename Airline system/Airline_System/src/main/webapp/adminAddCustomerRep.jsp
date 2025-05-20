<%@ page import ="java.sql.*" %>
<%
	String acc_id = request.getParameter("acc_id");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from account_associates where acc_id='" + acc_id + "'");
	if (rs.next()) {
		response.sendRedirect("adminwelcome.jsp");
	} else {
		String sql = "insert ignore into account_associates values (?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, acc_id);
		int affectedRows = ps.executeUpdate();
		sql = "insert ignore into customer_rep values (?, ?, ?)";
		PreparedStatement ps2 = con.prepareStatement(sql);
		ps2.setString(1, acc_id);
		ps2.setString(2, username);
		ps2.setString(3, password);
		affectedRows = ps2.executeUpdate();
		response.sendRedirect("adminwelcome.jsp");
	}
	%>