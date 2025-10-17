<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion - DigitClinic</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #1e88e5 0%, #0d47a1 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }

    .login-container {
      background: white;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 450px;
      position: relative;
      overflow: hidden;
    }

    .medical-icon {
      text-align: center;
      margin-bottom: 20px;
      color: #1e88e5;
      font-size: 48px;
    }

    .login-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .login-header h1 {
      color: #1565c0;
      font-size: 28px;
      font-weight: 600;
      margin-bottom: 8px;
    }

    .login-header p {
      color: #666;
      font-size: 16px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #333;
      font-weight: 500;
      font-size: 14px;
    }

    .form-control {
      width: 100%;
      padding: 14px;
      border: 2px solid #e3f2fd;
      border-radius: 8px;
      font-size: 15px;
      transition: all 0.3s ease;
      background-color: #f8fdff;
    }

    .form-control:focus {
      outline: none;
      border-color: #1e88e5;
      background-color: white;
      box-shadow: 0 0 0 3px rgba(30, 136, 229, 0.1);
    }

    .user-type-selector {
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
    }

    .user-type-btn {
      flex: 1;
      padding: 12px;
      border: 2px solid #e3f2fd;
      background: #f8fdff;
      border-radius: 8px;
      cursor: pointer;
      text-align: center;
      transition: all 0.3s ease;
      font-weight: 500;
    }

    .user-type-btn.active {
      background: #1e88e5;
      color: white;
      border-color: #1e88e5;
    }

    .btn-login {
      width: 100%;
      padding: 14px;
      background: linear-gradient(135deg, #1e88e5 0%, #1565c0 100%);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-top: 10px;
    }

    .btn-login:hover {
      background: linear-gradient(135deg, #1565c0 0%, #0d47a1 100%);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(21, 101, 192, 0.3);
    }

    .login-footer {
      text-align: center;
      margin-top: 25px;
      padding-top: 20px;
      border-top: 1px solid #e3f2fd;
    }

    .login-footer a {
      color: #1e88e5;
      text-decoration: none;
      font-size: 14px;
      margin: 0 10px;
    }

    .login-footer a:hover {
      text-decoration: underline;
    }

    .alert {
      padding: 12px 15px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      border-left: 4px solid;
      display: none;
    }

    .alert-error {
      background-color: #ffebee;
      border-color: #e53935;
      color: #c62828;
    }

    .alert-success {
      background-color: #e8f5e9;
      border-color: #43a047;
      color: #2e7d32;
    }

    .form-options {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 20px 0;
    }

    .remember-me {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 14px;
      color: #555;
    }

    .forgot-password {
      color: #1e88e5;
      text-decoration: none;
      font-size: 14px;
    }

    .forgot-password:hover {
      text-decoration: underline;
    }

    .clinic-badge {
      position: absolute;
      top: 20px;
      right: 20px;
      background: #e3f2fd;
      color: #1565c0;
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
    }

    @media (max-width: 480px) {
      .login-container {
        padding: 30px 20px;
      }

      .form-options {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
      }
    }
  </style>
</head>
<body>
<div class="login-container">

  <div class="medical-icon">
    <i>🏥</i>
  </div>

  <div class="login-header">
    <h1>DigitClinic</h1>
    <p>Accédez à votre compte</p>
  </div>

  <%
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");
    String usernameValue = request.getParameter("email") != null ? request.getParameter("email") : "";
  %>

  <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
  <div class="alert alert-error" id="errorAlert" style="display: block;">
    ⚠️ <%= errorMessage %>
  </div>
  <% } %>

  <% if (successMessage != null && !successMessage.isEmpty()) { %>
  <div class="alert alert-success" id="successAlert" style="display: block;">
    ✅ <%= successMessage %>
  </div>
  <% } %>


  <div class="alert alert-error" id="urlErrorAlert" style="display: none;">
    ⚠️ Identifiant ou mot de passe incorrect
  </div>

  <form action="login" method="post">
    <input type="hidden" id="userType" name="userType" value="MEDECIN">

    <div class="form-group">
      <label for="username">
        👤 Identifiant professionnel
      </label>
      <input type="text"
             id="username"
             name="email"
             class="form-control"
             placeholder="Votre email professionnel"
             required
             autocomplete="username">

    </div>

    <div class="form-group">
      <label for="password">
        🔒 Mot de passe
      </label>
      <input type="password"
             id="password"
             name="motDePasse"
             class="form-control"
             placeholder="Votre mot de passe sécurisé"
             required
             autocomplete="current-password">

    </div>

    <button type="submit" class="btn-login">
      🚪 Se connecter
    </button>
  </form>

</div>

<script>
  document.querySelectorAll('.user-type-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      // Retirer la classe active de tous les boutons
      document.querySelectorAll('.user-type-btn').forEach(b => {
        b.classList.remove('active');
      });
      // Ajouter la classe active au bouton cliqué
      this.classList.add('active');
      // Mettre à jour la valeur cachée
      document.getElementById('userType').value = this.getAttribute('data-type');
    });
  });

  // Vérifier les paramètres URL pour les erreurs
  function checkUrlParams() {
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');

    if (error === 'true') {
      const errorAlert = document.getElementById('urlErrorAlert');
      errorAlert.style.display = 'block';

      // Masquer après 5 secondes
      setTimeout(() => {
        errorAlert.style.display = 'none';
      }, 5000);
    }
  }

  // Afficher les alertes existantes
  function showAlerts() {
    const errorAlert = document.getElementById('errorAlert');
    const successAlert = document.getElementById('successAlert');

    if (errorAlert) errorAlert.style.display = 'block';
    if (successAlert) successAlert.style.display = 'block';
  }

  // Animation au chargement
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.login-container').style.opacity = '0';
    document.querySelector('.login-container').style.transform = 'translateY(20px)';

    setTimeout(() => {
      document.querySelector('.login-container').style.transition = 'all 0.5s ease';
      document.querySelector('.login-container').style.opacity = '1';
      document.querySelector('.login-container').style.transform = 'translateY(0)';
    }, 100);

    checkUrlParams();
    showAlerts();
  });

  // Validation basique du formulaire
  document.querySelector('form').addEventListener('submit', function(e) {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value;

    if (!username || !password) {
      e.preventDefault();
      alert('Veuillez remplir tous les champs obligatoires.');
      return false;
    }

    // Ajouter un indicateur de chargement
    const submitBtn = this.querySelector('.btn-login');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '⏳ Connexion en cours...';
    submitBtn.disabled = true;

    // Réactiver le bouton après 3 secondes au cas où
    setTimeout(() => {
      submitBtn.disabled = false;
      submitBtn.innerHTML = originalText;
    }, 3000);
  });

  // Focus sur le champ username au chargement
  window.onload = function() {
    document.getElementById('username').focus();
  };
</script>
</body>
</html>