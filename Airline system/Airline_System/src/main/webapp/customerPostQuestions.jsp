<%@ page import ="java.sql.*" %>
<%
	String question = request.getParameter("question");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from customer where username='" + username + "' and password ='" + password + "'");
	if (!rs.next()) {
		out.println("Bruh <a href='customerwelcome.jsp'>go back</a>");
	} else {
		String sql = "insert ignore into question values (?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, username);
		ps.setString(2, question);
		int affectedRows = ps.executeUpdate();
		out.println("Question Recorded :) <a href='customerwelcome.jsp'>go back</a>");
	}
%>
	
	
	