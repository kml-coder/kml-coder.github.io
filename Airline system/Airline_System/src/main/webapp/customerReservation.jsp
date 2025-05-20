<%@ page import ="java.sql.*" %>
<%@ page import="java.time.LocalDateTime"%>
<%
String jdbcUrl = "jdbc:mysql://localhost:3306/your_database";
String username = "your_username";
String password = "your_password";
String acc_id = (String) session.getAttribute("acc_id");
String depPrice = (String) session.getAttribute("depPrice");
String retPrice = (String) session.getAttribute("retPrice");
String tripType = request.getParameter("tripType");
String depSeat = (String) session.getAttribute("depSeat");
String retSeat = (String) session.getAttribute("retSeat");
boolean duplicate = false;

System.out.println(tripType);

// SQL query to insert a new entry into ticket_economy_business_first_changes_buys
String insertQuery = "INSERT INTO ticket_economy_business_first_changes_buys (ticket_number, acc_id, " +
        "total_fare, id_number, passenger_first, passenger_last, purchase_date_time, " +
        "booking_fee, change_ticket_fee, seat_number, class, flight_num) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
		
		
			        
			   
		
     PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
	  System.out.println("hi");
	  //check
	  String flight_number = request.getParameter("origFlightNumber");
	  String flightId = request.getParameter("origFlightId");
	  String ticketNumber = acc_id + flight_number + flightId;
	  String ticketClass = request.getParameter("ticketClass");
	  
	  String passenger_first = (String) session.getAttribute("firstName");
	    String passenger_last = (String) session.getAttribute("lastName");
	    String changeTicketFee = "0";
	    
	  //check if dup tickets
        String sql = "SELECT * FROM ticket_economy_business_first_changes_buys WHERE ticket_number = ?";
        PreparedStatement dp = connection.prepareStatement(sql);
        dp.setString(1, ticketNumber);

        // Execute the query
        ResultSet rsdp = dp.executeQuery();

        // Check if there is at least one row
        duplicate = rsdp.next();
        
        if(duplicate){
        	System.out.println("found dup");
        	out.println("You cannot proceed with your purchase as it seems you have already bought one of the tickets in your butt<a href='customerwelcome.jsp'>go back</a>");
        	return;
        }

	    
	    
	    if(ticketClass.equals("economy")){
	    	changeTicketFee = "50";
	    }
	   // String price = request.getParameter("price");
	    String total_fare = String.valueOf(Float.parseFloat(depPrice) + Float.parseFloat(changeTicketFee));
	  
	  //  flightId, flightNumber, tripType, origFlightId, origFlightNumber, ticketClass
    // Set values for the prepared statement
    preparedStatement.setString(1, ticketNumber);  // ticket_number 0
    preparedStatement.setString(2, acc_id);  // acc_id 0
    preparedStatement.setString(3, total_fare);  // total_Fare //-1
    preparedStatement.setString(4, flightId);  // id_number 0
    preparedStatement.setString(5, passenger_first);  // total_fare 0
    preparedStatement.setString(6, passenger_last);  // passenger_first 0
    preparedStatement.setString(7, LocalDateTime.now().toString());  // purchase_date_time 0
    preparedStatement.setString(8, "75");  // booking_fee 0
    preparedStatement.setString(9,  changeTicketFee);  // change_ticket_fee (initially 0, you can change it as needed) 0
    preparedStatement.setString(10, depSeat);  // seat_number //-2
    preparedStatement.setString(11, ticketClass);  // class 0
    preparedStatement.setString(12, flight_number);


    // Execute the SQL query
    int rowsAffected = preparedStatement.executeUpdate();

    // Check if the insertion was successful
    if (rowsAffected > 0) {
    	 out.println("Reservation successful! Ticket number: " + ticketNumber + " <a href='customerwelcome.jsp'>go back</a>");
        System.out.println("Entry added successfully!");
        
        // if they were on the waiting list, remove them from waiting list
        sql = "delete from waiting_list where acc_id = ? and flight_num = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, acc_id);
        ps.setString(2, flight_number);
        int affectedRows = ps.executeUpdate();
        if (affectedRows >= 1) {
        	System.out.println("bro is removed from waiting list");
        } else {
        	System.out.println("nobody removed from da waiting list");
        }
        
        
        
    } else {
		   System.out.println("Failed to add entry.");
    }
    
    // Close resources
    rsdp.close();
    dp.close();
    connection.close();
}


