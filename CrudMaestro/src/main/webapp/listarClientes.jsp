<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.Dto.ClienteDto" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Clientes</title>
    <!-- Enlace a Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1>Lista de Clientes</h1>

    <a href="clientesadd" class="btn btn-primary mb-3">Agregar Cliente</a>

    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Tipo de Documento</th>
            <th>Número de Documento</th>
            <th>Fecha de Nacimiento</th>
            <th>Teléfono</th>
            <th>Dirección</th>
            <th>Nombre de la Empresa</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ClienteDto> clientes = (List<ClienteDto>) request.getAttribute("clientes");
            for (ClienteDto cliente : clientes) {
        %>
        <tr>
            <td><%= cliente.getId() %></td>
            <td><%= cliente.getName() %></td>
            <td><%= cliente.getLastName() %></td>
            <td><%= cliente.getEmail() %></td>
            <td><%= cliente.getDocumentType() %></td>
            <td><%= cliente.getDocumentNumber() %></td>
            <td><%= cliente.getBirthdate() %></td>
            <td><%= cliente.getPhone() %></td>
            <td><%= cliente.getAddress() %></td>
            <td><%= cliente.getCompanyName() %></td>
            <td><%= cliente.getStatus() %></td>
            <td>
                <a href="clientesedit?id=<%= cliente.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                <a href="clientesdelete?id=<%= cliente.getId() %>" class="btn btn-danger btn-sm">Eliminar</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <a href="clienteseliminados" class="btn btn-secondary mt-3">Ver Clientes Inactivos</a>
</div>

<!-- Enlace a Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
