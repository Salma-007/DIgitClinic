<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nouveau Département - Clinique Digitale</title>
  <style>
    /* Reset et variables */
    :root {
      --primary: #3498db;
      --secondary: #2c3e50;
      --success: #27ae60;
      --danger: #e74c3c;
      --warning: #f39c12;
      --light: #ecf0f1;
      --dark: #2c3e50;
      --sidebar-width: 250px;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
    }

    /* Layout principal */
    .admin-container {
      display: flex;
      min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: var(--sidebar-width);
      background: var(--secondary);
      color: white;
      padding: 20px 0;
      box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    }

    .logo {
      text-align: center;
      padding: 20px;
      border-bottom: 1px solid rgba(255,255,255,0.1);
      margin-bottom: 20px;
    }

    .logo h1 {
      font-size: 1.5rem;
      color: white;
    }

    .logo span {
      color: var(--primary);
    }

    .nav-links {
      list-style: none;
    }

    .nav-links li {
      margin: 5px 0;
    }

    .nav-links a {
      display: flex;
      align-items: center;
      padding: 15px 25px;
      color: var(--light);
      text-decoration: none;
      transition: all 0.3s ease;
      border-left: 4px solid transparent;
    }

    .nav-links a:hover, .nav-links a.active {
      background: rgba(255,255,255,0.1);
      border-left-color: var(--primary);
      color: white;
    }

    .nav-links i {
      margin-right: 10px;
      font-size: 1.2rem;
    }

    /* Contenu principal */
    .main-content {
      flex: 1;
      padding: 20px;
      background: #f8f9fa;
    }

    .header {
      background: white;
      padding: 20px 30px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      margin-bottom: 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header h2 {
      color: var(--secondary);
      margin: 0;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .user-avatar {
      width: 40px;
      height: 40px;
      background: var(--primary);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
    }

    .btn-primary:hover {
      background: #2980b9;
      transform: translateY(-2px);
    }

    .btn-danger {
      background: var(--danger);
      color: white;
    }

    .btn-warning {
      background: var(--warning);
      color: white;
    }

    .badge {
      padding: 5px 10px;
      border-radius: 15px;
      font-size: 0.8rem;
      font-weight: 500;
    }

    .badge-success { background: #d4edda; color: #155724; }
    .badge-warning { background: #fff3cd; color: #856404; }

    /* Styles spécifiques au formulaire */
    .form-container {
      background: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 40px;
      max-width: 600px;
      margin: 0 auto;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: var(--secondary);
    }

    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #ecf0f1;
      border-radius: 8px;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    .form-control:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }

    .form-actions {
      display: flex;
      gap: 15px;
      justify-content: flex-end;
      margin-top: 30px;
    }

    /* Responsive */
    @media (max-width: 768px) {
      .admin-container {
        flex-direction: column;
      }

      .sidebar {
        width: 100%;
        height: auto;
      }

      .form-container {
        padding: 20px;
      }

      .form-actions {
        flex-direction: column;
      }
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="admin-container">
  <!-- Sidebar -->
  <nav class="sidebar">
    <div class="logo">
      <h1>Digit<span>Clinic</span></h1>
    </div>
    <ul class="nav-links">
      <li><a href="dashboard-admin.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
      <li><a href="patients"><i class="fas fa-user-injured"></i> Patients</a></li>
      <li><a href="docteurs"><i class="fas fa-user-md"></i> Médecins</a></li>
      <li><a href="departements" class="active"><i class="fas fa-building"></i> Départements</a></li>
      <li><a href="consultations"><i class="fas fa-calendar-check"></i> Consultations</a></li>
      <li><a href="salles"><i class="fas fa-door-open"></i> Salles</a></li>
      <li><a href="statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
      <li><a href="logout" style="color: var(--danger);"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
  </nav>

  <!-- Contenu principal -->
  <main class="main-content">
    <!-- Header -->
    <div class="header">
      <h2><i class="fas fa-plus-circle"></i> Nouveau Département</h2>
      <div class="user-info">
        <div class="user-avatar">A</div>
        <span>Administrateur</span>
      </div>
    </div>

    <div class="form-container">
      <form action="departements" method="post">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
          <label for="nom"><i class="fas fa-building"></i> Nom du Département</label>
          <input type="text" id="nom" name="nom" class="form-control"
                 placeholder="Ex: Cardiologie, Dermatologie, Pédiatrie..." required>
        </div>

        <div class="form-actions">
          <a href="departements" class="btn btn-danger">
            <i class="fas fa-times"></i> Annuler
          </a>
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Créer le Département
          </button>
        </div>
      </form>
    </div>
  </main>
</div>

<script>
  // Script pour le menu actif
  document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-links a');

    navLinks.forEach(link => {
      if (link.getAttribute('href') === 'departements') {
        link.classList.add('active');
      }
    });

    // Animation pour le formulaire
    const form = document.querySelector('form');
    form.style.opacity = '0';
    form.style.transform = 'translateY(20px)';

    setTimeout(() => {
      form.style.transition = 'all 0.5s ease';
      form.style.opacity = '1';
      form.style.transform = 'translateY(0)';
    }, 100);
  });
</script>
</body>
</html>