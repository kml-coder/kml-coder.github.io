<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<%
String jdbcUrl = "jdbc:mysql://localhost:3306/dbFinal";
String username = "root";
String password = "RUscr3w420!";

Connection con = null;
Statement st = null;
ResultSet rs = null;



String depAirport = request.getParameter("depAirport");
String destAirport = request.getParameter("destAirport");
String departDate = request.getParameter("returnDate");
String sort = request.getParameter("sort");
String filter = request.getParameter("filter");
//remember to if departDate
String tripType = request.getParameter("tripType");
String flex = request.getParameter("flex");
String numOfStops = request.getParameter("numOfStops");
String minVal= request.getParameter("minVal");
String maxVal = request.getParameter("maxVal");
String origAirline = request.getParameter("flightId");
String origFlightNumber = request.getParameter("flightNum");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(jdbcUrl, username, password);
    st = con.createStatement();

        
 // out.println(origAirline + " " + origFlightNumber + " "  + flex + " " + tripType + " " + depAirport + " " + destAirport  + " " + departDate + " " + sort +  " " + filter +  " " + numOfStops + " " + minVal + " " + maxVal + "end");
  
    if(flex == null){
    	flex = "off";
    }
    
   
  //out.println(flex);
    
   // out.println(depAirport + " " + destAirport + " " + departDate + " " + returnDate + "<br>");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Date depDate = dateFormat.parse(departDate);
    Calendar flexDepDatePlus = Calendar.getInstance();
    flexDepDatePlus.setTime(depDate);
    flexDepDatePlus.add(Calendar.DAY_OF_MONTH, 3);
    String strFlexDepDatePlus = dateFormat.format(flexDepDatePlus.getTime());
    Calendar flexDepDateMinus = Calendar.getInstance();
    flexDepDateMinus.setTime(depDate);
    flexDepDateMinus.add(Calendar.DAY_OF_MONTH, -3);
    String strFlexDepDateMinus = dateFormat.format(flexDepDateMinus.getTime());
    
    
   
    // Build the SQL query with dynamic filtering
    StringBuilder queryBuilder = new StringBuilder("SELECT *, TIMEDIFF(arrival_time, departure_time) AS flight_duration FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE departure_airport='");
    queryBuilder.append(depAirport).append("' AND destination_airport='").append(destAirport).append("'");
 
 
  if(flex.equals("on")){
	  if(tripType.equals("roundTrip")){
		  //queryBuilder.append(" AND departure_date BETWEEN '").append(departDate).append("' AND '").append(returnDate).append("'");
		  //need to run 2nd query option flex
		  queryBuilder.append(" AND departure_date BETWEEN '").append(strFlexDepDateMinus).append("' AND '").append(strFlexDepDatePlus).append("'");
		  }else{
			  queryBuilder.append(" AND departure_date BETWEEN '").append(strFlexDepDateMinus).append("' AND '").append(strFlexDepDatePlus).append("'");
		  }
	      
  }else{
	  if(tripType.equals("roundTrip")){
		  //queryBuilder.append(" AND departure_date BETWEEN '").append(departDate).append("' AND '").append(returnDate).append("'");
		  queryBuilder.append(" AND departure_date= '").append(departDate).append("'");
		  //need to run 2nd query option no flex
		  }else{
			  queryBuilder.append(" AND departure_date= '").append(departDate).append("'");
		  }
  }
  
 
    // Additional filters based on user input
    if (filter != null ) {
     	switch(filter){
     	case "price": queryBuilder.append(" AND price BETWEEN ").append(minVal).append(" AND ").append(maxVal);
     	break;
     	case "airline":queryBuilder.append(" AND two_letter_id='").append(origAirline).append("'");
     	break;
     	case "takeOffTime":queryBuilder.append(" AND departure_time BETWEEN '").append(minVal).append("' AND '").append(maxVal).append("'");
     	break;
     	case "landingTime":queryBuilder.append(" AND arrival_time BETWEEN '").append(minVal).append("' AND '").append(maxVal).append("'");
     	break;
     	case "numberOfStops":queryBuilder.append(" AND num_of_stops='").append(numOfStops).append("'");
     	break;
     	
     	}
       
    }
    
    if (sort != null ) {
     	switch(sort){
     	case "price": queryBuilder.append(" ORDER BY price ");
     	break;
     	case "durationOfFlight": queryBuilder.append(" ORDER BY flight_duration ");
     	break;
     	case "takeOffTime":queryBuilder.append(" ORDER BY departure_time ");
     	break;
     	case "landingTime":queryBuilder.append(" ORDER BY arrival_time ");
     	break;
     	
     	}
       
    }
    
 
    
 
    

    // Add more filters for airline, takeoff time, and landing time as needed

    // Execute the final query
    rs = st.executeQuery(queryBuilder.toString());
    
    out.println("Departing Flights");
    out.println("<br>");
    out.println("<table border='1'>");
    out.println("<tr><th>Flight Number</th><th>Airline</th><th>Arrival Time</th><th>Departure Time</th><th>Flight Date</th><th>Number Of Seats</th><th>Departing Airport</th><th>Arrival Airport</th><th>Price</th><th>Action</th></tr>");

    // Process the ResultSet as needed
    
    if (rs.next()) {
    	 do {    
    	out.println("<tr>");
        out.println("<td>" + rs.getString(1) + "</td>"); // flight num
        out.println("<td>" + rs.getString(2) + "</td>"); // airline
        out.println("<td>" + rs.getString(4) + "</td>"); // arrival time
        out.println("<td>" + rs.getString(5) + "</td>"); // departure time
        out.println("<td>" + rs.getString(7) + "</td>"); // flight date
        out.println("<td>" + rs.getString(17) + "</td>"); // num seats
        out.println("<td>" + rs.getString(11) + "</td>"); // departing airport
        out.println("<td>" + rs.getString(12) + "</td>"); // arrival airport
        out.println("<td>" + rs.getString(14) + "</td>"); // price
        out.println("<td><button onclick=\"redirectToDetails('" + rs.getString(2) + "','" + rs.getString(1) + "','" + tripType  + "','" + origAirline + "','" + origFlightNumber + "')\">Buy</button></td>");
        out.println("</tr>");
    	//out.println(rs.getString(1));
    	//out.println(rs.getString(2));
    	//out.println(rs.getString(4));
    	//out.println(rs.getString(5));
    	//out.println(rs.getString(6));
    	//out.println(rs.getString(7));
    	//out.println(rs.getString(13));
    	//out.println(rs.getString(14));
    	//out.println("<br>");
       // out.println("Flight Number: " + rs.getString("flightNumber") + "<br>");
        // Add more processing as needed
    	 } while (rs.next());
    }else{
    	out.println("<b> We couldn't find a return flight for the dates provided, please change your return date and try again </b>");
    }
    out.println("</table>");

} catch (Exception e) {
    e.printStackTrace(); // Handle exceptions appropriately
} finally {
    // Close resources in a finally block
    try {
        if (rs != null) {
            rs.close();
        }
        if (st != null) {
            st.close();
        }
        if (con != null && !con.isClosed()) {
            con.close();
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle exceptions appropriately
    }
    
    
}

%>

<script>
    function handleButtonClick(flightNumber) {
        // Handle button click, you can redirect to a new page or perform other actions
        alert('Button clicked for Flight Number: ' + flightNumber);
    }
    function redirectToDetails(flightId, flightNumber, tripType, origFlightId, origFlightNumber) {
        // Redirect to another JSP page with flightId and tripType as parameters
        window.location.href = 'customerBooking.jsp?flightId=' + flightId + '&flightNumber=' + flightNumber + '&tripType=' + tripType + '&origFlightId=' + origFlightId + '&origFlightNumber=' + origFlightNumber;
    }
</script>