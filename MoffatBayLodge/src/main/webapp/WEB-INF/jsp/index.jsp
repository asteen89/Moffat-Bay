<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge</title>

    <!-- Bootstrap + (optional) Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- site styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css?v=5">

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
                <li class="nav-item"><a href="#" class="nav-btn">Home</a></li>
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

<!-- Hero Section -->
<header class="hero d-flex align-items-center text-white">
    <div class="container position-relative">
        <div class="row align-items-center">
            <div class="col-md-8 text-start">
                <h1 class="display-3 fw-bold">Escape to Moffat<br>Bay Lodge</h1>
                <p class="lead mb-4">Relax, explore and create lasting memories.</p>
            </div>
            <div class="col-md-4 text-md-end text-center mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/reservation" class="btn btn-warning btn-lg fw-bold hero-btn">Book Your Stay</a>
            </div>
        </div>
    </div>
</header>

<!-- Booking Section -->
<section class="container my-5">
    <div class="booking-box row g-3 p-4 rounded-4 shadow">
        <div class="col-12 col-md-3">
            <label for="checkin"><i class="bi bi-calendar-date me-2"></i>Check In</label>
            <input id="checkin" type="date" class="form-control">
        </div>

        <div class="col-12 col-md-3">
            <label for="checkout"><i class="bi bi-calendar-date me-2"></i>Check Out</label>
            <input id="checkout" type="date" class="form-control">
        </div>

        <div class="col-12 col-md-3">
            <label for="guests"><i class="bi bi-person me-2"></i>Guests</label>
            <select id="guests" class="form-select">
                <option>1</option><option>2</option><option>3</option><option>4</option>
                <option>5</option><option>6</option><option>7</option><option>8</option><option>9</option>
            </select>
        </div>

        <div class="col-12 col-md-2 d-flex align-items-end justify-content-end">
            <button class="btn btn-warning fw-bold search-btn">Search Now</button>
        </div>
    </div>
</section>

<!-- Gallery Section -->
<section class="gallery py-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <img src="images/room.png" alt="Room" class="gallery-img">
            </div>
            <div class="col-md-4">
                <img src="images/patio.png" alt="Patio" class="gallery-img">
            </div>
            <div class="col-md-4">
                <img src="images/spa.png" alt="Spa" class="gallery-img">
            </div>
        </div>
    </div>
</section>


<!-- Footer -->
<footer class="footer py-5">
    <div class="container">
        <div class="row text-center text-md-start align-items-stretch">

            <!-- Social -->
            <div class="col-md-3 mb-4 mb-md-0">
                <div class="footer-social text-center">
                    <h6 class="fw-bold footer-heading">Follow us</h6>
                    <div class="social-icons mt-3">
                        <a href="#"><i class="bi bi-facebook fs-4 me-3"></i></a>
                        <a href="#"><i class="bi bi-google fs-4 me-3"></i></a>
                        <a href="#"><i class="bi bi-twitter fs-4"></i></a>
                    </div>
                </div>
            </div>

            <!-- Newsletter -->
            <div class="col-md-6 mb-4 mb-md-0">
                <div class="newsletter-box">
                    <div class="newsletter-content">
                        <div class="newsletter-logo">
                            <a href="index.jsp">
                                <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="img-fluid">
                            </a>
                        </div>

                        <div class="newsletter-text">
                            <h6 class="fw-bold">Subscribe to our Newsletter!</h6>
                            <p class="small mb-3">
                                Stay connected with us!<br>
                                Join our mailing list to receive updates and special discounts.
                            </p>

                            <!-- Newsletter form -->
                            <form id="newsletterForm" class="d-flex" novalidate>
                                <input id="newsletterEmail" type="email" class="form-control me-2" placeholder="Your Email" required>
                                <button type="submit" class="btn btn-info text-white fw-bold w-100">Subscribe</button>
                            </form>
                            <small id="newsletterMsg" class="d-block mt-2"></small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Reviews -->
            <div class="col-md-3 mb-4 mb-md-0 text-center footer-reviews">
                <h6 class="fw-bold footer-heading">Reviews</h6>
                <div class="footer-box">
                    <p class="mb-0 rating">5.0</p>
                    <p class="mb-0 stars" style="color: #fbc02d;">⭐⭐⭐⭐⭐</p>
                </div>
            </div>
        </div>

        <!-- Bottom Links -->
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

<!-- Bootstrap bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Newsletter fetch JS -->

<script>
(function () {
  const form = document.getElementById('newsletterForm');
  const emailInput = document.getElementById('newsletterEmail');
  const msg = document.getElementById('newsletterMsg');

  function show(text, color) {
    msg.textContent = text;
    msg.style.color = color;
  }

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = emailInput.value.trim();

    show('', '');
    if (!email) {
      show('Please enter your email.', 'crimson');
      return;
    }

    try {
      const url = '${pageContext.request.contextPath}/api/newsletter';
      const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      });

      console.log('[newsletter] status', res.status);
      const ctype = res.headers.get('content-type') || '';
      let raw = await res.text();
      let data = null;
      try { data = ctype.includes('application/json') ? JSON.parse(raw) : null; }
      catch (_) { /* ignore parse error */ }

      console.log('[newsletter] body', raw || '(empty)');

      if (res.status === 409) {
        show('You are already subscribed.', 'green');
        return;
      }

      if (!res.ok) {
        show(data?.error || raw || `Subscription failed (HTTP ${res.status}).`, 'crimson');
        return;
      }

      // HTTP 200+ success: accept either JSON ok:true OR empty body
      const ok = (data && (data.ok === true || data.status === 'ok')) || !raw;
      if (ok) {
        show('Thanks for subscribing!', 'green');
        emailInput.value = '';
      } else {
        show(data?.error || 'Subscription failed.', 'crimson');
      }
    } catch (err) {
      console.error('[newsletter] fetch error', err);
      show('Network error. Please try again.', 'crimson');
    }
  });
})();
</script>


</body>
</html>
