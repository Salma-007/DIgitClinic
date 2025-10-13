<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - Clinique Digitale</title>
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
            justify-content: space-between; /* CORRIGÉ : between → space-between */
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

        /* Cartes de statistiques */
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
        .stat-card.doctors { border-top: 4px solid #27ae60; }
        .stat-card.consultations { border-top: 4px solid #e74c3c; }
        .stat-card.departments { border-top: 4px solid #f39c12; }

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

        /* Tableau */
        .content-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 20px;
        }

        .table-header {
            display: flex;
            justify-content: space-between; /* CORRIGÉ : between → space-between */
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

        /* Responsive */
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
            <li><a href="dashboard-admin.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="patients"><i class="fas fa-user-injured"></i> Patients</a></li>
            <li><a href="docteurs"><i class="fas fa-user-md"></i> Médecins</a></li>
            <li><a href="departements"><i class="fas fa-building"></i> Départements</a></li>
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
            <h2><i class="fas fa-tachometer-alt"></i> Tableau de Bord Administrateur</h2>
            <div class="user-info">
                <div class="user-avatar">A</div>
                <span>Administrateur</span>
            </div>
        </div>

        <!-- Cartes de statistiques -->
        <div class="stats-grid">
            <div class="stat-card patients">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalPatients}">${stats.totalPatients}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Patients</span>
                <i class="fas fa-user-injured" style="font-size: 2rem; color: skyblue; margin-top: 10px;"></i>
            </div>
            <div class="stat-card doctors">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalDocteurs}">${stats.totalDocteurs}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Médecins</span>
                <i class="fas fa-user-md" style="font-size: 2rem; color: #27ae60; margin-top: 10px;"></i>
            </div>
            <div class="stat-card consultations">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalConsultations}">${stats.totalConsultations}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Consultations</span>
                <i class="fas fa-calendar-check" style="font-size: 2rem; color: #e74c3c; margin-top: 10px;"></i>
            </div>
            <div class="stat-card departments">
                <span class="stat-number">
                    <c:choose>
                        <c:when test="${not empty stats.totalDepartements}">${stats.totalDepartements}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </span>
                <span class="stat-label">Départements</span>
                <i class="fas fa-building" style="font-size: 2rem; color: #f39c12; margin-top: 10px;"></i>
            </div>
        </div>

        <!-- Liste des patients -->
        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-user-injured"></i> Liste des Patients</h3>
                <a href="add-patient.jsp" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nouveau Patient
                </a>
            </div>

            <!-- SUPPRIMEZ TOUTE RÉFÉRENCE À ${patients} DIRECTEMENT -->

            <c:if test="${empty patients}">
                <div style="text-align: center; padding: 40px; color: #7f8c8d;">
                    <i class="fas fa-user-injured" style="font-size: 3rem; margin-bottom: 20px;"></i>
                    <p>Aucun patient trouvé dans la base de données.</p>
                    <a href="add-patient.jsp" class="btn btn-primary" style="margin-top: 10px;">
                        <i class="fas fa-plus"></i> Ajouter le premier patient
                    </a>
                </div>
            </c:if>

            <c:if test="${not empty patients}">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom Complet</th>
                        <th>Email</th>
                        <th>Poids/Taille</th>
                        <th>Consultations</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="patient" items="${patients}">
                        <tr>
                            <td><strong>#${patient.id}</strong></td>
                            <td>
                                <div style="font-weight: 500;">
                                    <c:choose>
                                        <c:when test="${not empty patient.prenom and not empty patient.nom}">
                                            ${patient.prenom} ${patient.nom}
                                        </c:when>
                                        <c:otherwise>
                                            Nom non défini
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <small style="color: #7f8c8d;">
                                    <c:if test="${not empty patient.email}">${patient.email}</c:if>
                                    <c:if test="${empty patient.email}">Email non défini</c:if>
                                </small>
                            </td>
                            <td>
                                <c:if test="${not empty patient.email}">${patient.email}</c:if>
                                <c:if test="${empty patient.email}">-</c:if>
                            </td>
                            <td>
                                <span class="badge">
                                    <c:if test="${not empty patient.poid}">${patient.poid} kg</c:if>
                                    <c:if test="${empty patient.poid}">0 kg</c:if>
                                </span>
                                <span class="badge">
                                    <c:if test="${not empty patient.taille}">${patient.taille} m</c:if>
                                    <c:if test="${empty patient.taille}">0 m</c:if>
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-success">
                                    <c:choose>
                                        <c:when test="${not empty patient.consultations}">
                                            ${patient.consultations.size()} consult.
                                        </c:when>
                                        <c:otherwise>
                                            0 consult.
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="patients?action=edit&id=${patient.id}" class="btn btn-primary" style="padding: 5px 10px; font-size: 0.8rem;">
                                        <i class="fas fa-edit"></i>
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

        <!-- Dernières consultations -->
        <div class="content-card">
            <div class="table-header">
                <h3><i class="fas fa-history"></i> Consultations Récentes</h3>
                <a href="consultations" class="btn btn-primary">Voir Tout</a>
            </div>
            <div style="text-align: center; padding: 20px; color: #7f8c8d;">
                <i class="fas fa-calendar-check" style="font-size: 2rem; margin-bottom: 10px;"></i>
                <p>Aucune consultation récente</p>
            </div>
        </div>
    </main>
</div>

<script>
    // Script pour le menu actif
    document.addEventListener('DOMContentLoaded', function() {
        const currentPage = window.location.pathname.split('/').pop();
        const navLinks = document.querySelectorAll('.nav-links a');

        navLinks.forEach(link => {
            const linkPage = link.getAttribute('href');
            if (linkPage === currentPage || (currentPage === '' && linkPage === 'dashboard-admin.jsp')) {
                link.classList.add('active');
            }
        });
    });
</script>
</body>
</html>