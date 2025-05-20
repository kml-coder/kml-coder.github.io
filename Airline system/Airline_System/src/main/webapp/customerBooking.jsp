<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>

<%
String jdbcUrl = "jdbc:mysql://localhost:3306/dbFinal";
String username = "root";
String password = "RUscr3w420!";

Connection con = null;
Statement st = null;
ResultSet rs = null;

String depAirport;
String destAirport;
String departDate;
String returnDate;
boolean depFlightFull = false;
boolean retFlightFull = false;
String tripType = request.getParameter("tripType");
String depFlightNumber = request.getParameter("origFlightNumber");
String depFlightId = request.getParameter("origFlightId");
String retFlightNumber = request.getParameter("flightNumber");
String retFlightId = request.getParameter("flightId");
//String flex = request.getParameter("flex");
String maxVal = null;
String minVal = null;
String airline = null;
String depSeat = null;
String retSeat = null;


if (tripType.equals("oneWay")) {
	depFlightNumber = retFlightNumber;
	depFlightId = retFlightId;
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(jdbcUrl, username, password);
    st = con.createStatement();
    
     
   String flightNumber = request.getParameter("flightNum");
    airline = request.getParameter("flightId");
     tripType = request.getParameter("tripType");
    
       // String sql = "SELECT * FROM flight_search_operated_by WHERE flight_num = ? AND two_letter_id = ?";
        															  
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE flight_num ='");
        queryBuilder.append(depFlightNumber).append("' AND two_letter_id='").append(depFlightId).append("'");
        rs = st.executeQuery(queryBuilder.toString());
        
        out.println("<h2>Booking Summary</h2>");
        out.println("<br>");
        out.println("Departing Flights");
        out.println("<table border='1'>");
        out.println("<tr><th>Flight Number</th><th>Airline</th><th>Arrival Time</th><th>Departure Time</th><th>Flight Date</th><th>Number Of Seats</th><th>Departing Airport</th><th>Arrival Airport</th><th>Price</th></tr>");

        // Process the ResultSet as needed
   
        while (rs.next()) {
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
            out.println("</tr>");
             session.setAttribute("depFlightFull", depFlightFull);
            session.setAttribute("depPrice", rs.getString(14)); 
        }
       // out.println(depFlightNumber + " " + depFlightId);
        out.println("</table>");
        
        
        //-my version 
    

	ArrayList<String> depTakenSeats = new ArrayList<>();
	 int numSeats = 0;
    try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
         PreparedStatement psAircraft  = connection.prepareStatement("SELECT num_seats FROM aircraft " +
    "WHERE aircraft_id = (SELECT aircraft_id FROM flight_search_operated_by " +
                                                   "WHERE flight_num = ? AND two_letter_id = ?)");
    		PreparedStatement psTicket = connection.prepareStatement(
   	             "SELECT seat_number FROM ticket_economy_business_first_changes_buys " +
   	             "WHERE id_number = ? AND flight_num = ?")) {

    		
       
        psAircraft.setString(1, depFlightNumber);
        psAircraft.setString(2, depFlightId);
        
        ResultSet aircraftResult = psAircraft.executeQuery();
        
        if (aircraftResult.next()) {
            numSeats = aircraftResult.getInt("num_seats");
        }
        //out.println("Aircraft Capacity: " + numSeats);

        // Get seat_number from ticket_economy_business_first_changes_buys
		
		    // Set parameter values
		    psTicket.setString(1, depFlightId);
		    psTicket.setString(2, depFlightNumber);

		    // Execute the query
		    ResultSet ticketResult = psTicket.executeQuery();
        while (ticketResult.next()) {
        	//out.println("got something");
            String seatNumber = ticketResult.getString("seat_number");
            // Process seatNumber as needed
            depTakenSeats.add(seatNumber);
           // out.println("Seat Number: " + seatNumber);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    for(int i = 1; i <= numSeats; i++){
    	if(!depTakenSeats.contains(String.valueOf(i))){
    		System.out.println("inner loop: " + i);
    		depSeat = String.valueOf(i);
    		
    	}
    }
	
    if(depSeat == null){
 	   depFlightFull = true;
    }
    System.out.println("outer loop" + depFlightFull);
 

        
        
        /*
        
	     // Retrieve available seat numbers
		   PreparedStatement pstmt1 = con.prepareStatement("SELECT aircraft.num_seats FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE flight_num = ?");
		   pstmt1.setString(1, depFlightNumber);
           PreparedStatement pstmt = con.prepareStatement("SELECT seat_number FROM ticket_economy_business_first_changes_buys WHERE flight_num = ?");
           pstmt.setString(1, depFlightNumber);
           rs = pstmt1.executeQuery();
           ResultSet rs1 = pstmt.executeQuery();

           // Create a list of available seats
           int availableSeats = rs.getInt(1);
           ArrayList<String> takenSeats = new ArrayList<>();
           if (rs.next()) {
           	System.out.print("u fukin dumbAss");
           	System.out.println(rs.getString(1));
           } else {
           	System.out.println("u wot m8");
           }
           while (rs.next()) {
           	takenSeats.add(rs1.getString("seat_number"));
           }

           // Display available seats for selection
           for (int i = 1; i <= availableSeats; i++) {
				String seat = String.valueOf(i);
				if (!takenSeats.contains(seat)) { // Check if seat is available
					out.println("<option value='" + seat + "'>" + seat + "</option>");
					}
			}
        //-end
        
        */
        
        
        rs.close();
       // rs1.close();
        st.close();
        con.close();
 

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

out.println("<br>");

if(tripType.equals("roundTrip")){
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    con = DriverManager.getConnection(jdbcUrl, username, password);
	    st = con.createStatement();
	    
	
	    
	       // String sql = "SELECT * FROM flight_search_operated_by WHERE flight_num = ? AND two_letter_id = ?";
	        
	         StringBuilder queryBuilder = new StringBuilder("SELECT * FROM flight_search_operated_by JOIN aircraft ON flight_search_operated_by.aircraft_id = aircraft.aircraft_id WHERE flight_num ='");
	        queryBuilder.append(retFlightNumber).append("' AND two_letter_id='").append(retFlightId).append("'");
	        rs = st.executeQuery(queryBuilder.toString());
	        
	        out.println("Returning Flights");
	        out.println("<table border='1'>");
	        out.println("<tr><th>Flight Number</th><th>Airline</th><th>Arrival Time</th><th>Departure Time</th><th>Flight Date</th><th>Number Of Seats</th><th>Departing Airport</th><th>Arrival Airport</th><th>Price</th></tr>");

	        // Process the ResultSet as needed
	         //out.println(retFlightId);
	         //out.println(retFlightNumber);
	        
	        while (rs.next()) {
	        	
	        	
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
	            out.println("</tr>");
	            session.setAttribute("retFlightFull", retFlightFull);
	            session.setAttribute("retPrice", rs.getString(14)); 
	            
	        }
	        out.println("</table>");
	        rs.close();
	       

	        st.close();
	        con.close();

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
	//get Seat
	ArrayList<String> retTakenSeats = new ArrayList<>();
	 int numSeats = 0;
   try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
        PreparedStatement psAircraft  = connection.prepareStatement("SELECT num_seats FROM aircraft " +
   "WHERE aircraft_id = (SELECT aircraft_id FROM flight_search_operated_by " +
                                                  "WHERE flight_num = ? AND two_letter_id = ?)");
   		PreparedStatement psTicket = connection.prepareStatement(
  	             "SELECT seat_number FROM ticket_economy_business_first_changes_buys " +
  	             "WHERE id_number = ? AND flight_num = ?")) {

   		
      
       psAircraft.setString(1, retFlightNumber);
       psAircraft.setString(2, retFlightId);
       
       ResultSet aircraftResult = psAircraft.executeQuery();
       
       if (aircraftResult.next()) {
           numSeats = aircraftResult.getInt("num_seats");
       }
       //out.println("Aircraft Capacity: " + numSeats);

       // Get seat_number from ticket_economy_business_first_changes_buys
		
		    // Set parameter values
		    psTicket.setString(1, retFlightId);
		    psTicket.setString(2, retFlightNumber);

		    // Execute the query
		    ResultSet ticketResult = psTicket.executeQuery();
       while (ticketResult.next()) {
       	//out.println("got something");
           String seatNumber = ticketResult.getString("seat_number");
           // Process seatNumber as needed
           retTakenSeats.add(seatNumber);
           //out.println("Seat Number: " + seatNumber);
       }

   } catch (SQLException e) {
       e.printStackTrace();
   }
   
   for(int i = 1; i <= numSeats; i++){
   	if(!retTakenSeats.contains(String.valueOf(i))){
   		retSeat = String.valueOf(i);
   		break;
   	}
   }
  
   if(retSeat == null){
	   retFlightFull = true;
   }
}
out.println("<br>");   
if(depFlightFull == false && retFlightFull == false ){
	session.setAttribute("depSeat", depSeat);
	session.setAttribute("retSeat", retSeat);
out.println("Book Tickets:"); 
out.println("<br>");  
out.println("<td><button onclick=\"redirectToDetails('" + retFlightId + "','" + retFlightNumber + "','" + tripType  + "','" + depFlightId + "','" + depFlightNumber + "','" + "economy" + "')\">Book Economy</button></td>");
out.println("<br>"); 
out.println("<td><button onclick=\"redirectToDetails('" + retFlightId + "','" + retFlightNumber + "','" + tripType  + "','" + depFlightId + "','" + depFlightNumber + "','" + "business" + "')\">Book Business</button></td>");
out.println("<br>"); 
out.println("<td><button onclick=\"redirectToDetails('" + retFlightId + "','" + retFlightNumber + "','" + tripType  + "','" + depFlightId + "','" + depFlightNumber + "','" + "firstClass" + "')\">Book First Class</button></td>");
}else if(depFlightFull == true || retFlightFull == true){
	out.println("It appears at least one of your flights is currently full, click below to add that flight to your waiting list"); 
	out.println("<br>");  
	System.out.println("depFlight: " + depFlightFull);
	session.setAttribute("depFlightFull", depFlightFull);
	session.setAttribute("retFlightFull", retFlightFull);
out.println("<td><button onclick=\"redirectToWait('" + retFlightId + "','" + retFlightNumber + "','" + tripType  + "','" + depFlightId + "','" + depFlightNumber + "','" + "waitingList" + "')\">Add To Waiting List</button></td>");
}
%>

<script>
    function handleButtonClick(flightNumber) {
        // Handle button click, you can redirect to a new page or perform other actions
        alert('Button clicked for Flight Number: ' + flightNumber);
    }
    function redirectToDetails(flightId, flightNumber, tripType, origFlightId, origFlightNumber, ticketClass) {
        // Redirect to another JSP page with flightId and tripType as parameters
        
      
        window.location.href = 'customerReservation.jsp?flightId=' + flightId + '&flightNumber=' + flightNumber + '&tripType=' + tripType + '&origFlightId=' + origFlightId + '&origFlightNumber=' + origFlightNumber + '&ticketClass=' + ticketClass;
        
       
    }
    
    
    function redirectToWait(flightId, flightNumber, tripType, origFlightId, origFlightNumber, ticketClass) {
        // Redirect to another JSP page with flightId and tripType as parameters
        window.location.href = 'cus_add_to_waiting_list.jsp?flightId=' + flightId + '&flightNumber=' + flightNumber + '&tripType=' + tripType + '&origFlightId=' + origFlightId + '&origFlightNumber=' + origFlightNumber + '&ticketClass=' + ticketClass;
    }
</script>