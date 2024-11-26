<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes Jurídicos Inactivos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        /* Ajustes para que el menú ocupe todo el alto de la página */
        .menu {
            min-height: 100vh;
            width: 300px; /* Ancho del menú */
        }
        /* Estilo para el icono activo */
        .nav-link.active {
            background-color: #e9ecef;
            font-weight: bold;
        }
        /* Aumentar el tamaño de los íconos */
        .nav-link i {
            font-size: 1.5rem; /* Tamaño del icono */
        }
        /* Aumentar el tamaño de la fuente */
        .nav-link {
            font-size: 1.2rem; /* Tamaño de la fuente de los enlaces */
        }
        /* Espaciado en el contenedor principal */
        .content {
            padding: 30px; /* Espaciado interno */
        }
        /* Espaciado entre elementos del menú */
        .nav-item {
            margin-bottom: 15px; /* Espacio entre opciones del menú */
        }
    </style>
</head>
<body>
<div class="d-flex">
    <!-- Menú vertical -->
    <div class="bg-light p-3 menu">
        <h5 class="pb-3 border-bottom">Menú</h5>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active d-flex align-items-center" href="index.jsp"><i class="fas fa-home me-2"></i> Inicio</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-users me-2"></i> Clientes
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientes"><i class="fas fa-user me-2"></i> Cliente Natural</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicos"><i class="fas fa-building me-2"></i> Cliente Jurídico</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicosinactivos"><i class="fas fa-building me-2"></i> Cliente Jurídico inactivos</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos"><i class="fas fa-user me-2"></i> Cliente Natural inactivos</a></li>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/listar"><i class="fas fa-cog me-2"></i> Repuestos </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/Registrar_Compras"><i class="fas fa-shopping-cart me-2"></i> Compra </a>
            </li>
        </ul>
    </div>

    <!-- Contenido principal -->
    <div class="p-4 flex-grow-1 content">
        <h1>Clientes Jurídicos Inactivos</h1>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>T. Persona</th>
                <th>Razón Social</th>
                <th>RUC</th>
                <th>Dirección</th>
                <th>Teléfono</th>
                <th>Email</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cliente" items="${clientesJuridicosInactivos}">
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.typePerson}</td>
                    <td>${cliente.companyName}</td>
                    <td>${cliente.ruc}</td>
                    <td>${cliente.address}</td>
                    <td>${cliente.phone}</td>
                    <td>${cliente.email}</td>
                    <td>${cliente.status}</td>
                    <td>
                        <form action="reactivarCliente" method="post">
                            <input type="hidden" name="id" value="${cliente.id}">
                            <input type="hidden" name="tipo" value="juridico">
                            <button type="submit" class="btn btn-primary">Reactivar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap y Font Awesome JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
