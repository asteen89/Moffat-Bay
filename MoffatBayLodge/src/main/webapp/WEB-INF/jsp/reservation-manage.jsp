<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge – Modify Reservation</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css?v=5">
</head>
<body class="reservation-page">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/MoffatBayLogo.png" alt="Logo" class="logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto me-auto main-nav">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-btn">Home</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">Attractions</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/reservation" class="nav-btn">Reservations</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">My Reservation</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-btn">About Us</a></li>
            </ul>
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login / Register</a>
        </div>
    </div>
</nav>

<header class="hero-compact">
    <div class="container">
        <div class="summary-card p-4 p-md-5 mx-auto">
            <h1 class="display-6 text-center mb-4">MODIFY RESERVATION</h1>

            <c:if test="${not empty reservation}">
                <form method="post" action="${pageContext.request.contextPath}/reservations/manage">
                    <input type="hidden" name="reservationId" value="${reservation.reservationID}">

                    <div class="mb-3">
                        <label class="form-label">Room Size</label>
                        <input type="text" class="form-control" value="${reservation.room.roomSize}" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Number of Guests</label>
                        <input type="number" class="form-control" name="numberOfGuests" value="${reservation.numberOfGuests}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Check-in Date</label>
                        <input type="date" class="form-control" name="checkinDate" value="${checkinFormatted}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Check-out Date</label>
                        <input type="date" class="form-control" name="checkoutDate" value="${checkoutFormatted}" required>
                    </div>

                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <button type="submit" class="btn btn-warning fw-bold px-4">Update</button>
                        <a href="${pageContext.request.contextPath}/reservations/lookup" class="btn btn-secondary px-4">Cancel</a>
                    </div>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success mt-3">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">${error}</div>
                    </c:if>
                </form>
            </c:if>

            <c:if test="${empty reservation}">
                <div class="alert alert-warning mt-3">Reservation not found.</div>
            </c:if>

        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
