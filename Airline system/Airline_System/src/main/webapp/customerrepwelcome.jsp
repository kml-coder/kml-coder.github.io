<%
	if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="triplelogin.jsp">Please Login</a>
<%} else {
%>
Welcome Customer Rep <%=session.getAttribute("user")%> 
<a href='logout.jsp'>Log out</a>

    <h2>Make Flight Reservation</h2>
    <form action="customerrep_make_reservation.jsp" method="post">
    	Customer ID: <input type="text" name="acc_id" /><br/>
    	Flight number: <input type="text" name="flight_number" /><br/>
    	Two Letter Airline ID: <input type="text" name="two_letter_id" /><br/>
    	<input type="submit" value="Make Flight Reservation" />
    </form>

    <!-- Form to Edit Flight Reservations -->
    <h2>Edit Flight Reservation</h2>
    <form action="customerrepEditReservation.jsp" method="post">
    	Customer acc_id: <input type="text" name="acc_id" /><br/>
    	Ticket Number: <input type="text" name="ticket_number" /><br/>
    	New flight number: <input type="text" name="new_flight_num" /><br/>
    	Upgrade?:     
    	<input type="radio" id="business" name="business" value="business">
    	<label for="business">Business</label><br>
    	<input type="radio" id="firstClass" name="firstClass" value="firstClass">
    	<label for="firstClass">First Class</label><br>
    	New Seat Number: <input type="text" name="new_seat_number" /><br/>
    	
    	<input type="submit" value="Edit Flight Reservation" />      
        
    </form>
    
    <h2>Delete Reservation</h2>
    <form action="customerrepDeleteReservation.jsp" method="post">
    Which ticket number would you like to delete: <input type="text" name="ticket_number" /><br/>
    <input type="submit" value="Delete Reservation" />
</form>

    <h2>Retrieve Passengers on Waiting List</h2>
    <form action="customerrepwaitinglist.jsp" method="post">
    	Flight number: <input type="text" name="flight_number" /><br/>
    	<input type="submit" value="Retrieve Passengers on Waiting List" />        
    </form>

    <h2>Produce List of Flights for Airport</h2>
    <form action="listFlightForAirport.jsp" method="post">
        Airport ID: <input type="text" name="airport_id" /><br/>
    	Date: <input type="date" name="date" /><br/>
    	<input type="submit" value="Produce List of Flights for Airport" />        
    </form>



<form action="customerrepCheckQuestions.jsp" method="post">
    <input type="submit" value="Check customer questions" />
</form>

<form action="customerrepAddAircraft.jsp" method="post">
    Which aircraft would you like to add: <input type="text" name="aircraft_id" /><br/>
    How many seats?: <input type="text" name="new_num_seats" /><br/>
    <input type="submit" value="Add Aircraft" />
</form>

<form action="customerrepDeleteAircraft.jsp" method="post">
    Which aircraft would you like to delete: <input type="text" name="aircraft_id" /><br/>
    <input type="submit" value="Delete Aircraft" />
</form>

<form action="customerrepEditAircraft.jsp" method="post">
    Which aircraft would you like to edit: <input type="text" name="aircraft_id" /><br/>
    New number of seats: <input type="text" name="new_num_seats" /><br/>
    <input type="submit" value="Edit Aircraft" />
</form>

<form action="customerrepAddAirport.jsp" method="post">
    Which airport would you like to add: <input type="text" name="three_letter_id" /><br/>
    <input type="submit" value="Add Airport" />
</form>

<form action="customerrepDeleteAirport.jsp" method="post">
    Which airport would you like to delete: <input type="text" name="three_letter_id" /><br/>
    <input type="submit" value="Delete Airport" />
</form>

<form action="customerrepEditAirport.jsp" method="post">
    Which airport would you like to edit: <input type="text" name="three_letter_id" /><br/>
    New airport three letter id: <input type="text" name="new_three_letter_id" /><br/>
    <input type="submit" value="Edit Airport" />
</form>

<form action="customerrepAddFlight.jsp" method="post">
    <h3>Add a flight!</h3> <br/>
    flight number: <input type="text" name="flight_num" /><br/>
    airline company two letter id: <input type="text" name="two_letter_id" /><br/>
    departure time: <input type="time" name="departure_time" /><br/>
    arrival time: <input type="time" name="arrival_time" /><br/>
    departure date: <input type="date" name="departure_date" /><br/>
    arrival date: <input type="date" name="arrival_date" /><br/>
    departure airport: <input type="text" name="departure_airport" /><br/>
    destination airport: <input type="text" name="destination_airport" /><br/>
    aircraft id: <input type="text" name="aircraft_id" /><br/>
    days of operation: <input type="text" name="days_of_operation" /><br/>
    domestic? <input type="text" name="is_domestic" /><br/>
    price <input type="text" name="price" /><br/>
    number of stops: <input type="text" name="num_of_stops" /><br/>
    <input type="submit" value="Add Flight" />
</form>

<form action="customerrepDeleteFlight.jsp" method="post">
    Which flight would you like to delete: <input type="text" name="flight_num" /><br/>
    Type in the airline id of the deleted flight: <input type="text" name="two_letter_id" /><br/>
    
    <input type="submit" value="Delete Flight" />
</form>

<form action="customerrepEditFlight.jsp" method="post">
    Which flight would you like to edit: <input type="text" name="flight_num" /><br/>
    Type in the airline id of the edited flight: <input type="text" name="two_letter_id" /><br/>
    new flight number: <input type="text" name="new_flight_num" /><br/>
    new airline company two letter id: <input type="text" name="new_two_letter_id" /><br/>
    new departure time: <input type="time" name="new_departure_time" /><br/>
    new arrival time: <input type="time" name="new_arrival_time" /><br/>
    new departure date: <input type="date" name="new_departure_date" /><br/>
    new arrival date: <input type="date" name="new_arrival_date" /><br/>
    new departure airport: <input type="text" name="new_departure_airport" /><br/>
    new destination airport: <input type="text" name="new_destination_airport" /><br/>
    new aircraft id: <input type="text" name="new_aircraft_id" /><br/>
    new days of operation: <input type="text" name="new_days_of_operation" /><br/>
    new domestic status <input type="text" name="new_is_domestic" /><br/>
    new price <input type="text" name="new_price" /><br/>
    new number of stops: <input type="text" name="new_num_of_stops" /><br/>
    <input type="submit" value="Edit Flight" />
</form>

<%
	}
%>