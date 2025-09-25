<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Attractions – Moffat Bay Lodge</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <!-- Shared styles -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css" />
</head>
<body>

  <!-- Top/Nav (same as other pages) -->
  <nav class="navbar navbar-expand-lg navbar-dark navbar-custom py-3">
    <div class="container">
      <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/">
        <img class="logo me-2" src="${pageContext.request.contextPath}/images/MoffatBayLogo.png" alt="Moffat Bay Lodge">
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mbNav"
              aria-controls="mbNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="mbNav">
        <ul class="navbar-nav main-nav ms-0 ms-lg-3">
          <li class="nav-item"><a class="nav-link nav-btn" href="${pageContext.request.contextPath}/">Home</a></li>
          <li class="nav-item"><a class="nav-link nav-btn active" href="${pageContext.request.contextPath}/attractions">Attractions</a></li>
          <li class="nav-item"><a class="nav-link nav-btn" href="${pageContext.request.contextPath}/reservations">Reservations</a></li>
          <li class="nav-item"><a class="nav-link nav-btn" href="${pageContext.request.contextPath}/my-reservations">My Reservation</a></li>
          <li class="nav-item"><a class="nav-link nav-btn" href="${pageContext.request.contextPath}/about">About Us</a></li>
        </ul>

        <a class="btn-login ms-auto" href="${pageContext.request.contextPath}/login">Login / Register</a>
      </div>
    </div>
  </nav>

  <!-- Page title -->
  <header class="py-5 text-center bg-light">
    <div class="container">
      <h1 class="display-5 fw-bold">Discover Moffat Bay Lodge</h1>
    </div>
  </header>

  <!-- Highlights -->
  <section class="container py-5">
    <h2 class="h4 fw-bold mb-4">Highlights</h2>
    <div class="row g-4">
      <!-- Kayaking -->
      <div class="col-6 col-md-4 col-lg-2">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/images/rooms/kayaking.jpg"
               alt="Kayaking">
          <div class="card-body py-3 text-center">
            <span class="small fw-semibold">Kayaking</span>
          </div>
        </div>
      </div>

      <!-- Whale Watching -->
      <div class="col-6 col-md-4 col-lg-2">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/images/rooms/whale.jpg"
               alt="Whale Watching">
          <div class="card-body py-3 text-center">
            <span class="small fw-semibold">Whale Watching</span>
          </div>
        </div>
      </div>

      <!-- Hiking -->
      <div class="col-6 col-md-4 col-lg-2">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/images/rooms/hiking.jpg"
               alt="Hiking">
          <div class="card-body py-3 text-center">
            <span class="small fw-semibold">Hiking</span>
          </div>
        </div>
      </div>

      <!-- Scuba Diving -->
      <div class="col-6 col-md-4 col-lg-2">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/images/rooms/scuba-diving.jpg"
               alt="Scuba Diving">
          <div class="card-body py-3 text-center">
            <span class="small fw-semibold">Scuba Diving</span>
          </div>
        </div>
      </div>

      <!-- Map -->
      <div class="col-6 col-md-4 col-lg-2">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/images/rooms/Maps_Resort.webp"
               alt="Map of Moffat Bay area">
          <div class="card-body py-3 text-center">
            <span class="small fw-semibold">Map</span>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Featured -->
  <section class="container pb-5">
    <h2 class="h4 fw-bold mb-4">Featured</h2>
    <div class="row g-4">
      <!-- Lodge Rooms -->
      <div class="col-12 col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top" src="${pageContext.request.contextPath}/images/rooms/double-queen.jpg" alt="Lodge Rooms">

          <div class="card-body">
            <h5 class="card-title">Lodge Rooms</h5>
            <a class="btn btn-warning fw-bold" href="${pageContext.request.contextPath}/reservations">Book Now</a>
          </div>
        </div>
      </div>

      <!-- Marina -->
      <div class="col-12 col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top" src="${pageContext.request.contextPath}/images/rooms/marina.webp" alt="Marina">
          <div class="card-body">
            <h5 class="card-title">Marina</h5>
          </div>
        </div>
      </div>

      <!-- Spa -->
      <div class="col-12 col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm">
          <picture>
            <source srcset="${pageContext.request.contextPath}/images/rooms/spa.avif" type="image/avif">
            <img class="card-img-top" src="${pageContext.request.contextPath}/images/rooms/spa.png" alt="Spa">
          </picture>
          <div class="card-body">
            <h5 class="card-title">Spa</h5>
          </div>
        </div>
      </div>

      <!-- Guided Tours  -->
      <div class="col-12 col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top" src="${pageContext.request.contextPath}/images/rooms/tour.jpg" alt="Guided Tours">
          <div class="card-body">
            <h5 class="card-title">Guided Tours</h5>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Shared footer include -->
  <jsp:include page="footer.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
