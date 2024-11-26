<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Cliente</title>
    <!-- Enlace a Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1>Agregar Cliente</h1>
    <form action="clientesadd" method="post" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="name">Nombre:</label>
            <input type="text" id="name" name="name" class="form-control" required>
            <div class="invalid-feedback">Por favor, ingrese el nombre.</div>
        </div>

        <div class="form-group">
            <label for="lastName">Apellido:</label>
            <input type="text" id="lastName" name="lastName" class="form-control" required>
            <div class="invalid-feedback">Por favor, ingrese el apellido.</div>
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="form-control" required>
            <div class="invalid-feedback">Por favor, ingrese un correo electrónico válido.</div>
        </div>

        <div class="form-group">
            <label for="documentType">Tipo de Documento:</label>
            <input type="text" id="documentType" name="documentType" class="form-control" required>
            <div class="invalid-feedback">Por favor, ingrese el tipo de documento.</div>
        </div>

        <div class="form-group">
            <label for="documentNumber">Número de Documento:</label>
            <input type="number" id="documentNumber" name="documentNumber" class="form-control" required>
            <div class="invalid-feedback">Por favor, ingrese el número de documento.</div>
        </div>

        <div class="form-group">
            <label for="birthdate">Fecha de Nacimiento:</label>
            <input type="date" id="birthdate" name="birthdate" class="form-control" required>
            <div class="invalid-feedback">Por favor, seleccione la fecha de nacimiento.</div>
        </div>

        <div class="form-group">
            <label for="phone">Teléfono:</label>
            <input type="text" id="phone" name="phone" class="form-control">
        </div>

        <div class="form-group">
            <label for="address">Dirección:</label>
            <input type="text" id="address" name="address" class="form-control">
        </div>

        <div class="form-group">
            <label for="companyName">Nombre de la Empresa:</label>
            <input type="text" id="companyName" name="companyName" class="form-control">
        </div>

        <button type="submit" class="btn btn-primary">Agregar Cliente</button>
    </form>

    <a href="clientes" class="btn btn-secondary mt-3">Volver a la lista de clientes</a>
</div>

<!-- Enlace a Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Ejemplo de validación personalizada de Bootstrap
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            for (var i = 0; i < forms.length; i++) {
                forms[i].addEventListener('submit', function(event) {
                    if (this.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    this.classList.add('was-validated');
                }, false);
            }
        }, false);
    })();
</script>
</body>
</html>
