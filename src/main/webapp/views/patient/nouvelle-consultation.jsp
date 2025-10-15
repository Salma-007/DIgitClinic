<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nouvelle Consultation - DigitClinic</title>
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
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .form-container {
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 800px;
      overflow: hidden;
    }

    .form-header {
      background: var(--primary);
      color: white;
      padding: 30px;
      text-align: center;
    }

    .form-header h1 {
      font-size: 1.8rem;
      margin-bottom: 10px;
    }

    .form-header i {
      font-size: 2.5rem;
      margin-bottom: 15px;
      display: block;
    }

    .form-body {
      padding: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: var(--secondary);
      font-weight: 500;
    }

    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 2px solid #ecf0f1;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s ease;
    }

    .form-control:focus {
      outline: none;
      border-color: var(--primary);
    }

    select.form-control {
      appearance: none;
      background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23333' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>");
      background-repeat: no-repeat;
      background-position: right 15px center;
      background-size: 12px;
    }

    textarea.form-control {
      min-height: 100px;
      resize: vertical;
      font-family: inherit;
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
      transform: translateY(-2px);
    }

    .btn-secondary {
      background: #95a5a6;
      color: white;
    }

    .btn-secondary:hover {
      background: #7f8c8d;
    }

    .form-actions {
      display: flex;
      gap: 15px;
      justify-content: flex-end;
      margin-top: 30px;
    }

    .patient-info {
      background: #e8f4fd;
      padding: 15px;
      border-radius: 8px;
      border-left: 4px solid var(--primary);
      margin-bottom: 20px;
    }

    .info-text {
      background: #fff3cd;
      padding: 12px 15px;
      border-radius: 8px;
      border-left: 4px solid var(--warning);
      margin-bottom: 20px;
      font-size: 0.9rem;
      color: #856404;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px;
    }

    .recap-section {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin-top: 20px;
      display: none;
    }

    .recap-section h4 {
      color: var(--secondary);
      margin-bottom: 15px;
    }

    .recap-content div {
      margin-bottom: 8px;
      padding: 5px 0;
    }

    @media (max-width: 768px) {
      .form-row {
        grid-template-columns: 1fr;
      }

      .form-actions {
        flex-direction: column;
      }
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="form-container">
  <div class="form-header">
    <i class="fas fa-calendar-plus"></i>
    <h1>Nouvelle Consultation</h1>
    <p>Prendre un nouveau rendez-vous médical</p>
  </div>

  <div class="form-body">

    <!-- Messages -->
    <c:if test="${not empty param.error}">
      <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
        <i class="fas fa-exclamation-triangle"></i> ${param.error}
      </div>
    </c:if>

    <div class="info-text">
      <i class="fas fa-info-circle"></i>
      Tous les champs marqués d'un astérisque (*) sont obligatoires.
    </div>

    <form action="${pageContext.request.contextPath}/patient-space" method="post" id="consultationForm">
      <input type="hidden" name="action" value="add-consultation">
      <div class="form-row">
        <div class="form-group">
          <label for="date">
            <i class="fas fa-calendar-day"></i> Date de consultation *
          </label>
          <input
                  type="date"
                  id="date"
                  name="date"
                  class="form-control"
                  required
                  value="<%= java.time.LocalDate.now() %>">
          <small style="color: #7f8c8d; font-size: 0.8rem; margin-top: 5px; display: block;">
            Vous pouvez choisir une date à partir d'aujourd'hui.
          </small>
        </div>

        <script>
          // Définir la date minimale comme aujourd'hui
          document.addEventListener("DOMContentLoaded", () => {
            const dateInput = document.getElementById("date");
            const today = new Date().toISOString().split('T')[0];
            dateInput.min = today;

            // Si le champ est vide, remplir avec aujourd'hui
            if (!dateInput.value) {
              dateInput.value = today;
            }
          });
        </script>


        <div class="form-group">
          <label for="heure">
            <i class="fas fa-clock"></i> Heure de consultation *
          </label>
          <select id="heure" name="heure" class="form-control" required>
            <option value="">Sélectionnez une heure</option>
            <option value="09:00">09:00 - 09:30</option>
            <option value="09:30">09:30 - 10:00</option>
            <option value="10:00">10:00 - 10:30</option>
            <option value="10:30">10:30 - 11:00</option>
            <option value="11:00">11:00 - 11:30</option>
            <option value="11:30">11:30 - 12:00</option>
            <option value="12:00">12:00 - 12:30</option>
            <option value="14:00">14:00 - 14:30</option>
            <option value="14:30">14:30 - 15:00</option>
            <option value="15:00">15:00 - 15:30</option>
            <option value="15:30">15:30 - 16:00</option>
            <option value="16:00">16:00 - 16:30</option>
            <option value="16:30">16:30 - 17:00</option>
            <option value="17:00">17:00 - 17:30</option>
            <option value="17:30">17:30 - 18:00</option>
            <option value="17:30">18:00 - 18:30</option>
          </select>
          <small style="color: #7f8c8d; font-size: 0.8rem; margin-top: 5px; display: block;">
            Horaires d'ouverture: 9h00 - 18h00 (consultations de 30 minutes)
          </small>
        </div>
      </div>

      <div class="form-group">
        <label for="docteurId">
          <i class="fas fa-user-md"></i> Médecin *
        </label>
        <select id="docteurId" name="docteurId" class="form-control" required>
          <option value="">Sélectionnez un médecin</option>
          <c:forEach var="docteur" items="${docteurs}">
            <option value="${docteur.id}">
              Dr. ${docteur.prenom} ${docteur.nom} - ${docteur.specialite}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="salleId">
          <i class="fas fa-door-open"></i> Salle de consultation *
        </label>
        <select id="salleId" name="salleId" class="form-control" required>
          <option value="">Sélectionnez une salle</option>
          <c:forEach var="salle" items="${salles}">
            <option value="${salle.idSalle}">
                ${salle.nomSalle} (Capacité: ${salle.capacite} personnes)
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="notes">
          <i class="fas fa-notes-medical"></i> Notes (optionnel)
        </label>
        <textarea id="notes" name="notes" class="form-control"
                  placeholder="Raison de la consultation, symptômes particuliers, informations importantes..."></textarea>
        <small style="color: #7f8c8d; font-size: 0.8rem; margin-top: 5px; display: block;">
          Ces notes aideront le médecin à mieux préparer votre consultation.
        </small>
      </div>

      <div class="recap-section" id="recapSection">
        <h4><i class="fas fa-clipboard-check"></i> Récapitulatif de la consultation</h4>
        <div class="recap-content" id="recapContent">
          <!-- Le contenu sera rempli par JavaScript -->
        </div>
      </div>

      <div class="form-actions">
        <a href="${pageContext.request.contextPath}/patient-space" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> Annuler
        </a>
        <button type="submit" class="btn btn-primary" id="submitBtn">
          <i class="fas fa-calendar-check"></i> Réserver la Consultation
        </button>
      </div>
    </form>
  </div>
</div>

<script>
  // Variables patient
  const patientPrenom = '${patient.prenom}';
  const patientNom = '${patient.nom}';

  document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.getElementById('date');
    const heureSelect = document.getElementById('heure');
    const docteurSelect = document.getElementById('docteurId');
    const salleSelect = document.getElementById('salleId');
    const recapSection = document.getElementById('recapSection');
    const recapContent = document.getElementById('recapContent');
    const form = document.getElementById('consultationForm');
    const submitBtn = document.getElementById('submitBtn');

    // Date minimale = aujourd'hui
    const today = new Date().toISOString().split('T')[0];
    dateInput.min = today;
    if (!dateInput.value) {
      dateInput.value = today;
    }

    function formatTime(time) {
      if (!time) return '';
      return time.replace(':', 'h');
    }

    // Fonction pour calculer l'heure de fin
    function calculateEndTime(time) {
      if (!time) return '';
      const [hours, minutes] = time.split(':').map(Number);
      const endMinutes = minutes + 30;
      const endHours = hours + Math.floor(endMinutes / 60);
      const finalMinutes = endMinutes % 60;
      return endHours.toString().padStart(2, '0') + ':' + finalMinutes.toString().padStart(2, '0');
    }

    // Fonction pour formater la date
    function formatDate(dateStr) {
      if (!dateStr) return '';
      const date = new Date(dateStr);
      const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
      return date.toLocaleDateString('fr-FR', options);
    }

    // Mettre à jour le récapitulatif
    function updateRecap() {
      const date = dateInput.value;
      const heure = heureSelect.value;
      const docteurText = docteurSelect.options[docteurSelect.selectedIndex] ? docteurSelect.options[docteurSelect.selectedIndex].text : 'Non sélectionné';
      const salleText = salleSelect.options[salleSelect.selectedIndex] ? salleSelect.options[salleSelect.selectedIndex].text : 'Non sélectionné';

      if (date && heure && docteurSelect.value && salleSelect.value) {
        const heureFin = calculateEndTime(heure);
        const dateFormatee = formatDate(date);
        const heureFormatee = formatTime(heure);
        const heureFinFormatee = formatTime(heureFin);

        // Construction manuelle du HTML sans template literals
        recapContent.innerHTML =
                '<div><strong>📅 Date:</strong> ' + dateFormatee + '</div>' +
                '<div><strong>⏰ Horaire:</strong> ' + heureFormatee + ' - ' + heureFinFormatee + '</div>' +
                '<div><strong>👤 Patient:</strong> ' + patientPrenom + ' ' + patientNom + '</div>' +
                '<div><strong>👨‍⚕️ Médecin:</strong> ' + docteurText + '</div>' +
                '<div><strong>🚪 Salle:</strong> ' + salleText + '</div>' +
                '<div><strong>📋 Statut:</strong> <span style="color: #f39c12; font-weight: bold;">Réservée</span></div>' +
                '<div style="margin-top: 10px; padding: 10px; background: #e8f5e8; border-radius: 5px;">' +
                '<i class="fas fa-info-circle"></i> La consultation durera 30 minutes</div>';

        recapSection.style.display = 'block';
      } else {
        recapSection.style.display = 'none';
      }
    }

    // Écouteurs d'événements
    dateInput.addEventListener('change', updateRecap);
    heureSelect.addEventListener('change', updateRecap);
    docteurSelect.addEventListener('change', updateRecap);
    salleSelect.addEventListener('change', updateRecap);

    // Validation du formulaire
    form.addEventListener('submit', function(e) {
      const date = dateInput.value;
      const heure = heureSelect.value;
      const docteur = docteurSelect.value;
      const salle = salleSelect.value;

      if (!date || !heure || !docteur || !salle) {
        alert('Veuillez remplir tous les champs obligatoires.');
        e.preventDefault();
        return;
      }

      const selectedDate = new Date(date);
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      if (selectedDate < today) {
        alert('Veuillez sélectionner une date future.');
        e.preventDefault();
        return;
      }

      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Réservation en cours...';

      const confirmation = confirm('Confirmez-vous la réservation de cette consultation ?\n\nCette action créera une nouvelle consultation avec le statut "Réservée".');

      if (!confirmation) {
        e.preventDefault();
        submitBtn.disabled = false;
        submitBtn.innerHTML = '<i class="fas fa-calendar-check"></i> Réserver la Consultation';
      }
    });

    // Réactiver le bouton
    window.addEventListener('pageshow', function() {
      submitBtn.disabled = false;
      submitBtn.innerHTML = '<i class="fas fa-calendar-check"></i> Réserver la Consultation';
    });

    // Initialiser le récapitulatif
    updateRecap();
  });
</script>
</body>
</html>