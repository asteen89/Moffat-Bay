<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge - Attractions</title>

    <!-- Bootstrap + (optional) Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- site styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css?v=6">
</head>
<body>

<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
            <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto me-auto main-nav">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-btn">Home</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/attractions" class="nav-btn">Attractions</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/reservation" class="nav-btn">Reservations</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/reservations/lookup" class="nav-btn">My Reservation</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-btn">About Us</a></li>
            </ul>
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

<!-- Page title -->
<header class="py-5 text-center bg-light">
    <div class="container">
        <h1 class="display-5 fw-bold">Discover Moffat Bay Lodge</h1>
    </div>
</header>

<!-- Highlights Section -->
<div class="container my-5">
    <h2 class="mb-4 text-center">Highlights</h2>
    <div class="row g-4 justify-content-center">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/kayaking.jpg" alt="Kayaking">
                <div class="card-body text-center"><span class="fw-semibold">Kayaking</span></div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/whale.jpg" alt="Whale Watching">
                <div class="card-body text-center"><span class="fw-semibold">Whale Watching</span></div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/hiking.jpg" alt="Hiking">
                <div class="card-body text-center"><span class="fw-semibold">Hiking</span></div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/scuba-diving.jpg" alt="Scuba Diving">
                <div class="card-body text-center"><span class="fw-semibold">Scuba Diving</span></div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/Maps_Resort.webp" alt="Island Map">
                <div class="card-body text-center"><span class="fw-semibold">Island Map</span></div>
            </div>
        </div>
    </div>
</div>


<!-- Featured Section -->
<div class="container my-5">
    <h2 class="mb-4 text-center">Featured</h2>
    <div class="row g-4">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/room.jpeg" alt="Lodge Rooms">
                <div class="card-body text-center">
                    <h5 class="card-title">Lodge Rooms</h5>
                    <p class="card-text">Experience comfort with stunning views of the bay.</p>
                    <a class="btn btn-warning fw-bold" href="${pageContext.request.contextPath}/reservation">Book Now</a>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/marina.webp" alt="Marina">
                <div class="card-body text-center">
                    <h5 class="card-title">Marina</h5>
                    <p class="card-text">Dock your boat at our world-class marina facilities.</p>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/spa.png" alt="Spa">
                <div class="card-body text-center">
                    <h5 class="card-title">Spa</h5>
                    <p class="card-text">Relax and rejuvenate with luxury spa treatments.</p>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="card h-100 shadow-sm">
                <img class="card-img-top uniform-img" src="${pageContext.request.contextPath}/images/attractions/tour.jpg" alt="Guided Tours">
                <div class="card-body text-center">
                    <h5 class="card-title">Guided Tours</h5>
                    <p class="card-text">Discover the place with our expert guides.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="footer-links text-center mt-4 small">
    <a href="${pageContext.request.contextPath}/attractions">Attractions</a> |
    <a href="${pageContext.request.contextPath}/reservation">Reservations</a> |
    <a href="${pageContext.request.contextPath}/about">About Us</a> |
    <a href="${pageContext.request.contextPath}/login">Login</a> |
    <a href="${pageContext.request.contextPath}/reservations/lookup">My Reservation</a>
    <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
