<%--
  Created by IntelliJ IDEA.
  User: Alisa
  Date: 8/30/2025
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <title>Register Moffat Bay</title>
    <Style>

        h1 {
            font-weight: bold;
            font-size: 42px;
            margin-top: 20px;
            font-family: "roboto";
        }
        p {
            font-family: "roboto";
            font-weight: 300;
            font-size: 14px;
        }
        .form-control.underlined {
            border: 0;
            border-bottom: 1px solid var(--bs-border-color); /* Bootstrap border color */
            padding-left: 0; padding-right: 0;
            box-shadow: none;
        }
        .form-control.underlined:focus {
            box-shadow: none;
            border-bottom-color: var(--bs-primary); /* Change color to match bootstrap primary color */
        }
        input {
            border: none;
            border-bottom: 5px solid green; /* Unsure actual hex code for color, just picked a green */
        }

    </Style>
    <script>
        // Function to show/hide password
        function myFunction() {
            var x = document.getElementById("myInput");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
    </script>
</head>
<body>
<%
    String messageBox = (String) session.getAttribute("messageBox");
    if (messageBox != null) {
%>
<div class="alert alert-warning"><%= messageBox %></div>
<%
        session.removeAttribute("messageBox"); // Clear message after displaying
    }
%>

<!-- Registration form-->
<div class="container my-4">
    <div class="d-flex justify-content-center">
        <div class="border p-3 rounded w-100" style="max-width:420px;">
            <div class="container text-center">
                <h1>Create an account</h1>
                <p>Create your account, it takes less than a minute. If you already have an account</p>
                <!--Button for login page -->
                <button type="button" class="btn btn-link text-decoration-none"style="color:#05563fa4; font-weight:bold; font-family:Roboto;" onclick="location.href='${pageContext.request.contextPath}/login'">Login</button>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
            <div class="container-sm">
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <input type="text" class="form-control underlined" name="firstName" placeholder="First name" required>
                    </div>
                    <div class="mb-3">
                        <input type="text" class="form-control underlined" name="lastName" placeholder="Last name" required>
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control underlined" name="email" placeholder="Email Address" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    </div>
                    <div class="mb-3">
                        <input type="tel" class="form-control underlined" name="phone" placeholder="Phone Number" required pattern="^[0-9]{3}-[0-9]{3}-[0-9]{4}$">
                    </div>
                    <div class="mb-4">
                        <input type="password" id="myInput" class="form-control underlined" name="password" placeholder="Password" required minlength="8">
                        <input type="checkbox" onclick="myFunction()"> Show Password
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-warning" style="color:white;">Sign Up</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>