if(tripType.equals("roundTrip")){
	String retFlightQuery = "INSERT INTO ticket_economy_business_first_changes_buys (ticket_number, acc_id, " +
	        "total_fare, id_number, passenger_first, passenger_last, purchase_date_time, " +
	        "booking_fee, change_ticket_fee, seat_number, class, flight_num) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


	try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbFinal", "root", "RUscr3w420!");
			
			
			
	     PreparedStatement retStatement = connection.prepareStatement(retFlightQuery)) {
		  System.out.println("hi");
		  //check
		  String flight_number = request.getParameter("flightNumber");
		  String flightId = request.getParameter("flightId");
		  String ticketNumber = acc_id + flight_number + flightId;
		  String ticketClass = request.getParameter("ticketClass");
		  
		  String passenger_first = (String) session.getAttribute("firstName");
		    String passenger_last = (String) session.getAttribute("lastName");
		    String changeTicketFee = "0";
		    
		  //check if dup tickets
	        String sql = "SELECT * FROM ticket_economy_business_first_changes_buys WHERE ticket_number = ?";
	        PreparedStatement dp = connection.prepareStatement(sql);
	        dp.setString(1, ticketNumber);

	        // Execute the query
	        ResultSet rsdp = dp.executeQuery();

	        // Check if there is at least one row
	        duplicate = rsdp.next();
	        
	        if(duplicate){
	        	System.out.println("found dup");
	        	out.println("You cannot proceed with your purchase as it seems you have already bought one of the tickets in your butt<a href='customerwelcome.jsp'>go back</a>");
	        	return;
	        }

	        // Close resources
	        rsdp.close();
	        dp.close();
	        connection.close();
		    
		    if(ticketClass.equals("economy")){
		    	changeTicketFee = "50";
		    }
		   // String price = request.getParameter("price");
		    String total_fare = String.valueOf(Float.parseFloat(retPrice) + Float.parseFloat(changeTicketFee));
		  
		  //  flightId, flightNumber, tripType, origFlightId, origFlightNumber, ticketClass
	    // Set values for the prepared statement
	    
	    retStatement.setString(1, ticketNumber);  // ticket_number 0
	    retStatement.setString(2, acc_id);  // acc_id 0
	    retStatement.setString(3, total_fare);  // total_Fare //-1
	    retStatement.setString(4, flightId);  // id_number 0
	    retStatement.setString(5, passenger_first);  // total_fare 0
	    retStatement.setString(6, passenger_last);  // passenger_first 0
	    retStatement.setString(7, LocalDateTime.now().toString());  // purchase_date_time 0
	    retStatement.setString(8, "75");  // booking_fee 0
	    retStatement.setString(9,  changeTicketFee);  // change_ticket_fee (initially 0, you can change it as needed) 0
	    retStatement.setString(10, retSeat);  // seat_number //-2
	    retStatement.setString(11, ticketClass);  // class 0
	    retStatement.setString(12, flight_number);

	    // Execute the SQL query
	    int rowsAffected = retStatement.executeUpdate();

	    // Check if the insertion was successful
	    if (rowsAffected > 0) {
	        System.out.println("Entry added successfully!");
	        out.println("Reservation successful! Ticket number: " + ticketNumber + " <a href='customerwelcome.jsp'>go back</a>");
	    } else {
			   System.out.println("Failed to add entry.");
	    }
	
	} catch (SQLException e) {
	    e.printStackTrace();
	}

}


          %>