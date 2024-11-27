<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejemplo con Menú Bootstrap</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        /* Ajuste general del menú */
        .menu {
            min-height: 100vh;
            width: 300px;
            background-color: #f8f9fa; /* Fondo claro */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Sombra sutil */
            border-right: 1px solid #dee2e6; /* Línea divisoria */
        }

        /* Título del menú */
        .menu h5 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #495057;
        }

        /* Espaciado en los elementos del menú */
        .nav-item {
            margin-bottom: 10px; /* Espaciado entre elementos */
        }

        /* Enlace del menú */
        .nav-link {
            display: flex;
            align-items: center;
            font-size: 1.1rem;
            color: #495057;
            padding: 12px 15px;
            border-radius: 5px;
            transition: all 0.3s ease-in-out;
        }

        /* Hover y enlace activo */
        .nav-link:hover,
        .nav-link.active {
            background-color: #e9ecef;
            color: #0d6efd; /* Color principal de Bootstrap */
            font-weight: 500;
            text-decoration: none;
        }

        /* Estilo de los íconos */
        .nav-link i {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #6c757d; /* Color secundario */
            transition: color 0.3s ease-in-out;
        }

        .nav-link:hover i,
        .nav-link.active i {
            color: #0d6efd; /* Ícono en estado activo o hover */
        }

        /* Submenú */
        .dropdown-menu {
            background-color: #f8f9fa;
            border-radius: 5px;
            border: 1px solid #dee2e6;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item {
            font-size: 1rem;
            color: #495057;
            padding: 8px 15px;
            transition: all 0.3s ease-in-out;
        }

        .dropdown-item:hover {
            background-color: #e9ecef;
            color: #0d6efd;
        }
    </style>
</head>

<body>
<div class="d-flex">
    <!-- Menú vertical -->
    <nav class="bg-light p-3 menu">
        <h5 class="pb-3 border-bottom">Menú</h5>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active d-flex align-items-center" href="index.jsp">
                    <i class="fas fa-home me-2"></i> Inicio
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-users me-2"></i> Clientes
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientes">
                            <i class="fas fa-user me-2"></i> Cliente Natural
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicos">
                            <i class="fas fa-building me-2"></i> Cliente Jurídico
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicosinactivos">
                            <i class="fas fa-building me-2"></i> Cliente Jurídico Inactivos
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos">
                            <i class="fas fa-user me-2"></i> Cliente Natural Inactivos
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/listar">
                    <i class="fas fa-cog me-2"></i> Repuestos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/Compras">
                    <i class="fas fa-shopping-cart me-2"></i> Compra
                </a>
            </li>
        </ul>
    </nav>

    <!-- Contenido principal -->
    <div class="p-4 flex-grow-1 content">
        <h2 class="mb-4" style="text-align: center">Taller de Mecánica Automotriz Electrónica</h2>

        <p>
            ¡Bienvenidos al Taller de Mecánica Automotriz Electrónica! Este espacio está diseñado para aprender y dominar
            técnicas y herramientas esenciales para diagnosticar, reparar y optimizar los sistemas electrónicos de los vehículos modernos.
        </p>

        <h4 class="mt-4">¿Por qué es importante la electrónica en los automóviles?</h4>
        <p>
            En la actualidad, la electrónica desempeña un papel crucial en el funcionamiento de los automóviles. Desde
            los sistemas de encendido y combustible hasta los elementos de seguridad, confort y eficiencia, la tecnología electrónica
            es esencial para garantizar un rendimiento óptimo.
        </p>

        <h4 class="mt-4">Lo que aprenderás</h4>
        <ul>
            <li>Conocimientos fundamentales sobre componentes electrónicos automotrices.</li>
            <li>Interpretación de diagramas de sistemas electrónicos.</li>
            <li>Capacitación en el uso de equipos de diagnóstico avanzados.</li>
            <li>Procedimientos para resolver fallos comunes en sistemas electrónicos.</li>
            <li>Técnicas de mantenimiento preventivo para prolongar la vida útil de los vehículos.</li>
        </ul>

        <h4 class="mt-4">¿A quién está dirigido?</h4>
        <p>
            Este taller está dirigido tanto a técnicos en formación como a profesionales con experiencia que desean actualizarse
            en las últimas tecnologías emergentes en el sector automotriz.
        </p>

        <p>
            Prepárate para una experiencia formativa dinámica y enriquecedora que te permitirá destacar en el campo de la
            mecánica automotriz electrónica. ¡Te esperamos!
        </p>
    </div>

</div>

<!-- Bootstrap y Font Awesome JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
