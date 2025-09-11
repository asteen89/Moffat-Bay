<!--
  Katie Hilliard
  09/08/2025
  Module 8.1 Assignment 
  The purpose is to create the frontend Reservation Summary page using Bootstrap.
-->
  
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Moffat Bay Lodge – Reservation Summary</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css?v=5">

  <style>
    .hero-compact {
      background-image: url('${pageContext.request.contextPath}/images/banner-landing.png');
      background-size: cover;
      background-position: center;
      padding: 40px 0 60px;
    }
    .summary-card {
      max-width: 860px;
      background: #fff;
      border-radius: 1rem;
      box-shadow: 0 10px 24px rgba(0,0,0,.15);
    }
    .summary-card h1 {
      font-weight: 800;
      letter-spacing: .5px;
    }
    .kv-row { padding: .65rem 0; border-bottom: 1px solid #f0f0f0; }
    .kv-label { font-weight: 700; color: #374151; }
    .kv-value { color: #111827; }
    .totals-row { font-weight: 800; font-size: 1.05rem; }
    .footer-simple { border-top: 1px solid #e6e6e6; }
    .footer-simple .footer-link { color:#2c2c2c; text-decoration:none; padding:0 .25rem; }
    .footer-simple .footer-link:hover { text-decoration:underline; }
  </style>
</head>
<body>

<!-- ===== NavBar ===== -->
<!-- This will ensure that after logout happens, if user clicks back button it will still show login/register-->
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0);    // Proxies
%>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
      <img src="${pageContext.request.contextPath}/images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo">
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto me-auto main-nav">
        <li class="nav-item"><a href="${pageContext.request.contextPath}/" class="nav-btn">Home</a></li>
        <li class="nav-item"><a href="#" class="nav-btn">Attractions</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/reservation" class="nav-btn">Reservations</a></li>
        <li class="nav-item"><a href="#" class="nav-btn">My Reservation</a></li>
        <li class="nav-item"><a href="#" class="nav-btn">About Us</a></li>
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

<!-- Summary Card -->
<header class="hero-compact">
  <div class="container">
    <div class="summary-card p-4 p-md-5 mx-auto">
      <h1 class="display-6 text-center mb-4">RESERVATION SUMMARY</h1>

      <!-- Display Summary-->
        <div class="container px-0">
            <div class="row kv-row">
                <div class="col-5 col-md-4 kv-label">Reservation ID</div>
                <div class="col kv-value"><c:out value="${reservationId}" default="—"/></div>
            </div>

      <div class="container px-0">
        <div class="row kv-row">
          <div class="col-5 col-md-4 kv-label">Room Size</div>
          <div class="col kv-value"><c:out value="${roomSize}" default="—"/></div>
        </div>

        <div class="row kv-row">
          <div class="col-5 col-md-4 kv-label">Guests</div>
          <div class="col kv-value"><c:out value="${guests}" default="—"/></div>
        </div>

<!-- Check-in -->
<div class="row kv-row">
  <div class="col-5 col-md-4 kv-label">Check-in</div>
  <div class="col kv-value"><c:out value="${checkIn}" default="—"/></div>
</div>

<!-- Check-out -->
<div class="row kv-row">
  <div class="col-5 col-md-4 kv-label">Check-out</div>
  <div class="col kv-value"><c:out value="${checkOut}" default="—"/></div>
</div>

        <div class="row kv-row">
          <div class="col-5 col-md-4 kv-label">Nights</div>
          <div class="col kv-value"><c:out value="${nights}" default="—"/></div>
        </div>

        <div class="row kv-row totals-row">
          <div class="col-5 col-md-4 kv-label">Total</div>
          <div class="col kv-value">
            <c:choose>
              <c:when test="${not empty total}">
                <fmt:formatNumber value="${total}" type="currency"/>
              </c:when>
              <c:otherwise>—</c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

<!--  Buttons -->
<div class="d-flex justify-content-center gap-2 mt-4">
  <form action="${pageContext.request.contextPath}/reservations/confirm" method="post" class="d-inline">
    <c:if test="${not empty reservationId}">
      <input type="hidden" name="reservationId" value="${reservationId}">
    </c:if>
    <button type="submit" class="btn btn-warning fw-bold px-4">Submit</button>
  </form>
  <a href="${pageContext.request.contextPath}/reservation" class="btn btn-secondary px-4">Cancel</a>
</div>
</div>
</header>

<!-- Footer -->
    <div class="footer-links text-center mt-4 small">
      <a href="#">Attractions</a> |
      <a href="${pageContext.request.contextPath}/reservation">Reservations</a> |
      <a href="#">About Us</a> |
      <a href="${pageContext.request.contextPath}/login">Login</a> |
      <a href="#">My Reservation</a>
      <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

