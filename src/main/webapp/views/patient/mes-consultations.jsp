<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mes Consultations - Clinique Digitale</title>
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

    .btn-secondary {
      background: #95a5a6;
      color: white;
    }

    .consultations-container {
      background: white;
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .consultation-card {
      border: 1px solid #ecf0f1;
      border-radius: 10px;
      padding: 20px;
      margin-bottom: 15px;
      transition: box-shadow 0.3s ease;
    }

    .consultation-card:hover {
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .consultation-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .consultation-date {
      font-size: 1.2rem;
      font-weight: bold;
      color: var(--secondary);
    }

    .consultation-status {
      padding: 5px 15px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: bold;
    }

    .status-reserved { background: #f39c12; color: white; }
    .status-confirmed { background: #3498db; color: white; }
    .status-completed { background: #27ae60; color: white; }
    .status-cancelled { background: #e74c3c; color: white; }

    .consultation-details {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px;
      margin-top: 15px;
    }

    .detail-item {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .empty-state {
      text-align: center;
      padding: 40px;
      color: #7f8c8d;
    }

    .empty-state i {
      font-size: 4rem;
      margin-bottom: 20px;
      color: #bdc3c7;
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <!-- En-tête -->
  <div class="header">
    <div>
      <h1>Mes Consultations</h1>
      <p>Historique de tous vos rendez-vous médicaux</p>
    </div>
    <div>
      <a href="${pageContext.request.contextPath}/patient-space" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Retour
      </a>
      <a href="${pageContext.request.contextPath}/patient-space?action=new-consultation" class="btn btn-primary">
        <i class="fas fa-plus"></i> Nouveau RDV
      </a>
    </div>
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

  <!-- Liste des consultations -->
  <div class="consultations-container">
    <c:if test="${empty consultations}">
      <div class="empty-state">
        <i class="fas fa-calendar-times"></i>
        <h3>Aucune consultation</h3>
        <p>Vous n'avez pas encore de rendez-vous médical</p>
        <a href="${pageContext.request.contextPath}/patient/new-consultation" class="btn btn-primary" style="margin-top: 20px;">
          <i class="fas fa-plus"></i> Prendre mon premier RDV
        </a>
      </div>
    </c:if>

    <c:forEach var="consultation" items="${consultations}">
      <div class="consultation-card">
        <div class="consultation-header">
          <div class="consultation-date">
            <i class="fas fa-calendar-alt"></i>
              ${consultation.date} à ${consultation.heure}
          </div>
          <div class="consultation-status
                            <c:choose>
                                <c:when test="${consultation.statut == 'RESERVEE'}">status-reserved</c:when>
                                <c:when test="${consultation.statut == 'VALIDEE'}">status-confirmed</c:when>
                                <c:when test="${consultation.statut == 'TERMINEE'}">status-completed</c:when>
                                <c:when test="${consultation.statut == 'ANNULEE'}">status-cancelled</c:when>
                            </c:choose>">
              ${consultation.statut}
          </div>
        </div>

        <div class="consultation-details">
          <div class="detail-item">
            <i class="fas fa-user-md" style="color: var(--primary);"></i>
            <div>
              <strong>Médecin</strong><br>
              Dr. ${consultation.docteur.prenom} ${consultation.docteur.nom}<br>
              <small>${consultation.docteur.specialite}</small>
            </div>
          </div>

          <div class="detail-item">
            <i class="fas fa-door-open" style="color: var(--success);"></i>
            <div>
              <strong>Salle</strong><br>
                ${consultation.salle.nomSalle}<br>
              <small>Capacité: ${consultation.salle.capacite} pers.</small>
            </div>
          </div>

          <c:if test="${not empty consultation.compteRendu}">
            <div class="detail-item" style="grid-column: 1 / -1;">
              <i class="fas fa-notes-medical" style="color: var(--warning);"></i>
              <div>
                <strong>Notes</strong><br>
                  ${consultation.compteRendu}
              </div>
            </div>
          </c:if>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
</body>
</html>