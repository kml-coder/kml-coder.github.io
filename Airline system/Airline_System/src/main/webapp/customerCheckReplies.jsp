<%@ page import ="java.sql.*" %>
<%
	String user = request.getParameter("user");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from reply");
	if (!rs.next()) {
		out.println("Bruh <a href='customerwelcome.jsp'>go back</a>");
	} else {
		do {
			
			String question = rs.getString("question");
			String reply = rs.getString("reply");
			
			out.println("A customer rep has replied to the question '" + question + "': " + reply + "<br>");
		} while (rs.next());
		out.println("<a href='customerwelcome.jsp'>go back</a>");
	}
%>
	
	
	