<!--
  Katie Hilliard
  09/08/2025
  Module 8.1 Assignment 
  The purpose is to create the frontend Reservation Summary page using Bootstrap.
-->
  
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <li class="nav-item"><a href="${pageContext.request.contextPath}/attractions" class="nav-btn">Attractions</a></li>
        <li class="nav-item"><a href="${pageContext.request.contextPath}/reservation" class="nav-btn">Reservations</a></li>
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

<!-- Summary Card -->
<header class="hero-compact">
  <div class="container">
    <div class="summary-card p-4 p-md-5 mx-auto">
      <h1 class="display-6 text-center mb-4">RESERVATION SUMMARY</h1>

      <!-- Display Summary-->
        <div class="container px-0">
            <div class="row kv-row">
                <div class="col-5 col-md-4 kv-label">Reservation ID</div>
                <div class="col kv-value"><c:out value="${reservation.reservationID}" default="—"/></div>

            </div>

      <div class="container px-0">
        <div class="row kv-row">
          <div class="col-5 col-md-4 kv-label">Room Size</div>
              <div class="col kv-value">
                  <c:out value="${reservation.room.roomSize}" default="—"/>
              </div>
        </div>

          <div class="row kv-row">
              <div class="col-5 col-md-4 kv-label">Guests</div>
              <div class="col kv-value">
                  <c:out value="${reservation.numberOfGuests}" default="—"/>
              </div>
          </div>

<!-- Check-in -->
          <div class="row kv-row">
              <div class="col-5 col-md-4 kv-label">Check-in</div>
              <div class="col kv-value">${checkIn}</div>
          </div>

<!-- Check-out -->
          <div class="row kv-row">
              <div class="col-5 col-md-4 kv-label">Check-in</div>
              <div class="col kv-value">${checkOut}</div>
          </div>

        <div class="row kv-row">
          <div class="col-5 col-md-4 kv-label">Nights</div>
          <div class="col kv-value"><c:out value="${nights}" default="—"/></div>
        </div>

<!-- Price -->
          <fmt:setLocale value="en_US"/>
          <div class="row kv-row totals-row">
              <div class="col-5 col-md-4 kv-label">Total</div>
              <div class="col kv-value">
                  <c:choose>
                      <c:when test="${not empty reservation.totalPrice}">
                          <fmt:formatNumber value="${reservation.totalPrice}" type="currency"/>
                      </c:when>
                      <c:otherwise>—</c:otherwise>
                  </c:choose>
              </div>
          </div>
      </div>

        <!--  Buttons -->
        <!-- Before save show Submit / Cancel -->
        <!-- Show buttons only befopre save when no ReservationID yet -->
        <!-- Will show reservation ID once the ID is created in the database -->
            <div class="d-flex flex-column align-items-center gap-2 mt-4">

                <!-- Flash messages  -->
                <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show w-100 text-center" role="alert">
                        ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show w-100 text-center" role="alert">
                        ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                </c:if>

                <!-- Action buttons  -->
                <c:if test="${showActions}">
                <div class="d-flex justify-content-center align-items-center gap-2 mt-4 flex-wrap">
                    <form method="post" action="/reservation/confirm" class="m-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <button type="submit" class="btn btn-warning fw-bold px-4"
                                onclick="this.disabled=true; this.form.submit();">
                            Submit
                        </button>
                    </form>

                    <form method="post" action="/reservation/cancel" class="m-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <button type="submit" class="btn btn-secondary px-4">Cancel</button>
                    </form>
                </div>
                </c:if>
</header>

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

