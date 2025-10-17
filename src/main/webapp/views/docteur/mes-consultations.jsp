<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mes Consultations - Espace Docteur</title>
  <style>
    :root {
      --primary: #3498db;
      --secondary: #2c3e50;
      --success: #27ae60;
      --danger: #e74c3c;
      --warning: #f39c12;
      --info: #17a2b8;
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

    .btn-success {
      background: var(--success);
      color: white;
    }

    .btn-danger {
      background: var(--danger);
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

    .consultation-time {
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

    /* Styles spécifiques pour les actions */
    .consultation-actions {
      display: flex;
      gap: 10px;
      margin-top: 15px;
      justify-content: flex-end;
      padding-top: 15px;
      border-top: 1px solid #ecf0f1;
    }

    .action-btn {
      padding: 8px 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 5px;
      font-weight: 500;
      transition: all 0.3s ease;
      font-size: 0.9rem;
    }

    .action-btn-primary {
      background: var(--primary);
      color: white;
    }

    .action-btn-success {
      background: var(--success);
      color: white;
    }

    .action-btn-danger {
      background: var(--danger);
      color: white;
    }

    .action-btn-warning {
      background: var(--warning);
      color: white;
    }

    .statut-form {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .statut-select {
      padding: 8px 12px;
      border: 2px solid #ecf0f1;
      border-radius: 6px;
      font-size: 0.9rem;
      background: white;
      cursor: pointer;
    }

    .statut-select:focus {
      outline: none;
      border-color: var(--primary);
    }

    .actions-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 15px;
      padding-top: 15px;
      border-top: 1px solid #ecf0f1;
    }

    .left-actions {
      display: flex;
      gap: 10px;
    }

    .right-actions {
      display: flex;
      gap: 10px;
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
      <p>Gestion de tous vos rendez-vous médicaux</p>
    </div>
    <div>
      <a href="${pageContext.request.contextPath}/doctor-space" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Tableau de Bord
      </a>
      <a href="logout" class="btn btn-danger">
        <i class="fas fa-sign-out-alt"></i> Déconnexion
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

  <div class="consultations-container">
    <c:if test="${empty consultations}">
      <div class="empty-state">
        <i class="fas fa-calendar-times"></i>
        <h3>Aucune consultation</h3>
        <p>Vous n'avez pas encore de consultations programmées</p>
      </div>
    </c:if>

    <c:forEach var="consultation" items="${consultations}">
      <div class="consultation-card">
        <div class="consultation-header">
          <div>
            <div class="consultation-time">
              <i class="fas fa-calendar-alt"></i> ${consultation.date} à ${consultation.heure}
            </div>
            <small style="color: #7f8c8d;">
              Salle: ${consultation.salle.nomSalle}
            </small>
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
            <i class="fas fa-user" style="color: var(--primary);"></i>
            <div>
              <strong>Patient</strong><br>
                ${consultation.patient.prenom} ${consultation.patient.nom}<br>
              <small>${consultation.patient.email}</small>
            </div>
          </div>

          <c:if test="${not empty consultation.compteRendu}">
            <div class="detail-item" style="grid-column: 1 / -1;">
              <i class="fas fa-notes-medical" style="color: var(--warning);"></i>
              <div>
                <strong>Notes du patient</strong><br>
                  ${consultation.compteRendu}
              </div>
            </div>
          </c:if>
        </div>

        <!-- Actions - Modification du statut et Annulation -->
        <c:if test="${consultation.statut != 'ANNULEE' && consultation.statut != 'TERMINEE'}">
          <div class="actions-container">
            <!-- Actions de gauche - Modification du statut -->
            <div class="left-actions">
              <form action="${pageContext.request.contextPath}/doctor-space" method="post" class="statut-form">
                <input type="hidden" name="action" value="update-statut">
                <input type="hidden" name="consultationId" value="${consultation.idConsultation}">

                <select name="statut" class="statut-select">
                  <option value="RESERVEE" ${consultation.statut == 'RESERVEE' ? 'selected' : ''}>Réservée</option>
                  <option value="VALIDEE" ${consultation.statut == 'VALIDEE' ? 'selected' : ''}>Validée</option>
                  <option value="TERMINEE" ${consultation.statut == 'TERMINEE' ? 'selected' : ''}>Terminée</option>
                </select>

                <button type="submit" class="action-btn action-btn-primary">
                  <i class="fas fa-sync-alt"></i> Mettre à jour
                </button>
              </form>
            </div>

            <!-- Actions de droite - Annulation -->
            <div class="right-actions">
              <form action="${pageContext.request.contextPath}/doctor-space" method="post"
                    onsubmit="return confirm('Êtes-vous sûr de vouloir annuler cette consultation ? Cette action est irréversible.')">
                <input type="hidden" name="action" value="cancel-consultation">
                <input type="hidden" name="consultationId" value="${consultation.idConsultation}">
                <button type="submit" class="action-btn action-btn-danger">
                  <i class="fas fa-ban"></i> Annuler la consultation
                </button>
              </form>
            </div>
          </div>
        </c:if>

        <c:if test="${consultation.statut == 'TERMINEE'}">
          <div style="margin-top: 15px; padding: 10px; background: #d4edda; border-radius: 6px; text-align: center;">
            <i class="fas fa-check-circle" style="color: var(--success);"></i>
            <span style="color: var(--success); font-size: 0.9rem;">
              Consultation terminée
            </span>
          </div>
        </c:if>

        <c:if test="${consultation.statut == 'ANNULEE'}">
          <div style="margin-top: 15px; padding: 10px; background: #f8d7da; border-radius: 6px; text-align: center;">
            <i class="fas fa-ban" style="color: var(--danger);"></i>
            <span style="color: var(--danger); font-size: 0.9rem;">
              Consultation annulée
            </span>
          </div>
        </c:if>
      </div>
    </c:forEach>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Animation pour les cartes de consultation
    const consultationCards = document.querySelectorAll('.consultation-card');
    consultationCards.forEach((card, index) => {
      setTimeout(() => {
        card.style.opacity = '0';
        card.style.transform = 'translateX(-20px)';
        card.style.transition = 'all 0.5s ease';

        setTimeout(() => {
          card.style.opacity = '1';
          card.style.transform = 'translateX(0)';
        }, 100);
      }, index * 100);
    });

    const statutForms = document.querySelectorAll('.statut-form');
    statutForms.forEach(form => {
      form.addEventListener('submit', function(e) {
        const select = this.querySelector('select[name="statut"]');
        const newStatut = select.value;

        if (newStatut === 'TERMINEE') {
          if (!confirm('Marquer cette consultation comme terminée ? Cette action est définitive.')) {
            e.preventDefault();
          }
        }
      });
    });

    // Animation pour les boutons
    const actionButtons = document.querySelectorAll('.action-btn');
    actionButtons.forEach(button => {
      button.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-2px)';
        this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.2)';
      });
      button.addEventListener('mouseleave', function() {
        this.style.transform = 'translateY(0)';
        this.style.boxShadow = 'none';
      });
    });
  });
</script>
</body>
</html>