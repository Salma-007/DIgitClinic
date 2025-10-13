<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des Patients</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h1>🏥 Liste des Patients</h1>

<c:if test="${empty patients}">
    <p style="color: red;">Aucun patient trouvé dans la base de données.</p>
    <p>Vérifiez votre configuration Hibernate.</p>
</c:if>


<c:if test="${not empty patients}">
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Poids</th>
            <th>Taille</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="patient" items="${patients}">
            <tr>
                <td>${patient.id}</td>
                <td>${patient.nom}</td>
                <td>${patient.prenom}</td>
                <td>${patient.email}</td>
                <td>${patient.poid} kg</td>
                <td>${patient.taille} m</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

<br>
<a href="add-patient.jsp">➕ Ajouter un patient</a>
</body>
</html>