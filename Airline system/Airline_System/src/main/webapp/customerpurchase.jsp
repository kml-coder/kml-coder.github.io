<!DOCTYPE html>
<html>
	<head>
		<title>Login Form</title>
		 <meta charset="UTF-8">
		 <meta name="viewport" content="width=device-width, initial-scale=1.0">
		 <title>Dropdown Menu Example</title>
		 
		 <script>
        function showTextField() {
            // Get the selected value from the drop-down menu
            var selectedValue = document.getElementById("tripType").value;

            // Get the text field container
            var textFieldContainer = document.getElementById("textFieldContainer");

            // Show or hide the text field based on the selected value
            if (selectedValue === "roundTrip") {
                textFieldContainer.style.display = "block";
            } else {
                textFieldContainer.style.display = "none";
            }
        }
        
        function showTextField2() {
            // Get the selected value from the drop-down menu
            var selectedValue2 = document.getElementById("filterType").value;

            // Get the text field container
            var textFieldContainer2 = document.getElementById("textFieldContainer2");
            //var textFieldContainer3 = document.getElementById("maxVal");

            // Show or hide the text field based on the selected value
            if (selectedValue2 === "airline" || selectedValue2 === "numberOfStops") {
            	textFieldContainer2.style.display = "none";
            	textFieldContainer3.style.display = "block";
            } else if (selectedValue2 === "none"){
            	textFieldContainer2.style.display = "none";
            	textFieldContainer3.style.display = "none";
        	}else {
                textFieldContainer2.style.display = "block";
                textFieldContainer3.style.display = "none";
            }
        }
    </script>
    
   
       
    
</head>
<body>
    <h2>Search For Tickets:</h2>

    <form action="customerFilter.jsp" method="post">
    
    	 <label for="enterAirport">Departure/Arrival Airport:</label>
    	  <br>
    	<input type="text" name="depAirport" placeholder="Departure Airport"> 
    	<input type="text" name="arivAirport" placeholder="Arrival Airport"> 
    	 <br>
    	 
        <label for="color">Select Ticket Type:</label>
        <select name="tripType" id="tripType" onchange="showTextField()">
        	<option value="oneWay">One Way</option> 
            <option value="roundTrip">Round Trip</option>
  
        </select>
        
         <br>

        <label for="flexible">Enable Flexible Ticket:</label>
        <input type="checkbox" name="flexible" id="flexible">

        <br>
        <label for="departDate">Select Departure Date:</label>
        <input type="date" name="departdate" placeholder="Departing Date"> 
        <div id="textFieldContainer" style="display: none;">
            <label for="returnDate">Select Return Date:</label>
            <input type="date" name="returnDate" placeholder="Return Date">
          </div>
    
          
          <h4>Filter/Sort Tickets:</h4>
          
         
         <label for="Filter Results By:">Select Filter Type:</label>
        <select name="filterType" id="filterType" onchange="showTextField2()">
        	<option value="none">no filter</option> 
        	<option value="price">price</option> 
            <option value="airline">airline</option>
            <option value="takeOffTime">takeOffTime</option>
            <option value="landingTime">landingTime</option>
            <option value="numberOfStops">numberOfStops</option> 
            </select>
        
        <br>
        <br>
         <div id="textFieldContainer2" style="display: none;">
         <label for="filterInstructions">*Enter time using format mm:hh </label>
          <br>
          <br>
         <label for="maxValLablel">Max Val:</label>
        <input type="text" name="maxVal" placeholder="Max Value">
        <br>
        <label for="minValLablel">Min Val:</label>
         <input type="text" name="minVal" placeholder="Min Value">
         </div>
         
         <div id="textFieldContainer3" style="display: none;">
         <label for="thirdTextLabel">Enter Value:</label>
        <input type="text" name="textBox3" placeholder="value">
        <br>
         </div>
        <br>
    

    	 
        <label for="Sort">Select Sort Type:</label>
        <select name="sortType" id="sortType" onchange="showTextField()">
        	<option value="none2">no sort</option>
        	<option value="price">price</option> 
            <option value="takeOffTime">takeOffTime</option>
            <option value="landingTime">landingTime</option>
            <option value="durationOfFlight">durationOfFlight</option>
  
        </select>
        
<br>
<br>
 <label for="nameLabel">Enter Personal Info:</label>
 <br>
        <input type="text" name="firstName" placeholder="Enter First Name">
        <br>
         <input type="text" name="lastName" placeholder="Enter Last Name">
         <br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>

