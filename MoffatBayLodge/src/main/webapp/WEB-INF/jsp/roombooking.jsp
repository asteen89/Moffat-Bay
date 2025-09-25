<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge – Rooms</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- site styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/booking.css?v=5">

</head>
<body>

<!-- Navbar (use your existing navbar include if you have one) -->
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
                <li class="nav-item"><a href="${pageContext.request.contextPath}/about" class="nav-btn">About Us</a></li>
            </ul>
            <!-- Show Logout button upon logging in -->
            <!-- If auth exists AND its authenticated flag is true,
            then show the Logout button. Clicking it goes to /auth/logout,
             which invalidates th   e session. AS-->
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

<!-- Lead line like the mock -->
<p class="hero-note">Relax, explore and create lasting memories</p>

<div class="container">
    <div class="row g-4">
        <!-- Rooms list (left) -->
        <div class="col-lg-8">
            <!-- Loop rooms from the model -->
            <c:forEach var="room" items="${rooms}">
                <div class="room-card">
                    <div class="row g-0">
                        <div class="col-md-5">
                            <img src="${pageContext.request.contextPath}${room.imageUrl}" alt="${room.name}">
                        </div>
                        <div class="col-md-7">
                            <div class="room-body">
                                <div class="room-title">
                                        ${room.name}
                                    <span class="price"> – $${room.price}</span>
                                </div>
                                <div class="room-desc">
                                        ${room.shortDescription}
                                </div>

                                <!-- tiny amenity line under each room (optional) -->
                                <c:if test="${not empty room.inlineAmenities}">
                                    <div class="text-muted small mt-2">
                                            ${room.inlineAmenities}
                                    </div>
                                </c:if>

                                <!-- Book Now -->
                                <div class="mt-2">
                                    <c:url var="bookUrl" value="/reservation">
                                        <c:param name="roomId"  value="${room.id}"/>
                                        <c:param name="checkIn" value="${checkIn}"/>
                                        <c:param name="checkOut" value="${checkOut}"/>
                                        <c:param name="guests"  value="${guests}"/>
                                    </c:url>
                                    <a href="${bookUrl}" class="btn btn-warning book-btn">Book Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Sample blocks if no model data yet (remove when wired) -->
            <c:if test="${empty rooms}">
                <div class="room-card">
                    <div class="row g-0">
                        <div class="col-md-5">
                            <img src="${pageContext.request.contextPath}/images/rooms/king.jpg" alt="1 King Bed">
                        </div>
                        <div class="col-md-7">
                            <div class="room-body">
                                <div class="room-title">1 King Bed, Non-Smoking <span class="price">– $168</span></div>
                                <div class="room-desc">
                                    Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed),
                                    Hair Dryer, HDTV In-Room, Temperature Control, Iron, Microwave.
                                </div>
                                <a href="${pageContext.request.contextPath}/reservation/start?roomId=1" class="btn btn-warning book-btn mt-2">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="room-card">
                    <div class="row g-0">
                        <div class="col-md-5">
                            <img src="${pageContext.request.contextPath}/images/rooms/double-queen.jpg" alt="Double Queen Beds">
                        </div>
                        <div class="col-md-7">
                            <div class="room-body">
                                <div class="room-title">Double Queen Beds, Non-Smoking <span class="price">– $157.50</span></div>
                                <div class="room-desc">
                                    Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed),
                                    Hair Dryer, HDTV In-Room.
                                </div>
                                <a href="${pageContext.request.contextPath}/reservation/start?roomId=2" class="btn btn-warning book-btn mt-2">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
        </div>

        <div class="room-card">
            <div class="row g-0">
                <div class="col-md-5">
                    <img src="${pageContext.request.contextPath}/images/rooms/Queen.jpg" alt="Queen Bed">
                </div>
                <div class="col-md-7">
                    <div class="room-body">
                        <div class="room-title">Queen Bed, Non-Smoking <span class="price">– $141.75</span></div>
                        <div class="room-desc">
                            Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed),
                            Hair Dryer, HDTV In-Room.
                        </div>
                        <a href="${pageContext.request.contextPath}/reservation/start?roomId=3" class="btn btn-warning book-btn mt-2">Book Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="room-card">
        <div class="row g-0">
            <div class="col-md-5">
                <img src="${pageContext.request.contextPath}/images/rooms/double-full-beds.jpg" alt="Double Full Beds">
            </div>
            <div class="col-md-7">
                <div class="room-body">
                    <div class="room-title">Double Queen Beds, Non-Smoking <span class="price">– $126</span></div>
                    <div class="room-desc">
                        Alarm Clock, Bathroom Amenities, Coffee/Tea Maker, Desk, Free Wi-Fi (high-speed),
                        Hair Dryer, HDTV In-Room.
                    </div>
                    <a href="${pageContext.request.contextPath}/reservation/start?roomId=4" class="btn btn-warning book-btn mt-2">Book Now</a>
                </div>
            </div>
        </div>
    </div>
    </c:if>
</div>

        <!-- Amenities (right) -->
        <div class="col-lg-4">
            <div class="amenities">
                <h5 class="mb-3 text-center">Featured Amenities</h5>

                <div class="amenity"><i class="bi bi-cup-hot"></i><span>Free Breakfast</span></div>
                <div class="amenity"><i class="bi bi-p-square"></i><span>Free Parking</span></div>
                <div class="amenity"><i class="bi bi-water"></i><span>Free Pool Indoor</span></div>
                <div class="amenity"><i class="bi bi-wifi"></i><span>Free Wifi</span></div>
                <div class="amenity"><i class="bi bi-heart"></i><span>Pet Friendly</span></div>
                <div class="amenity"><i class="bi bi-slash-circle"></i><span>Smoke Free</span></div>

                <div class="kv mt-3">
                    <div><span class="lbl">Check in</span><br><strong>4:00 PM</strong></div>
                    <div class="mt-2"><span class="lbl">Check Out</span><br><strong>11:00 AM</strong></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer py-5">
    <div class="container">
        <div class="footer-links text-center mt-4 small">
            <a href="#">Attractions</a> |
            <a href="${pageContext.request.contextPath}/reservation">Reservations</a> |
            <a href="${pageContext.request.contextPath}/about">About Us</a> |
            <a href="${pageContext.request.contextPath}/login">Login</a> |
            <a href="#">My Reservation</a>
            <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
