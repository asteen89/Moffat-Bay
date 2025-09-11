<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us • Moffat Bay Lodge</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="aboutus.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="index.jsp">
            <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo me-2">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto main-nav">
                <li class="nav-item"><a class="nav-link nav-btn" href="/home">Home</a></li>
                <li class="nav-item"><a class="nav-link nav-btn" href="attractions.jsp">Attractions</a></li>
                <li class="nav-item"><a class="nav-link nav-btn" href="/reservation">Reservations</a></li>
                <li class="nav-item"><a class="nav-link nav-btn" href="my-reservations.jsp">My Reservation</a></li>
                <li class="nav-item"><a class="nav-link nav-btn active" href="/about">About Us</a></li>
            </ul>
            <a href="login.jsp" class="btn-login ms-lg-3">Login/Register</a>
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
        <a href="reservations.jsp" class="btn btn-warning fw-bold px-4 py-2">BOOK NOW!</a>

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
        <a href="attractions.jsp" class="footer-link">Attractions</a> |
        <a href="reservations.jsp" class="footer-link">Reservations</a> |
        <a href="about.jsp" class="footer-link">About Us</a> |
        <a href="login.jsp" class="footer-link">Log In</a> |
        <a href="myreservation.jsp" class="footer-link">My Reservations</a>
        <p class="mt-2 mb-0 small text-black">&copy; 2025 Moffat Bay Lodge</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
