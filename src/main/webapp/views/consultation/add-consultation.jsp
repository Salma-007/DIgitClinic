<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Consultation - Clinique Digitale</title>
    <style>
        /* GARDEZ VOTRE CSS EXISTANT MAIS SIMPLIFIEZ-LE TEMPORAIREMENT */
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
            background: #3498db;
            color: white;
            padding: 30px;
            text-align: center;
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
            color: #2c3e50;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ecf0f1;
            border-radius: 8px;
            font-size: 1rem;
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
        }

        .btn-primary {
            background: #3498db;
            color: white;
        }

        .btn-secondary {
            background: #95a5a6;
            color: white;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="form-container">
    <div class="form-header">
        <i class="fas fa-calendar-plus"></i>
        <h1>Nouvelle Consultation</h1>
        <p>Planifier une nouvelle consultation médicale</p>
    </div>

    <div class="form-body">
        <c:if test="${not empty param.error}">
            <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${param.error}</span>
            </div>
        </c:if>

        <c:if test="${not empty param.success}">
            <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                <i class="fas fa-check-circle"></i>
                <span>${param.success}</span>
            </div>
        </c:if>

        <form action="consultations" method="post" id="consultationForm">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="date">Date de consultation *</label>
                <input type="date" id="date" name="date" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="heure">Heure de consultation *</label>
                <select id="heure" name="heure" class="form-control" required>
                    <option value="">Sélectionnez une heure</option>
                    <option value="09:00">09:00 - 09:30</option>
                    <option value="09:30">09:30 - 10:00</option>
                    <option value="10:00">10:00 - 10:30</option>
                    <option value="10:30">10:30 - 11:00</option>
                    <option value="11:00">11:00 - 11:30</option>
                    <option value="11:30">11:30 - 12:00</option>
                    <option value="12:00">12:00 - 12:30</option>
                    <option value="12:30">12:30 - 13:00</option>
                    <option value="13:00">13:00 - 13:30</option>
                    <option value="13:30">13:30 - 14:00</option>
                    <option value="14:00">14:00 - 14:30</option>
                    <option value="14:30">14:30 - 15:00</option>
                    <option value="15:00">15:00 - 15:30</option>
                    <option value="15:30">15:30 - 16:00</option>
                    <option value="16:00">16:00 - 16:30</option>
                    <option value="16:30">16:30 - 17:00</option>
                    <option value="17:00">17:00 - 17:30</option>
                    <option value="17:30">17:30 - 18:00</option>
                    <option value="18:00">18:00 - 18:30</option>
                </select>
            </div>

            <div class="form-group">
                <label for="statut">Statut *</label>
                <select id="statut" name="statut" class="form-control" required>
                    <option value="">Sélectionnez un statut</option>
                    <c:forEach var="statut" items="${statuts}">
                        <option value="${statut}">${statut}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="patientId">Patient *</label>
                <select id="patientId" name="patientId" class="form-control" required>
                    <option value="">Sélectionnez un patient</option>
                    <c:forEach var="patient" items="${patients}">
                        <option value="${patient.id}">
                                ${patient.prenom} ${patient.nom} - ${patient.email}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="docteurId">Médecin *</label>
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
                <label for="salleId">Salle de consultation *</label>
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
                <label for="compteRendu">Compte-rendu (optionnel)</label>
                <textarea id="compteRendu" name="compteRendu" class="form-control"
                          placeholder="Notes médicales, observations..."></textarea>
            </div>

            <div class="form-actions">
                <a href="consultations" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Créer la Consultation
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').min = today;

        document.getElementById('consultationForm').addEventListener('submit', function(e) {
            const date = document.getElementById('date').value;
            const heure = document.getElementById('heure').value;
            const patient = document.getElementById('patientId').value;
            const docteur = document.getElementById('docteurId').value;
            const salle = document.getElementById('salleId').value;

            if (!date || !heure || !patient || !docteur || !salle) {
                alert('Veuillez remplir tous les champs obligatoires.');
                e.preventDefault();
                return;
            }

            if (!confirm('Confirmez-vous la création de cette consultation ?')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>