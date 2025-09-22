<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge – Reservation Lookup</title>

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
            <!-- Show Logout if logged in, otherwise Login/Register -->
            <c:choose>
                <c:when test="${not empty sessionScope.auth}">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-login">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="btn-login">Login / Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- Lookup Card -->
<header class="hero-compact">
    <div class="container">
        <div class="summary-card p-4 p-md-5 mx-auto">
            <h1 class="display-6 text-center mb-4">LOOK UP RESERVATION</h1>

            <!-- Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success mt-3" role="alert">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3" role="alert">${error}</div>
            </c:if>

            <!-- Lookup Form -->
            <form id="lookupForm" class="needs-validation" novalidate method="get" action="${pageContext.request.contextPath}/reservations/lookup">
                <div class="row g-3">
                    <div class="col-12 col-md-6">
                        <label for="confNumber" class="form-label">Reservation ID / Confirmation #</label>
                        <input type="text" class="form-control" id="confNumber" name="confirmation" placeholder="e.g., 1" autocomplete="off">
                    </div>
                    <div class="col-12 col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" autocomplete="email">
                    </div>
                </div>
                <div class="d-flex justify-content-center gap-2 mt-4 form-actions">
                    <button type="submit" class="btn btn-warning fw-bold px-4">
                        <i class="bi bi-search me-1"></i> Look Up
                    </button>
                    <a href="${pageContext.request.contextPath}/reservations/lookup" class="btn btn-secondary px-4">Clear</a>
                </div>
            </form>

            <!-- Single reservation -->
            <c:if test="${not empty reservation}">
                <div class="mt-4">
                    <h2 class="h5 mb-2">Reservation Summary</h2>
                    <div class="p-3 border rounded">
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Room Size</div>
                            <div class="col kv-value"><c:out value="${reservation.room.roomSize}" default="—"/></div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Guests</div>
                            <div class="col kv-value">${reservation.numberOfGuests}</div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Check-in</div>
                            <div class="col kv-value">${reservation.checkinFormatted}</div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Check-out</div>
                            <div class="col kv-value">${reservation.checkoutFormatted}</div>
                        </div>

                        <div class="d-flex justify-content-center gap-2 mt-3 form-actions">
                            <a href="${pageContext.request.contextPath}/reservations/manage?conf=${reservation.reservationID}"
                               class="btn btn-warning fw-bold px-4">Modify Reservation</a>
                            <a href="${pageContext.request.contextPath}/reservations/cancel?conf=${reservation.reservationID}"
                               class="btn btn-secondary px-4"
                               onclick="return confirm('Are you sure you want to cancel this reservation?');">
                                Cancel Reservation
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Multiple reservations -->
            <c:if test="${not empty reservations}">
                <div class="mt-4">
                    <h2 class="h5 mb-2">Reservations for this email</h2>
                    <c:forEach var="res" items="${reservations}">
                        <div class="p-3 mb-3 border rounded">
                            <div class="row kv-row">
                                <div class="col-5 col-md-4 kv-label">Reservation ID</div>
                                <div class="col kv-value">${res.reservationID}</div>
                            </div>
                            <div class="row kv-row">
                                <div class="col-5 col-md-4 kv-label">Room Size</div>
                                <div class="col kv-value"><c:out value="${res.room.roomSize}" default="—"/></div>
                            </div>
                            <div class="row kv-row">
                                <div class="col-5 col-md-4 kv-label">Guests</div>
                                <div class="col kv-value">${res.numberOfGuests}</div>
                            </div>
                            <div class="row kv-row">
                                <div class="col-5 col-md-4 kv-label">Check-in</div>
                                <div class="col kv-value">${res.checkinFormatted}</div>
                            </div>
                            <div class="row kv-row">
                                <div class="col-5 col-md-4 kv-label">Check-out</div>
                                <div class="col kv-value">${res.checkoutFormatted}</div>
                            </div>

                            <div class="d-flex justify-content-center gap-2 mt-3 form-actions">
                                <a href="${pageContext.request.contextPath}/reservations/manage?conf=${res.reservationID}"
                                   class="btn btn-warning fw-bold px-4">Modify Reservation</a>
                                <a href="${pageContext.request.contextPath}/reservations/cancel?conf=${res.reservationID}"
                                   class="btn btn-secondary px-4"
                                   onclick="return confirm('Are you sure you want to cancel this reservation?');">
                                    Cancel Reservation
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- No reservations -->
            <c:if test="${empty reservation && empty reservations && searchPerformed}">
                <div class="alert alert-warning mt-3" role="alert">
                    No reservations found.
                </div>
            </c:if>

        </div>
    </div>
</header>

<!-- Footer -->
<footer class="footer py-5">
    <div class="container">
        <div class="row text-center text-md-start align-items-stretch">
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
<script>
    (function(){
        const form = document.getElementById('lookupForm');
        const conf = document.getElementById('confNumber');
        const email = document.getElementById('email');

        form.addEventListener('submit', function(e){
            const hasConf = conf.value.trim().length > 0;
            const hasEmail = email.value.trim().length > 0;
            if (!hasConf && !hasEmail) {
                e.preventDefault(); e.stopPropagation();
                form.classList.add('was-validated');
                email.setCustomValidity('Provide reservation ID or email.');
                email.reportValidity();
            } else {
                email.setCustomValidity('');
            }
        });

        email.addEventListener('input', () => email.setCustomValidity(''));
    })();
</script>

</body>
</html>
