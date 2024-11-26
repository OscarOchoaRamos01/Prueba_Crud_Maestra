<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pe.edu.vallegrande.Dto.ClienteDto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente</title>
    <!-- Enlace a Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1>Editar Cliente</h1>
    <%
        ClienteDto cliente = (ClienteDto) request.getAttribute("cliente");
    %>
    <form action="clientesupdate" method="post">
        <input type="hidden" name="id" value="${cliente.id}">

        <div class="form-group">
            <label>Nombre:</label>
            <input type="text" class="form-control" name="name" value="${cliente.name}" required>
        </div>

        <div class="form-group">
            <label>Apellido:</label>
            <input type="text" class="form-control" name="lastName" value="${cliente.lastName}" required>
        </div>

        <div class="form-group">
            <label>Email:</label>
            <input type="email" class="form-control" name="email" value="${cliente.email}" required>
        </div>

        <div class="form-group">
            <label>Tipo de Documento:</label>
            <input type="text" class="form-control" name="documentType" value="${cliente.documentType}" required>
        </div>

        <div class="form-group">
            <label>Número de Documento:</label>
            <input type="number" class="form-control" name="documentNumber" value="${cliente.documentNumber}" required>
        </div>

        <div class="form-group">
            <label>Fecha de Nacimiento:</label>
            <input type="date" class="form-control" name="birthdate" value="${cliente.birthdate}" required>
        </div>

        <div class="form-group">
            <label>Teléfono:</label>
            <input type="text" class="form-control" name="phone" value="${cliente.phone}" required>
        </div>

        <div class="form-group">
            <label>Dirección:</label>
            <input type="text" class="form-control" name="address" value="${cliente.address}" required>
        </div>

        <div class="form-group">
            <label>Nombre de la Empresa:</label>
            <input type="text" class="form-control" name="companyName" value="${cliente.companyName}" required>
        </div>

        <button type="submit" class="btn btn-success">Actualizar Cliente</button>
    </form>

    <a href="clientes" class="btn btn-secondary mt-3">Volver a la lista de clientes</a>
</div>

<!-- Enlace a Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
