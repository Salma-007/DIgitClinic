<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Espace Patient - Clinique Digitale</title>
  <style>
    :root {
      --primary: #3498db;
      --secondary: #2c3e50;
      --success: #27ae60;
      --danger: #e74c3c;
      --warning: #f39c12;
      --light: #ecf0f1;
      --dark: #2c3e50;
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
      padding: 20px;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .header {
      background: white;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .welcome-section h1 {
      color: var(--secondary);
      margin-bottom: 10px;
    }

    .welcome-section p {
      color: #7f8c8d;
      font-size: 1.1rem;
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
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      text-align: center;
    }

    .stat-card i {
      font-size: 2.5rem;
      margin-bottom: 15px;
    }

    .stat-card.primary { color: var(--primary); }
    .stat-card.success { color: var(--success); }
    .stat-card.warning { color: var(--warning); }

    .stat-number {
      font-size: 2rem;
      font-weight: bold;
      display: block;
    }

    .stat-label {
      color: #7f8c8d;
      font-size: 0.9rem;
    }

    .actions-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
    }

    .action-card {
      background: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      text-align: center;
      transition: transform 0.3s ease;
    }

    .action-card:hover {
      transform: translateY(-5px);
    }

    .action-card i {
      font-size: 3rem;
      margin-bottom: 20px;
      color: var(--primary);
    }

    .btn {
      padding: 12px 25px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-weight: 500;
      transition: all 0.3s ease;
      font-size: 1rem;
    }

    .btn-primary {
      background: var(--primary);
      color: white;
    }

    .btn-primary:hover {
      background: #2980b9;
    }

    .consultations-list {
      background: white;
      border-radius: 15px;
      padding: 30px;
      margin-top: 30px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .consultations-list h3 {
      color: var(--secondary);
      margin-bottom: 20px;
    }

    .consultation-item {
      padding: 15px;
      border: 1px solid #ecf0f1;
      border-radius: 8px;
      margin-bottom: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logout-btn {
      background: var(--danger);
      color: white;
      padding: 10px 20px;
      border-radius: 8px;
      text-decoration: none;
      margin-left: auto;
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <!-- En-tête -->
  <div class="header">
    <div class="welcome-section">
      <h1>Bienvenue, ${patient.prenom} ${patient.nom} !</h1>
      <p>Votre espace patient - Gérez vos consultations médicales</p>
    </div>
    <a href="${pageContext.request.contextPath}/login?logout=true" class="logout-btn">
      <i class="fas fa-sign-out-alt"></i> Déconnexion
    </a>
  </div>

  <!-- Messages -->
  <c:if test="${not empty param.error}">
    <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
      <i class="fas fa-exclamation-triangle"></i> ${param.error}
    </div>
  </c:if>

  <c:if test="${not empty param.success}">
    <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
      <i class="fas fa-check-circle"></i> ${param.success}
    </div>
  </c:if>

  <!-- Statistiques -->
  <div class="stats-grid">
    <div class="stat-card primary">
      <i class="fas fa-calendar-check"></i>
      <span class="stat-number">${totalConsultations}</span>
      <span class="stat-label">Consultations totales</span>
    </div>
    <div class="stat-card success">
      <i class="fas fa-calendar-day"></i>
      <span class="stat-number">${consultationsAujourdhui}</span>
      <span class="stat-label">Aujourd'hui</span>
    </div>
    <div class="stat-card warning">
      <i class="fas fa-clock"></i>
      <span class="stat-number">${consultationsProchaines}</span>
      <span class="stat-label">Consultations à venir</span>
    </div>
  </div>

  <!-- Actions rapides -->
  <div class="actions-grid">
    <div class="action-card">
      <i class="fas fa-calendar-plus"></i>
      <h3>Nouvelle Consultation</h3>
      <p>Prendre un nouveau rendez-vous avec un médecin</p>
      <a href="${pageContext.request.contextPath}/patient-space?action=new-consultation" class="btn btn-primary">
        <i class="fas fa-plus"></i> Prendre RDV
      </a>
    </div>

    <div class="action-card">
      <i class="fas fa-list-alt"></i>
      <h3>Mes Consultations</h3>
      <p>Consulter l'historique de vos rendez-vous</p>
      <a href="${pageContext.request.contextPath}/patient-space?action=consultations" class="btn btn-primary">
        <i class="fas fa-eye"></i> Voir mes RDV
      </a>
    </div>
  </div>

  <div class="consultations-list">
    <h3><i class="fas fa-history"></i> Dernières Consultations</h3>
    <c:if test="${empty consultations}">
      <p style="color: #7f8c8d; text-align: center;">Aucune consultation pour le moment</p>
    </c:if>
    <c:forEach var="consultation" items="${consultations}" end="4">
      <div class="consultation-item">
        <div>
          <strong>${consultation.date} à ${consultation.heure}</strong>
          <br>Dr. ${consultation.docteur.prenom} ${consultation.docteur.nom}
          <br>${consultation.salle.nomSalle}
        </div>
        <div>
                        <span style="background:
                        <c:choose>
                        <c:when test="${consultation.statut == 'RESERVEE'}">#f39c12</c:when>
                        <c:when test="${consultation.statut == 'VALIDEE'}">#3498db</c:when>
                        <c:when test="${consultation.statut == 'TERMINEE'}">#27ae60</c:when>
                        <c:when test="${consultation.statut == 'ANNULEE'}">#e74c3c</c:when>
                        <c:otherwise>#95a5a6</c:otherwise>
                        </c:choose>;
                                color: white; padding: 5px 10px; border-radius: 15px; font-size: 0.8rem;">
                            ${consultation.statut}
                        </span>
        </div>
      </div>
    </c:forEach>
    <c:if test="${consultations.size() > 5}">
      <div style="text-align: center; margin-top: 15px;">
        <a href="${pageContext.request.contextPath}/patient/consultations" class="btn btn-primary">
          Voir toutes les consultations
        </a>
      </div>
    </c:if>
  </div>
</div>
</body>
</html>