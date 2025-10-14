<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modifier Médecin - Clinique Digitale</title>
  <style>
    /* Mêmes styles que add-docteur.jsp */
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
      max-width: 600px;
      overflow: hidden;
    }

    .form-header {
      background: var(--warning);
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

    .alert {
      padding: 15px;
      border-radius: 8px;
      margin-bottom: 20px;
    }

    .alert-success {
      background: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .alert-danger {
      background: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px;
    }

    @media (max-width: 768px) {
      .form-row {
        grid-template-columns: 1fr;
      }
    }
  </style>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="form-container">
  <div class="form-header">
    <i class="fas fa-edit"></i>
    <h1>Modifier le Médecin</h1>
    <p>Modifier les informations du médecin</p>
  </div>

  <div class="form-body">
    <c:if test="${not empty param.error}">
      <div class="alert alert-danger">
        <i class="fas fa-exclamation-triangle"></i> ${param.error}
      </div>
    </c:if>

    <form action="docteurs" method="post">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="id" value="${docteur.id}">

      <div class="form-row">
        <div class="form-group">
          <label for="nom"><i class="fas fa-user"></i> Nom</label>
          <input type="text" id="nom" name="nom" class="form-control"
                 value="${docteur.nom}" required>
        </div>

        <div class="form-group">
          <label for="prenom"><i class="fas fa-user"></i> Prénom</label>
          <input type="text" id="prenom" name="prenom" class="form-control"
                 value="${docteur.prenom}" required>
        </div>
      </div>

      <div class="form-group">
        <label for="email"><i class="fas fa-envelope"></i> Email</label>
        <input type="email" id="email" name="email" class="form-control"
               value="${docteur.email}" required>
      </div>

      <div class="form-group">
        <label for="specialite"><i class="fas fa-stethoscope"></i> Spécialité</label>
        <input type="text" id="specialite" name="specialite" class="form-control"
               value="${docteur.specialite}" required>
      </div>

      <div class="form-group">
        <label for="departementId"><i class="fas fa-building"></i> Département</label>
        <select id="departementId" name="departementId" class="form-control" required>
          <option value="">Sélectionnez un département</option>
          <c:forEach var="departement" items="${departements}">
            <option value="${departement.id}"
                    <c:if test="${departement.id == docteur.departement.id}">selected</c:if>>
                ${departement.nom}
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-actions">
        <a href="docteurs" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> Annuler
        </a>
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-save"></i> Modifier
        </button>
      </div>
    </form>
  </div>
</div>
</body>
</html>