<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge - Reservations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body class="reservation-page">
<!-- Navbar -->
<!-- This will ensure that after logout happens, if user clicks back button it will still show login/register-->
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0);    // Proxies
%>
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
            <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo">
        </a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu Items -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto me-auto main-nav">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-btn">Home</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">Attractions</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/reservation" class="nav-btn active">Reservations</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/reservations/lookup" class="nav-btn">My Reservation</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-btn">About Us</a></li>
            </ul>
            <!-- Show Logout button upon logging in -->
            <!-- If auth exists AND its authenticated flag is true,
            then show the Logout button. Clicking it goes to /auth/logout,
             which invalidates the session. AS-->
            <c:choose>
                <c:when test="${auth != null && auth.authenticated}">
                    <a class="btn-login" href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a class="btn-login" href="${pageContext.request.contextPath}/auth/login">Login / Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- Reservation Form Section -->
<section class="reservation-hero">
    <div class="col-md-6 col-lg-5">
        <div class="card reservation-card shadow-lg p-4">
            <h2 class="text-center fw-bold mb-4">BOOK YOUR VACATION</h2>
            <form method="post" action="/reservation/preview">
                <!-- Room Size -->
                <!-- Room Size -->
                <div class="mb-3">
                    <label class="form-label">Select Room Size</label>
                    <select class="form-select" name="roomId" required>
                        <option value="">Select</option>
                        <c:forEach var="r" items="${roomSizes}">
                            <option value="${r.roomID}">${r.roomSize} — <fmt:formatNumber value="${r.roomPrice}" type="currency"/></option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Number of Guests -->
                <div class="mb-3">
                    <label class="form-label">Number of Guests</label>
                    <input type="number" class="form-control" name="guests" min="1" max="10" required>
                </div>
                <!-- Check-in Date -->
                <div class="mb-3">
                    <label class="form-label">Check-in Date</label>
                    <input type="date" class="form-control" name="checkin" required>
                </div>
                <!-- Check-out Date -->
                <div class="mb-3">
                    <label class="form-label">Check-out Date</label>
                    <input type="date" class="form-control" name="checkout" required>
                </div>
                <!-- Buttons -->
                <!-- Error incase dates are entered incorrectly-->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <div class="form-actions mt-4">
                    <button type="submit" class="btn btn-warning fw-bold">Submit</button>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- Footer just links -->
<footer class="footer py-5">
    <div class="container">
        <div class="row text-center text-md-start align-items-stretch">
            <!-- Bottom Links -->
            <div class="text-center mt-4 small">
                <a href="#">Attractions</a> |
                <a href="${pageContext.request.contextPath}/reservation">Reservations</a> |
                <a href="${pageContext.request.contextPath}/about">About Us</a> |
                <a href="${pageContext.request.contextPath}/login">Log In</a> |
                <a href="${pageContext.request.contextPath}/reservations/lookup">My Reservations</a>
                <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
