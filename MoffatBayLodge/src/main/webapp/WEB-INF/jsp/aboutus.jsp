<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us • Moffat Bay Lodge</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css?v=5<%=System.currentTimeMillis()%>">
</head>
<body>

<!-- Navbar -->
<!-- This will ensure that after logout happens, if user clicks back button it will still show login/register-->
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); // HTTP1.1
    response.setHeader("Pragma","no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0);    // Proxies
%>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
            <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo">
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

<!-- About Section -->
<section class="about-section text-center py-5">
    <div class="container">
        <h1 class="fw-bold mb-3">About Us</h1>
        <h4 class="fw-light mb-4">Your home away from home!</h4>
        <p class="lead mb-5">
            Moffat Bay Lodge was established in 2016. We aim to provide an unforgettable, relaxing, adventurous
            experience every time our guests come to stay! From accommodation to exploring over 20+ amenities,
            our staff is ready to provide the best recommendations and assistance for our guests. Romantic getaways,
            family retreats, weddings, birthday vacations, and even solo getaways are popular at Moffat Bay Lodge.
            Contact us to learn more about our special rates and discounts we offer throughout the year. We would
            love to help plan your next getaway to Moffat Bay Lodge!
        </p>
        <a href="${pageContext.request.contextPath}/reservation" class="btn btn-warning fw-bold px-4 py-2">BOOK NOW!</a>

        <!-- Contact strip -->
        <section class="about-contact mt-4">
            <div class="container">
                <div class="row g-4 justify-content-center text-center">
                    <div class="col-12 col-md-4">
                        <div class="contact-card">
                            <div class="contact-ico">✉️</div>
                            <div class="contact-label">Email</div>
                            <a href="mailto:info@moffatbaylodge.com" class="contact-value">info@moffatbaylodge.com</a>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="contact-card">
                            <div class="contact-ico">📞</div>
                            <div class="contact-label">Phone</div>
                            <a href="tel:+16625826614" class="contact-value">(626) 582-6614</a>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="contact-card">
                            <div class="contact-ico">📍</div>
                            <div class="contact-label">Address</div>
                            <div class="contact-value">3358 Moffat Way, Gulf Shores, AL 36542</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>

<!-- Inline footer (no separate JSP include) -->
<footer class="shared-footer text-center py-3 mt-5">
    <div class="container">
        <a href="#" class="footer-link">Attractions</a> |
        <a href="${pageContext.request.contextPath}/reservation" class="footer-link">Reservations</a> |
        <a href="${pageContext.request.contextPath}/about" class="footer-link">About Us</a> |
        <a href="${pageContext.request.contextPath}/login" class="footer-link">Log In</a> |
        <a href="#" class="footer-link">My Reservations</a>
        <p class="mt-2 mb-0 small text-black">&copy; 2025 Moffat Bay Lodge</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>