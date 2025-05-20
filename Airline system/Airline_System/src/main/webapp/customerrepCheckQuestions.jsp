<%@ page import ="java.sql.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from question");
	if (!rs.next()) {
		out.println("Bruh <a href='customerrepwelcome.jsp'>go back</a>");
	} else {
		do {
			
			String question = rs.getString("question");
			
			out.println("question: " + question + "<br>");
            out.println("<form action='customerrepReply.jsp' method='post'>"); 
            out.println("<input type='hidden' name='question' value='" + question + "' />"); 
            out.println("<input type='text' name='reply' />"); 
            out.println("<input type='submit' value='Send Reply' />"); 
            out.println("</form><br>");
		} while (rs.next());
		out.println("<a href='customerrepwelcome.jsp'>go back</a>");
	}
	
	%>