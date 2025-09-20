<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge – Reservation Lookup</title>

    <!-- Bootstrap / Icons -->
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
        .summary-card h1 { font-weight: 800; letter-spacing: .5px; }
        .kv-row { padding: .65rem 0; border-bottom: 1px solid #f0f0f0; }
        .kv-label { font-weight: 700; color: #374151; }
        .kv-value { color: #111827; }
    </style>
</head>
<body>

<!-- NavBar -->
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
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login / Register</a>
        </div>
    </div>
</nav>

<!-- Lookup Card -->
<header class="hero-compact">
    <div class="container">
        <div class="summary-card p-4 p-md-5 mx-auto">
            <h1 class="display-6 text-center mb-4" style="font-weight:800; letter-spacing:.5px;">LOOK UP RESERVATION</h1>

            <!-- Lookup Form -->
            <form id="lookupForm" class="needs-validation" novalidate method="get" action="${pageContext.request.contextPath}/reservations/lookup">
                <div class="row g-3">
                    <div class="col-12 col-md-6">
                        <label for="confNumber" class="form-label">Reservation ID / Confirmation #</label>
                        <input type="text" class="form-control" id="confNumber" name="confirmation" placeholder="e.g., MB-123456" autocomplete="off">
                    </div>

                    <div class="col-12 col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" autocomplete="email">
                    </div>
                </div>

                <div class="d-flex justify-content-center gap-2 mt-4">
                    <button id="btnLookup" type="submit" class="btn btn-warning fw-bold px-4">
                        <i class="bi bi-search me-1"></i> Look Up
                    </button>
                    <button id="btnReset" type="button" class="btn btn-secondary px-4">Clear</button>
                </div>
            </form>

            <!-- Server Results to include summary with the room size, number of guests, and check-in/out dates -->
            <c:if test="${not empty reservation}">
                <div id="resultsWrap" class="mt-4">
                    <h2 class="h5 mb-2">Reservation Summary</h2>
                    <div class="container px-0">
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Room Size</div>
                            <div class="col kv-value"><c:out value="${reservation.roomSize}" default="—"/></div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Guests</div>
                            <div class="col kv-value"><c:out value="${reservation.guests}" default="—"/></div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Check-in</div>
                            <div class="col kv-value">
                                <c:choose>
                                    <c:when test="${not empty reservation.checkIn}"><fmt:formatDate value="${reservation.checkIn}" pattern="MM/dd/yyyy"/></c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="row kv-row">
                            <div class="col-5 col-md-4 kv-label">Check-out</div>
                            <div class="col kv-value">
                                <c:choose>
                                    <c:when test="${not empty reservation.checkOut}"><fmt:formatDate value="${reservation.checkOut}" pattern="MM/dd/yyyy"/></c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center gap-2 mt-3">
                        <a href="<c:url value='/reservations/details'><c:param name='conf' value='${reservation.confirmation}'/></c:url>" class="btn btn-outline-dark px-4">View Details</a>
                        <a href="<c:url value='/reservations/manage'><c:param name='conf' value='${reservation.confirmation}'/></c:url>" class="btn btn-outline-secondary px-4">Modify / Cancel</a>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty reservation && not empty searchPerformed}">
                <div id="noResults" class="alert alert-warning mt-3" role="alert">
                    No reservations found.
                </div>
            </c:if>

        </div>
    </div>
</header>

<!-- Footer -->
<footer class="footer py-5">
    <div class="container">
        <div class="footer-links text-center mt-4 small">
            <a href="#">Attractions</a> |
            <a href="${pageContext.request.contextPath}/reservation">Reservations</a> |
            <a href="#">About Us</a> |
            <a href="${pageContext.request.contextPath}/login">Login</a> |
            <a href="#">My Reservation</a>
            <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function(){
        const form = document.getElementById('lookupForm');
        const conf = document.getElementById('confNumber');
        const email = document.getElementById('email');
        const btnReset = document.getElementById('btnReset');

        btnReset?.addEventListener('click', () => {
            form.reset();
            form.classList.remove('was-validated');
            conf.focus();
        });

        // Require the Reservation ID or email to for lookup
        form.addEventListener('submit', function(e){
            if (!form.checkValidity()) {
                e.preventDefault(); e.stopPropagation();
                form.classList.add('was-validated');
                return;
            }
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