<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestion des Salles - Clinique Digitale</title>
  <style>
    /* Styles identiques à la page départements */
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

    .admin-container {
      display: flex;
      min-height: 100vh;
    }

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

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      text-align: center;
      transition: transform 0.3s ease;
    }

    .stat-card:hover {
      transform: translateY(-5px);
    }

    .stat-card.salles { border-top: 4px solid #3498db; }
    .stat-card.disponibles { border-top: 4px solid #27ae60; }
    .stat-card.capacite { border-top: 4px solid #e74c3c; }
    .stat-card.occupees { border-top: 4px solid #f39c12; }

    .stat-number {
      font-size: 2.5rem;
      font-weight: bold;
      color: var(--secondary);
      display: block;
    }

    .stat-label {
      color: #7f8c8d;
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .content-card {
      background: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      padding: 30px;
      margin-bottom: 20px;
    }

    .table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .table-header h3 {
      color: var(--secondary);
      margin: 0;
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

    .btn-success {
      background: var(--success);
      color: white;
    }

    .btn-danger {
      background: var(--danger);
      color: white;
    }

    .btn-warning {
      background: var(--warning);
      color: white;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 15px;
      text-align: left;
      border-bottom: 1px solid #ecf0f1;
    }

    th {
      background: #f8f9fa;
      color: var(--secondary);
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.8rem;
      letter-spacing: 1px;
    }

    tr:hover {
      background: #f8f9fa;
    }

    .badge {
      padding: 5px 10px;
      border-radius: 15px;
      font-size: 0.8rem;
      font-weight: 500;
    }

    .badge-success { background: #d4edda; color: #155724; }
    .badge-warning { background: #fff3cd; color: #856404; }
    .badge-danger { background: #f8d7da; color: #721c24; }
    .badge-primary { background: #d1ecf1; color: #0c5460; }
    .badge-purple { background: #e2e3f5; color: #383d81; }

    .actions {
      display: flex;
      gap: 10px;
    }

    .action-btn {
      padding: 5px 10px;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      font-size: 0.8rem;
    }

    .salle-icon {
      width: 50px;
      height: 50px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      color: white;
      margin-right: 15px;
    }

    .salle-info {
      display: flex;
      align-items: center;
    }

    .salle-name {
      font-weight: 600;
      color: var(--secondary);
    }

    .salle-desc {
      color: #7f8c8d;
      font-size: 0.9rem;
    }

    @media (max-width: 768px) {
      .admin-container {
        flex-direction: column;
      }

      .sidebar {
        width: 100%;
        height: auto;
      }

      .stats-grid {
        grid-template-columns: 1fr;
      }

      .table-header {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
      }

      .salle-info {
        flex-direction: column;
        align-items: flex-start;
      }

      .salle-icon {
        margin-right: 0;
        margin-bottom: 10px;
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
      <li><a href="departements"><i class="fas fa-building"></i> Départements</a></li>
      <li><a href="consultations"><i class="fas fa-calendar-check"></i> Consultations</a></li>
      <li><a href="salles" class="active"><i class="fas fa-door-open"></i> Salles</a></li>
      <li><a href="statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
      <li><a href="logout" style="color: var(--danger);"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
    </ul>
  </nav>

  <!-- Contenu principal -->
  <main class="main-content">
    <!-- Header -->
    <div class="header">
      <h2><i class="fas fa-door-open"></i> Gestion des Salles</h2>
      <div class="user-info">
        <div class="user-avatar">A</div>
        <span>Administrateur</span>
      </div>
    </div>

    <!-- Cartes de statistiques -->
    <div class="stats-grid">
      <div class="stat-card salles">
        <span class="stat-number">
          <c:choose>
            <c:when test="${not empty stats.totalSalles}">${stats.totalSalles}</c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </span>
        <span class="stat-label">Salles Total</span>
        <i class="fas fa-door-open" style="font-size: 2rem; color: #3498db; margin-top: 10px;"></i>
      </div>
      <div class="stat-card disponibles">
        <span class="stat-number">
          <c:choose>
            <c:when test="${not empty stats.sallesDisponibles}">${stats.sallesDisponibles}</c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </span>
        <span class="stat-label">Salles Disponibles</span>
        <i class="fas fa-check-circle" style="font-size: 2rem; color: #27ae60; margin-top: 10px;"></i>
      </div>
      <div class="stat-card capacite">
        <span class="stat-number">
          <c:choose>
            <c:when test="${not empty stats.capaciteTotale}">${stats.capaciteTotale}</c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </span>
        <span class="stat-label">Capacité Totale</span>
        <i class="fas fa-users" style="font-size: 2rem; color: #e74c3c; margin-top: 10px;"></i>
      </div>
      <div class="stat-card occupees">
        <span class="stat-number">
          <c:choose>
            <c:when test="${not empty stats.sallesOccupees}">${stats.sallesOccupees}</c:when>
            <c:otherwise>0</c:otherwise>
          </c:choose>
        </span>
        <span class="stat-label">Salles Occupées</span>
        <i class="fas fa-clock" style="font-size: 2rem; color: #f39c12; margin-top: 10px;"></i>
      </div>
    </div>

    <!-- Liste des salles -->
    <div class="content-card">
      <div class="table-header">
        <h3><i class="fas fa-list"></i> Liste des Salles</h3>
        <a href="salles?action=new" class="btn btn-primary" style="margin-top: 10px;">
          <i class="fas fa-plus"></i> Nouvelle Salle
        </a>
      </div>

      <c:if test="${empty salles}">
        <div style="text-align: center; padding: 40px; color: #7f8c8d;">
          <i class="fas fa-door-open" style="font-size: 3rem; margin-bottom: 20px;"></i>
          <p>Aucune salle trouvée dans la base de données.</p>
          <a href="salles?action=new" class="btn btn-primary" style="margin-top: 10px;">
            <i class="fas fa-plus"></i> Créer la première salle
          </a>
        </div>
      </c:if>

      <c:if test="${not empty salles}">
        <table>
          <thead>
          <tr>
            <th>Salle</th>
            <th>Capacité</th>
            <th>Créneau</th>
            <th>Statut</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="salle" items="${salles}">
            <tr>
              <td>
                <div class="salle-info">
                  <div class="salle-icon" style="background:
                  <c:choose>
                  <c:when test="${salle.capacite >= 10}">#e74c3c</c:when>
                  <c:when test="${salle.capacite >= 5}">#3498db</c:when>
                  <c:otherwise>#f39c12</c:otherwise>
                  </c:choose>;">
                    <i class="fas
                      <c:choose>
                        <c:when test="${salle.capacite >= 10}">fa-users</c:when>
                        <c:when test="${salle.capacite >= 5}">fa-user-friends</c:when>
                        <c:otherwise>fa-user</c:otherwise>
                      </c:choose>"></i>
                  </div>
                  <div>
                    <div class="salle-name">${salle.nomSalle}</div>
                    <div class="salle-desc">
                      <c:choose>
                        <c:when test="${salle.capacite >= 10}">Salle de conférence</c:when>
                        <c:when test="${salle.capacite >= 5}">Salle de consultation groupe</c:when>
                        <c:otherwise>Salle individuelle</c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>
              </td>
              <td>
                <span class="badge badge-primary">
                  ${salle.capacite} personnes
                </span>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty salle.creneau}">
                    <span class="badge badge-warning">
                      <i class="fas fa-clock"></i> ${salle.creneau}
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-success">
                      <i class="fas fa-check"></i> Libre
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${not empty salle.creneau}">
                    <span class="badge badge-danger">
                      <i class="fas fa-times-circle"></i> Occupée
                    </span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-success">
                      <i class="fas fa-check-circle"></i> Disponible
                    </span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <div class="actions">
                  <a href="salles?action=edit&id=${salle.idSalle}" class="btn btn-primary" style="padding: 5px 10px; font-size: 0.8rem;">
                    <i class="fas fa-edit"></i>
                  </a>
                  <a href="salles?action=details&id=${salle.idSalle}" class="btn btn-success" style="padding: 5px 10px; font-size: 0.8rem;">
                    <i class="fas fa-info-circle"></i>
                  </a>
                  <a href="salles?action=delete&id=${salle.idSalle}" class="btn btn-danger" style="padding: 5px 10px; font-size: 0.8rem;"
                     onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?')">
                    <i class="fas fa-trash"></i>
                  </a>
                </div>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:if>
    </div>

    <!-- Salles par capacité -->
    <div class="content-card">
      <div class="table-header">
        <h3><i class="fas fa-chart-pie"></i> Répartition par Capacité</h3>
      </div>
      <div style="text-align: center; padding: 20px; color: #7f8c8d;">
        <i class="fas fa-chart-bar" style="font-size: 2rem; margin-bottom: 10px;"></i>
        <p>Distribution des salles selon leur capacité</p>
        <div style="display: flex; justify-content: center; gap: 20px; margin-top: 20px; flex-wrap: wrap;">
          <div style="text-align: center;">
            <div style="background: #f39c12; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
              <i class="fas fa-user"></i>
            </div>
            <div>Petites</div>
            <small>1-4 personnes</small>
          </div>
          <div style="text-align: center;">
            <div style="background: #3498db; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
              <i class="fas fa-user-friends"></i>
            </div>
            <div>Moyennes</div>
            <small>5-9 personnes</small>
          </div>
          <div style="text-align: center;">
            <div style="background: #e74c3c; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
              <i class="fas fa-users"></i>
            </div>
            <div>Grandes</div>
            <small>10+ personnes</small>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.nav-links a');

    navLinks.forEach(link => {
      const linkPage = link.getAttribute('href');
      if (linkPage === currentPage || (currentPage === '' && linkPage === 'salles')) {
        link.classList.add('active');
      }
    });
  });
</script>
</body>
</html>