<%@ page import ="java.sql.*" %>
<%
	String acc_id = request.getParameter("acc_id");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	String sql = "delete from customer_rep where acc_id = ?";
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, acc_id);
	int affectedRows = ps.executeUpdate();
	if (affectedRows >= 1 ){
		sql = "delete from account_associates where acc_id = ?";
		PreparedStatement ps2 = con.prepareStatement(sql);
		ps2.setString(1, acc_id);
		affectedRows = ps2.executeUpdate();
	}
	response.sendRedirect("adminwelcome.jsp");
	%>