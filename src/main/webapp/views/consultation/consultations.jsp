<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Consultations - Clinique Digitale</title>
    <style>
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

        .stat-card.total { border-top: 4px solid #3498db; }
        .stat-card.reservees { border-top: 4px solid #f39c12; }
        .stat-card.validees { border-top: 4px solid #17a2b8; }
        .stat-card.terminees { border-top: 4px solid #27ae60; }
        .stat-card.annulees { border-top: 4px solid #e74c3c; }

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

        .btn-info {
            background: #17a2b8;
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
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .badge-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .badge-warning { background: #fff3cd; color: #856404; border: 1px solid #ffeaa7; }
        .badge-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .badge-primary { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .badge-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .badge-secondary { background: #e2e3e5; color: #383d41; border: 1px solid #d6d8db; }

        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.8rem;
        }

        .consultation-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .consultation-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .consultation-details {
            flex: 1;
        }

        .consultation-title {
            font-weight: 600;
            color: var(--secondary);
            font-size: 1rem;
            margin-bottom: 4px;
        }

        .consultation-meta {
            display: flex;
            gap: 15px;
            font-size: 0.85rem;
            color: #7f8c8d;
        }

        .consultation-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .consultation-participants {
            margin-top: 8px;
        }

        .participant-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            background: #f8f9fa;
            color: #6c757d;
            border: 1px solid #e9ecef;
        }

        .date-badge {
            background: #e8f4fd;
            color: #0d6efd;
            padding: 6px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
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

            .consultation-info {
                flex-direction: column;
                align-items: flex-start;
            }

            .consultation-meta {
                flex-direction: column;
                gap: 5px;
            }

            .actions {
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
            <li><a href="dashboard-admin"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="patients"><i class="fas fa-user-injured"></i> Patients</a></li>
            <li><a href="docteurs"><i class="fas fa-user-md"></i> Médecins</a></li>
            <li><a href="departements"><i class="fas fa-building"></i> Départements</a></li>
            <li><a href="consultations" class="active"><i class="fas fa-calendar-check"></i> Consultations</a></li>
            <li><a href="salles"><i class="fas fa-door-open"></i> Salles</a></li>
            <li><a href="statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
            <li><a href="logout" style="color: var(--danger);"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
        </ul>
    </nav>

    <!-- Contenu principal -->
    <main class="main-content">
        <!-- Header -->
        <div class="header">
            <h2><i class="fas fa-calendar-check"></i> Gestion des Consultations</h2>
            <div class="user-info">
                <div class="user-avatar">A</div>
                <span>Administrateur</span>
            </div>
        </div>

        <!-- Cartes de statistiques -->
        <div class="stats-grid">
            <div class="stat-card total">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalConsultations}">${stats.totalConsultations}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Consultations Total</span>
                <i class="fas fa-calendar-check" style="font-size: 2rem; color: #3498db; margin-top: 10px;"></i>
            </div>
            <div class="stat-card reservees">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.consultationsReservees}">${stats.consultationsReservees}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Réservées</span>
                <i class="fas fa-clock" style="font-size: 2rem; color: #f39c12; margin-top: 10px;"></i>
            </div>
            <div class="stat-card validees">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.consultationsValidees}">${stats.consultationsValidees}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Validées</span>
                <i class="fas fa-check-circle" style="font-size: 2rem; color: #17a2b8; margin-top: 10px;"></i>
            </div>
            <div class="stat-card terminees">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.consultationsTerminees}">${stats.consultationsTerminees}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Terminées</span>
                <i class="fas fa-flag-checkered" style="font-size: 2rem; color: #27ae60; margin-top: 10px;"></i>
            </div>
        </div>

        <!-- Liste des consultations -->
        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-list"></i> Liste des Consultations</h3>
                <a href="consultations?action=new" class="btn btn-primary" style="margin-top: 10px;">
                    <i class="fas fa-plus"></i> Nouvelle Consultation
                </a>
            </div>

            <c:if test="${empty consultations}">
                <div style="text-align: center; padding: 40px; color: #7f8c8d;">
                    <i class="fas fa-calendar-check" style="font-size: 3rem; margin-bottom: 20px;"></i>
                    <p>Aucune consultation trouvée dans la base de données.</p>
                    <a href="consultations?action=new" class="btn btn-primary" style="margin-top: 10px;">
                        <i class="fas fa-plus"></i> Créer la première consultation
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty consultations}">
                <table>
                    <thead>
                    <tr>
                        <th>Consultation</th>
                        <th>Date & Heure</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="consultation" items="${consultations}">
                        <tr>
                            <td>
                                <div class="consultation-info">
                                    <div class="consultation-icon" style="background:
                                    <c:choose>
                                    <c:when test="${consultation.statut == 'TERMINEE'}">#27ae60</c:when>
                                    <c:when test="${consultation.statut == 'VALIDEE'}">#17a2b8</c:when>
                                    <c:when test="${consultation.statut == 'RESERVEE'}">#f39c12</c:when>
                                    <c:when test="${consultation.statut == 'ANNULEE'}">#e74c3c</c:when>
                                    <c:otherwise>#3498db</c:otherwise>
                                    </c:choose>;">
                                        <i class="fas
                                            <c:choose>
                                                <c:when test="${consultation.statut == 'TERMINEE'}">fa-flag-checkered</c:when>
                                                <c:when test="${consultation.statut == 'VALIDEE'}">fa-check-circle</c:when>
                                                <c:when test="${consultation.statut == 'RESERVEE'}">fa-clock</c:when>
                                                <c:when test="${consultation.statut == 'ANNULEE'}">fa-times-circle</c:when>
                                                <c:otherwise>fa-calendar-check</c:otherwise>
                                            </c:choose>">
                                        </i>
                                    </div>
                                    <div class="consultation-details">
                                        <div class="consultation-title">
                                            Consultation de Dr: ${consultation.docteur.nom}
                                        </div>
                                        <div class="consultation-meta">
                                            <div class="consultation-meta-item">
                                                <i class="fas fa-user-injured"></i>
                                                <span>${consultation.patient.prenom} ${consultation.patient.nom}</span>
                                            </div>
                                            <div class="consultation-meta-item">
                                                <i class="fas fa-user-md"></i>
                                                <span>Dr. ${consultation.docteur.prenom} ${consultation.docteur.nom}</span>
                                            </div>
                                        </div>
                                        <div class="consultation-participants">
                                            <span class="participant-badge">
                                                <i class="fas fa-door-open"></i> ${consultation.salle.nomSalle}
                                            </span>
                                            <c:if test="${not empty consultation.compteRendu}">
                                                <span class="participant-badge" style="background: #e8f5e8; color: #2e7d32;">
                                                    <i class="fas fa-file-medical"></i> Compte-rendu
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="date-badge">
                                    <i class="fas fa-calendar-alt"></i>
                                        ${consultation.date}
                                    <i class="fas fa-clock" style="margin-left: 8px;"></i>
                                        ${consultation.heure}
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${consultation.statut == 'RESERVEE'}">
                                        <span class="badge badge-warning">
                                            <i class="fas fa-clock"></i> Réservée
                                        </span>
                                    </c:when>
                                    <c:when test="${consultation.statut == 'VALIDEE'}">
                                        <span class="badge badge-info">
                                            <i class="fas fa-check-circle"></i> Validée
                                        </span>
                                    </c:when>
                                    <c:when test="${consultation.statut == 'TERMINEE'}">
                                        <span class="badge badge-success">
                                            <i class="fas fa-flag-checkered"></i> Terminée
                                        </span>
                                    </c:when>
                                    <c:when test="${consultation.statut == 'ANNULEE'}">
                                        <span class="badge badge-danger">
                                            <i class="fas fa-times-circle"></i> Annulée
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-secondary">
                                            <i class="fas fa-question-circle"></i> ${consultation.statut}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="consultations?action=details&id=${consultation.idConsultation}"
                                       class="btn btn-info" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="consultations?action=edit&id=${consultation.idConsultation}"
                                       class="btn btn-primary" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="consultations?action=updateStatus&id=${consultation.idConsultation}"
                                       class="btn btn-warning" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-sync-alt"></i>
                                    </a>
                                    <a href="consultations?action=delete&id=${consultation.idConsultation}"
                                       class="btn btn-danger" style="padding: 5px 10px; font-size: 0.8rem;"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette consultation ?')">
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

        <!-- Consultations du jour -->
        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-calendar-day"></i> Consultations d'Aujourd'hui</h3>
            </div>
            <div style="text-align: center; padding: 20px; color: #7f8c8d;">

                <jsp:useBean id="now" class="java.util.Date" />
                <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayString"/>

                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 15px; margin-top: 20px;">
                    <c:set var="hasConsultationsToday" value="false" />
                    <c:forEach var="consultation" items="${consultations}">
                        <c:if test="${consultation.date.toString() == todayString}">
                            <c:set var="hasConsultationsToday" value="true" />
                            <div style="background: #f8f9fa; padding: 15px; border-radius: 8px; border-left: 4px solid
                            <c:choose>
                            <c:when test="${consultation.statut == 'TERMINEE'}">#27ae60</c:when>
                            <c:when test="${consultation.statut == 'VALIDEE'}">#17a2b8</c:when>
                            <c:when test="${consultation.statut == 'RESERVEE'}">#f39c12</c:when>
                            <c:when test="${consultation.statut == 'ANNULEE'}">#e74c3c</c:when>
                            <c:otherwise>#3498db</c:otherwise>
                            </c:choose>;">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                                    <strong style="color: var(--secondary);">${consultation.heure}</strong>
                                    <span class="badge
                                        <c:choose>
                                            <c:when test="${consultation.statut == 'RESERVEE'}">badge-warning</c:when>
                                            <c:when test="${consultation.statut == 'VALIDEE'}">badge-info</c:when>
                                            <c:when test="${consultation.statut == 'TERMINEE'}">badge-success</c:when>
                                            <c:when test="${consultation.statut == 'ANNULEE'}">badge-danger</c:when>
                                            <c:otherwise>badge-secondary</c:otherwise>
                                        </c:choose>"
                                          style="font-size: 0.7rem;">
                                            ${consultation.statut}
                                    </span>
                                </div>
                                <div style="font-size: 0.9rem;">
                                    <div><strong>Patient:</strong> ${consultation.patient.prenom} ${consultation.patient.nom}</div>
                                    <div><strong>Médecin:</strong> Dr. ${consultation.docteur.prenom} ${consultation.docteur.nom}</div>
                                    <div><strong>Salle:</strong> ${consultation.salle.nomSalle}</div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not hasConsultationsToday}">
                        <div style="grid-column: 1 / -1; text-align: center; padding: 20px; color: #7f8c8d;">
                            <i class="fas fa-calendar-times" style="font-size: 2rem; margin-bottom: 10px;"></i>
                            <p>Aucune consultation prévue pour aujourd'hui</p>
                        </div>
                    </c:if>
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
            if (linkPage === currentPage || (currentPage === '' && linkPage === 'consultations')) {
                link.classList.add('active');
            }
        });
    });
</script>
</body>
</html>