<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Patients - Clinique Digitale</title>
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

        .stat-card.patients { border-top: 4px solid #3498db; }
        .stat-card.actifs { border-top: 4px solid #27ae60; }
        .stat-card.nouveaux { border-top: 4px solid #e74c3c; }
        .stat-card.consultations { border-top: 4px solid #f39c12; }

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
        .badge-purple { background: #e2e3f5; color: #383d81; border: 1px solid #d6d8f0; }
        .badge-orange { background: #ffeaa7; color: #e17055; border: 1px solid #ffd8a6; }
        .badge-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }

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

        .patient-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
            margin-right: 15px;
            font-weight: bold;
        }

        .patient-info {
            display: flex;
            align-items: center;
        }

        .patient-name {
            font-weight: 600;
            color: var(--secondary);
            font-size: 1rem;
        }

        .patient-email {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        /* NOUVEAU STYLE POUR LES INFORMATIONS PHYSIQUES */
        .patient-physique {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            border-left: 4px solid var(--primary);
        }

        .physique-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 8px;
        }

        .physique-item {
            display: flex;
            flex-direction: column;
        }

        .physique-label {
            font-size: 0.75rem;
            color: #7f8c8d;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .physique-value {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--secondary);
        }

        .imc-container {
            margin-top: 8px;
            padding-top: 8px;
            border-top: 1px solid #e9ecef;
        }

        .imc-label {
            font-size: 0.75rem;
            color: #7f8c8d;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .imc-value {
            font-size: 0.85rem;
            font-weight: 600;
        }

        /* Style amélioré pour les badges IMC */
        .imc-badge {
            padding: 6px 10px;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            margin-top: 4px;
        }

        .imc-badge.underweight { background: #e3f2fd; color: #1565c0; border: 1px solid #bbdefb; }
        .imc-badge.normal { background: #e8f5e8; color: #2e7d32; border: 1px solid #c8e6c9; }
        .imc-badge.overweight { background: #fff3e0; color: #ef6c00; border: 1px solid #ffe0b2; }
        .imc-badge.obese { background: #ffebee; color: #c62828; border: 1px solid #ffcdd2; }

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

            .patient-info {
                flex-direction: column;
                align-items: flex-start;
            }

            .patient-avatar {
                margin-right: 0;
                margin-bottom: 10px;
            }

            .physique-grid {
                grid-template-columns: 1fr;
                gap: 8px;
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
            <li><a href="patients" class="active"><i class="fas fa-user-injured"></i> Patients</a></li>
            <li><a href="docteurs"><i class="fas fa-user-md"></i> Médecins</a></li>
            <li><a href="departements"><i class="fas fa-building"></i> Départements</a></li>
            <li><a href="consultations"><i class="fas fa-calendar-check"></i> Consultations</a></li>
            <li><a href="salles"><i class="fas fa-door-open"></i> Salles</a></li>
            <li><a href="statistiques"><i class="fas fa-chart-bar"></i> Statistiques</a></li>
            <li><a href="logout" style="color: var(--danger);"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <!-- Header -->
        <div class="header">
            <h2><i class="fas fa-user-injured"></i> Gestion des Patients</h2>
            <div class="user-info">
                <div class="user-avatar">A</div>
                <span>admin</span>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card patients">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalPatients}">${stats.totalPatients}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Patients Total</span>
                <i class="fas fa-user-injured" style="font-size: 2rem; color: #3498db; margin-top: 10px;"></i>
            </div>
            <div class="stat-card actifs">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.patientsActifs}">${stats.patientsActifs}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Patients Actifs</span>
                <i class="fas fa-check-circle" style="font-size: 2rem; color: #27ae60; margin-top: 10px;"></i>
            </div>
            <div class="stat-card nouveaux">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.nouveauxPatients}">${stats.nouveauxPatients}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Nouveaux Patients</span>
                <i class="fas fa-user-plus" style="font-size: 2rem; color: #e74c3c; margin-top: 10px;"></i>
            </div>
            <div class="stat-card consultations">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.consultationsTotal}">${stats.consultationsTotal}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Consultations</span>
                <i class="fas fa-calendar-check" style="font-size: 2rem; color: #f39c12; margin-top: 10px;"></i>
            </div>
        </div>

        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-list"></i> Liste des Patients</h3>
                <a href="patients?action=new" class="btn btn-primary" style="margin-top: 10px;">
                    <i class="fas fa-plus"></i> Nouveau Patient
                </a>
            </div>

            <c:if test="${empty patients}">
                <div style="text-align: center; padding: 40px; color: #7f8c8d;">
                    <i class="fas fa-user-injured" style="font-size: 3rem; margin-bottom: 20px;"></i>
                    <p>Aucun patient trouvé dans la base de données.</p>
                    <a href="patients?action=new" class="btn btn-primary" style="margin-top: 10px;">
                        <i class="fas fa-plus"></i> Créer le premier patient
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty patients}">
                <table>
                    <thead>
                    <tr>
                        <th>Patient</th>
                        <th>Informations Physiques</th>
                        <th>Consultations</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="patient" items="${patients}">
                        <tr>
                            <td>
                                <div class="patient-info">
                                    <div class="patient-avatar" style="background:
                                    <c:choose>
                                    <c:when test="${patient.consultationsCount > 5}">#e74c3c</c:when>
                                    <c:when test="${patient.consultationsCount > 2}">#3498db</c:when>
                                    <c:otherwise>#f39c12</c:otherwise>
                                    </c:choose>;">
                                            ${patient.prenom.charAt(0)}${patient.nom.charAt(0)}
                                    </div>
                                    <div>
                                        <div class="patient-name">${patient.prenom} ${patient.nom}</div>
                                        <div class="patient-email">${patient.email}</div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="patient-physique">
                                    <div class="physique-grid">
                                        <div class="physique-item">
                                            <span class="physique-label">Poids</span>
                                            <span class="physique-value">${patient.poid} kg</span>
                                        </div>
                                        <div class="physique-item">
                                            <span class="physique-label">Taille</span>
                                            <span class="physique-value">${patient.taille} cm</span>
                                        </div>
                                    </div>
                                    <div class="imc-container">
                                        <div class="imc-label">Indice de Masse Corporelle</div>
                                        <c:set var="imc" value="${patient.poid / ((patient.taille/100) * (patient.taille/100))}" />
                                        <c:set var="imcFormatted" value="${String.format('%.1f', imc)}" />
                                        <c:choose>
                                            <c:when test="${imc < 18.5}">
                                                <div class="imc-badge underweight">
                                                    <i class="fas fa-weight"></i> Sous-poids (${imcFormatted})
                                                </div>
                                            </c:when>
                                            <c:when test="${imc < 25}">
                                                <div class="imc-badge normal">
                                                    <i class="fas fa-check-circle"></i> Normal (${imcFormatted})
                                                </div>
                                            </c:when>
                                            <c:when test="${imc < 30}">
                                                <div class="imc-badge overweight">
                                                    <i class="fas fa-exclamation-triangle"></i> Surpoids (${imcFormatted})
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="imc-badge obese">
                                                    <i class="fas fa-heartbeat"></i> Obésité (${imcFormatted})
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="badge badge-orange">
                                    <i class="fas fa-calendar-check"></i>
                                    ${patient.consultationsCount} consultations
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-success">
                                    <i class="fas fa-check-circle"></i> Actif
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="patients?action=edit&id=${patient.id}" class="btn btn-primary" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="patients?action=consultations&id=${patient.id}" class="btn btn-success" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-calendar-alt"></i>
                                    </a>
                                    <a href="patients?action=details&id=${patient.id}" class="btn btn-warning" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-info-circle"></i>
                                    </a>
                                    <a href="patients?action=delete&id=${patient.id}" class="btn btn-danger" style="padding: 5px 10px; font-size: 0.8rem;"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient ?')">
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

        <!-- Statistiques des patients -->
        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-chart-pie"></i> Profil des Patients</h3>
            </div>
            <div style="text-align: center; padding: 20px; color: #7f8c8d;">
                <i class="fas fa-chart-bar" style="font-size: 2rem; margin-bottom: 10px;"></i>
                <p>Répartition des patients selon leur IMC</p>
                <div style="display: flex; justify-content: center; gap: 20px; margin-top: 20px; flex-wrap: wrap;">
                    <div style="text-align: center;">
                        <div style="background: #27ae60; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
                            <i class="fas fa-weight"></i>
                        </div>
                        <div>Normal</div>
                        <small>
                            <c:set var="normalCount" value="0" />
                            <c:forEach var="patient" items="${patients}">
                                <c:set var="imc" value="${patient.poid / ((patient.taille/100) * (patient.taille/100))}" />
                                <c:if test="${imc >= 18.5 && imc < 25}">
                                    <c:set var="normalCount" value="${normalCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${normalCount} patients
                        </small>
                    </div>
                    <div style="text-align: center;">
                        <div style="background: #f39c12; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
                            <i class="fas fa-weight-hanging"></i>
                        </div>
                        <div>Surpoids</div>
                        <small>
                            <c:set var="surpoidsCount" value="0" />
                            <c:forEach var="patient" items="${patients}">
                                <c:set var="imc" value="${patient.poid / ((patient.taille/100) * (patient.taille/100))}" />
                                <c:if test="${imc >= 25 && imc < 30}">
                                    <c:set var="surpoidsCount" value="${surpoidsCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${surpoidsCount} patients
                        </small>
                    </div>
                    <div style="text-align: center;">
                        <div style="background: #e74c3c; color: white; width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px;">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <div>Obésité</div>
                        <small>
                            <c:set var="obesiteCount" value="0" />
                            <c:forEach var="patient" items="${patients}">
                                <c:set var="imc" value="${patient.poid / ((patient.taille/100) * (patient.taille/100))}" />
                                <c:if test="${imc >= 30}">
                                    <c:set var="obesiteCount" value="${obesiteCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${obesiteCount} patients
                        </small>
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
            if (linkPage === currentPage || (currentPage === '' && linkPage === 'patients')) {
                link.classList.add('active');
            }
        });
    });
</script>
</body>
</html>