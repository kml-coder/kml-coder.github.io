<!DOCTYPE html>
<html>
	<head>
		<title>Login Form</title>
		 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Style the tabs container */
        .tabs-container {
            display: flex;
            margin: 20px;
        }

        /* Style each tab */
        .tab {
            cursor: pointer;
            padding: 10px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        /* Style the content container */
        .content-container {
            margin: 20px;
        }

        /* Hide content by default */
        .tab-content {
            display: none;
        }

        /* Style text fields and button inside each tab */
        .tab-content input,
        .tab-content button {
            display: block;
            margin-bottom: 10px;
        }

        /* Show content on hover */
        .tab:hover .tab-content {
            display: block;
        }
    </style>
	</head>
	<body>
		<div class="tabs-container">
        <!-- Tab 1 -->
        <div class="tab">
            Admin Login
            <div class="tab-content">
            <form action="checkLoginDetailsAdmin.jsp" method="POST">
              Username: <input type="text" name="username" placeholder="enter admin username">
              Password: <input type="text" name="password" placeholder="admin password">
              <input type="submit" value="Submit"/>
			</form>
            </div>
        </div>

        <!-- Tab 2 -->
        <div class="tab">
            Customer Login
            <div class="tab-content">
            <form action="checkLoginDetailsCustomer.jsp" method="POST">
               Username: <input type="text" name="username" placeholder="enter customer username">
               Password: <input type="text"  name="password" placeholder="customer password">
               <input type="submit" value="Submit"/>
                </form>
            </div>
        </div>

        <!-- Tab 3 -->
        <div class="tab">
            Rep Login
            <div class="tab-content">
            <form action="checkLoginDetailsCustomerRep.jsp" method="POST">
               Username: <input type="text" name="username" placeholder="enter customer rep username">
               Password: <input type="text" name="password" placeholder="rep password">
               <input type="submit" value="Submit"/>
         		</form>
            </div>
        </div>
    </div>

	</body>
</html>