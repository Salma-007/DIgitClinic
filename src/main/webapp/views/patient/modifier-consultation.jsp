<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Consultation - Clinique Digitale</title>
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
            max-width: 800px;
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

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .form-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--secondary);
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

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .current-info {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .current-info h3 {
            color: var(--secondary);
            margin-bottom: 15px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding-bottom: 8px;
            border-bottom: 1px solid #e9ecef;
        }

        .info-label {
            font-weight: 500;
            color: var(--dark);
        }

        .info-value {
            color: var(--secondary);
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <!-- En-tête -->
    <div class="header">
        <div>
            <h1>Modifier la Consultation</h1>
            <p>Modifiez les détails de votre rendez-vous médical</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/patient-space?action=consultations" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour
            </a>
        </div>
    </div>

    <c:if test="${not empty param.error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-triangle"></i> ${param.error}
        </div>
    </c:if>

    <div class="current-info">
        <h3><i class="fas fa-info-circle"></i> Consultation actuelle</h3>
        <div class="info-item">
            <span class="info-label">Statut:</span>
            <span class="info-value">${consultation.statut}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Date actuelle:</span>
            <span class="info-value">${consultation.date} à ${consultation.heure}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Médecin actuel:</span>
            <span class="info-value">Dr. ${consultation.docteur.prenom} ${consultation.docteur.nom}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Salle actuelle:</span>
            <span class="info-value">${consultation.salle.nomSalle}</span>
        </div>
    </div>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/patient-space" method="post">
            <input type="hidden" name="action" value="update-consultation">
            <input type="hidden" name="consultationId" value="${consultation.idConsultation}">

            <div class="form-row">
                <div class="form-group">
                    <label for="date"><i class="fas fa-calendar-alt"></i> Date</label>
                    <input type="date" id="date" name="date" value="${consultation.date}" class="form-control" required
                           min="<%= java.time.LocalDate.now() %>">
                </div>

                <div class="form-group">
                    <label for="heure"><i class="fas fa-clock"></i> Heure</label>
                    <input type="time" id="heure" name="heure" value="${consultation.heure}" class="form-control" required
                           step="1800" min="09:00" max="18:00">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="docteurId"><i class="fas fa-user-md"></i> Médecin</label>
                    <select id="docteurId" name="docteurId" class="form-control" required>
                        <option value="">Sélectionnez un médecin</option>
                        <c:forEach var="docteur" items="${docteurs}">
                            <option value="${docteur.id}"
                                ${docteur.id == consultation.docteur.id ? 'selected' : ''}>
                                Dr. ${docteur.prenom} ${docteur.nom} - ${docteur.specialite}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="salleId"><i class="fas fa-door-open"></i> Salle</label>
                    <select id="salleId" name="salleId" class="form-control" required>
                        <option value="">Sélectionnez une salle</option>
                        <c:forEach var="salle" items="${salles}">
                            <option value="${salle.idSalle}"
                                ${salle.idSalle == consultation.salle.idSalle ? 'selected' : ''}>
                                    ${salle.nomSalle} (Capacité: ${salle.capacite})
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="compteRendu"><i class="fas fa-notes-medical"></i> Notes médicales</label>
                <textarea id="compteRendu" name="compteRendu" class="form-control" rows="4"
                          placeholder="Décrivez vos symptômes ou notes supplémentaires...">${consultation.compteRendu}</textarea>
            </div>

            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/patient-space?action=consultations" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Enregistrer les modifications
                </button>
            </div>
        </form>

        <c:if test="${consultation.statut != 'ANNULEE' && consultation.statut != 'TERMINEE'}">
            <div style="margin-top: 30px; padding-top: 20px; border-top: 2px solid #ecf0f1;">
                <form action="${pageContext.request.contextPath}/patient-space" method="post"
                      onsubmit="return confirm('Êtes-vous sûr de vouloir annuler cette consultation ?')">
                    <input type="hidden" name="action" value="cancel-consultation">
                    <input type="hidden" name="consultationId" value="${consultation.idConsultation}">
                    <button type="submit" class="btn btn-danger" style="width: 100%;">
                        <i class="fas fa-ban"></i> Annuler la consultation
                    </button>
                </form>
            </div>
        </c:if>
    </div>
</div>

<script>
    document.getElementById('date').addEventListener('change', function() {
        const selectedDate = new Date(this.value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (selectedDate < today) {
            alert('Impossible de sélectionner une date passée');
            this.value = '';
        }
    });

    document.getElementById('heure').addEventListener('change', function() {
        const time = this.value;
        const [hours, minutes] = time.split(':').map(Number);

        if ((minutes !== 0 && minutes !== 30) || hours < 9 || hours > 18) {
            alert('Les consultations doivent être entre 9h00 et 18h00, à l\'heure ou à la demi-heure');
            this.value = '';
        }
    });
</script>
</body>
</html>