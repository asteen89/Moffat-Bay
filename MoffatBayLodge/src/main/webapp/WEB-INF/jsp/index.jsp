<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moffat Bay Lodge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap / Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Your styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/WEB-INF/styles.css"><!-- if you serve css differently, adjust -->
    <link rel="stylesheet" href="styles.css"><!-- keep this if your styles.css is directly under /WEB-INF or /webapp -->
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center fw-bold text-white" href="${pageContext.request.contextPath}/">
            <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="logo">
        </a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Menu Items -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto me-auto main-nav">
                <li class="nav-item"><a href="#" class="nav-btn">Home</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">Attractions</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">Reservations</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">My Reservation</a></li>
                <li class="nav-item"><a href="#" class="nav-btn">About Us</a></li>
            </ul>
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Login / Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero d-flex align-items-center text-white">
    <div class="container position-relative">
        <div class="row align-items-center">
            <!-- Left side: text -->
            <div class="col-md-8 text-start">
                <h1 class="display-3 fw-bold">Escape to Moffat<br>Bay Lodge</h1>
                <p class="lead mb-4">Relax, explore and create lasting memories.</p>
            </div>
            <!-- Right side: button -->
            <div class="col-md-4 text-md-end text-center mt-3 mt-md-0">
                <a href="#" class="btn btn-warning btn-lg fw-bold hero-btn">Book Your Stay</a>
            </div>
        </div>
    </div>
</header>

<!-- Booking Section -->
<section class="container my-5">
    <div class="booking-box row g-3 p-4 rounded-4 shadow">
        <div class="col-12 col-md-3">
            <label><i class="bi bi-calendar-date me-2"></i>Check In</label>
            <input type="date" class="form-control">
        </div>

        <div class="col-12 col-md-3">
            <label><i class="bi bi-calendar-date me-2"></i>Check Out</label>
            <input type="date" class="form-control">
        </div>

        <div class="col-12 col-md-3">
            <label><i class="bi bi-person me-2"></i>Guests</label>
            <select class="form-select">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
                <option>6</option>
                <option>7</option>
                <option>8</option>
                <option>9</option>
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
        <div class="row justify-content-center g-4">
            <div class="col-md-4">
                <img src="images/room.png" alt="Room" class="gallery-img w-100">
            </div>
            <div class="col-md-4">
                <img src="images/patio.png" alt="Patio" class="gallery-img w-100">
            </div>
            <div class="col-md-4">
                <img src="images/spa.png" alt="Spa" class="gallery-img w-100">
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
                            <a href="${pageContext.request.contextPath}/">
                                <img src="images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" class="img-fluid">
                            </a>
                        </div>

                        <div class="newsletter-text">
                            <h6 class="fw-bold">Subscribe to our Newsletter!</h6>
                            <p class="small mb-3">
                                Stay connected with us!<br>
                                Join our mailing list to receive updates and special discounts.
                            </p>

                            <!-- Wired-up newsletter form -->
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
        <div class="text-center mt-4 small">
            <a href="#">Attractions</a> |
            <a href="#">Reservations</a> |
            <a href="#">About Us</a> |
            <a href="${pageContext.request.contextPath}/login">Login</a> |
            <a href="#">Contact Us</a>
            <p class="mt-2 mb-0">© 2025 Moffat Bay Lodge</p>
        </div>
    </div>
</footer>

<!-- Newsletter JS (calls your Spring endpoint) -->
<script>
(() => {
  const form = document.getElementById('newsletterForm');
  const emailEl = document.getElementById('newsletterEmail');
  const msg = document.getElementById('newsletterMsg');
  if (!form) return;

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    msg.textContent = 'Submitting...';
    msg.style.color = 'inherit';

    const email = (emailEl.value || '').trim();

    try {
      // If your controller class has @RequestMapping("/api"), keep /api/newsletter.
      // If not, change to `${pageContext.request.contextPath}/newsletter`.
      const res = await fetch('${pageContext.request.contextPath}/api/newsletter', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email })
      });

      const data = await res.json();
      if (res.ok && data.ok) {
        msg.style.color = 'green';
        msg.textContent = 'Thanks for subscribing!';
        form.reset();
      } else {
        msg.style.color = 'crimson';
        msg.textContent = (data && data.error) ? data.error : 'Subscription failed.';
      }
    } catch (err) {
      msg.style.color = 'crimson';
      msg.textContent = 'Network error. Please try again.';
    }
  });
})();
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
