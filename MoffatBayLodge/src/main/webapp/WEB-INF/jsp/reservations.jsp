<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Reservations – Moffat Bay Lodge</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
</head>
<body class="bg-light">

  <!-- Header / Navbar -->
  <header class="bg-teal p-3">
    <div class="container d-flex justify-content-between align-items-center">
      <a href="${pageContext.request.contextPath}/" class="navbar-brand d-flex align-items-center text-white">
        <img src="${pageContext.request.contextPath}/images/MoffatBayLogo.png" alt="Moffat Bay Lodge Logo" height="50" class="me-2">
        <span class="fw-bold">MOFFAT BAY LODGE</span>
      </a>
      <nav>
        <a href="${pageContext.request.contextPath}/" class="btn btn-warning fw-bold mx-1">Home</a>
        <a href="${pageContext.request.contextPath}/attractions" class="btn btn-warning fw-bold mx-1">Attractions</a>
        <a href="${pageContext.request.contextPath}/reservations" class="btn btn-warning fw-bold mx-1">Reservations</a>
        <a href="${pageContext.request.contextPath}/myreservation" class="btn btn-warning fw-bold mx-1">My Reservation</a>
        <a href="${pageContext.request.contextPath}/about" class="btn btn-warning fw-bold mx-1">About Us</a>
        <a href="${pageContext.request.contextPath}/login" class="btn btn-warning fw-bold mx-1">Login / Register</a>
      </nav>
    </div>
  </header>

  <!-- Main Content -->
  <main class="container py-5">
    <h1 class="text-center mb-3">Reservations</h1>
    <p class="lead text-center mb-4">Plan your perfect stay with us! Select your dates and guests to check availability.</p>

    <!-- Reservation Form -->
    <div class="card shadow-sm p-4 mx-auto" style="max-width: 600px;">
      <form>
        <div class="mb-3">
          <label for="checkin" class="form-label">Check In</label>
          <input type="date" id="checkin" name="checkin" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="checkout" class="form-label">Check Out</label>
          <input type="date" id="checkout" name="checkout" class="form-control" required>
        </div>
        <div class="mb-3">
          <label for="guests" class="form-label">Guests</label>
          <input type="number" id="guests" name="guests" class="form-control" min="1" value="1">
        </div>
        <button type="submit" class="btn btn-warning fw-bold w-100">Search Availability</button>
      </form>
    </div>
  </main>

  <!-- Footer -->
  <footer class="text-center py-4 text-muted">
    © 2025 Moffat Bay Lodge
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

