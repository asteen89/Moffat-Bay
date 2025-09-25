<%--
  Created by IntelliJ IDEA.
  User: Alisa
  Date: 8/30/2025
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <title>Login Moffat Bay</title>
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
        // Javascript Function to show/hide password
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
<!-- Login form-->
<div class="container my-4">
    <div class="d-flex justify-content-center">
        <div class="border p-3 rounded w-100" style="max-width:420px;">
            <div class="container text-center">
                <h1>Login</h1>
                <p>Login to your account here. If you already don't have an account <button type="button" class="btn btn-link text-decoration-none" style="color:#05563fa4; font-weight:bold; font-family:Roboto;" onclick="location.href='${pageContext.request.contextPath}/registration'"> register here
                </button></p>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
            <c:if test="${not empty errorMessage}"><div class="alert alert-warning">${errorMessage}</div></c:if>
            <div class="container-sm">
                <form method="post" action="${ctx}/auth/login" class="mt-3">
                    <input type="hidden" name="next" value="${param.next != null ? param.next : next}">

                    <div class="mb-3">
                        <input type="email" class="form-control underlined" name="email" placeholder="Email" required pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$">
                    </div>

                    <div class="mb-4">
                        <input type="password" id="myInput" class="form-control underlined" name="password" placeholder="Password" required minlength="8">
                        <input type="checkbox" onclick="myFunction()"> Show Password
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-warning" style="color:white;">Sign in</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>
</div>
<jsp:include page="footer.jsp" />

    </body>
    </html>



