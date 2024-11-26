<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista de Repuestos Inactivos</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    .table {
      width: 100%;
      border-collapse: collapse;
      font-family: Arial, sans-serif;
    }
    .table thead {
      background-color: #f5f5f5;
      color: #333;
      font-weight: bold;
      text-align: center;
    }
    .table th, .table td {
      padding: 12px 15px;
      border-bottom: 1px solid #ddd;
      text-align: center;
      vertical-align: middle;
    }
    .table tbody tr:hover {
      background-color: #f9f9f9;
    }
    .table .btn {
      padding: 6px 10px;
      font-size: 0.875rem;
      border-radius: 4px;
    }
    .badge {
      font-size: 0.75rem;
      padding: 5px 10px;
      border-radius: 4px;
    }
    .btn-custom {
      background-color: #ff5722;
      color: white;
    }

    .btn-custom:hover {
      border: 2px solid black;
      background-color: white;
    }

    @media print {
      body * {
        visibility: hidden;
      }
      #printableArea, #printableArea * {
        visibility: visible;
      }
      #printableArea {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
      }
    }
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
  <div class="menu p-3">
    <h5 class="pb-3 border-bottom">Menú</h5>
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link " href="/index.jsp"><i class="fas fa-home"></i> Inicio</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-users"></i> Clientes
        </a>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientes"><i class="fas fa-user me-2"></i> Cliente Natural</a></li>
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicos"><i class="fas fa-building me-2"></i> Cliente Jurídico</a></li>
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicosinactivos"><i class="fas fa-building me-2"></i> Cliente Jurídico Inactivos</a></li>
          <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos"><i class="fas fa-user me-2"></i> Cliente Natural Inactivos</a></li>
        </ul>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/listar"><i class="fas fa-cog"></i> Repuestos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/Registrar_Compras"><i class="fas fa-shopping-cart"></i> Compra</a>
      </li>
    </ul>
  </div>

  <div class="p-4 flex-grow-1 content">
    <h1 class="text-center mb-4">Lista de Repuestos Inactivos</h1>

    <div class="Busqueda mb-1">
      <form action="${pageContext.request.contextPath}/listarInactivo" method="get" class="d-flex" onsubmit="return validateForm()">
        <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

        <label for="brandId" class="form-label me-2">Marca:</label>
        <select id="brandId" name="brandId" class="form-select me-2" onchange="toggleButton()">
          <option value="">Seleccione una marca</option>
          <c:forEach var="brand" items="${brands}">
            <option value="${brand.id}">${brand.name}</option>
          </c:forEach>
        </select>

        <button type="submit" id="searchButton" class="btn btn-primary" disabled>
          <i class="bi bi-search"></i>
        </button>
      </form>
    </div>

    <a href="/listar" class="btn btn-primary">
      <i class="bi bi-tools"></i> Activos
    </a>

    <a href="${pageContext.request.contextPath}/listarInactivo" class="btn btn-primary custom-btn">Restaurar tabla</a>

    <!-- Botón para exportar la tabla a Excel -->
    <button class="btn btn-success float-end me-2" onclick="exportTableToExcel('partsTable', 'Repuestos-Inactivo')">
      <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a Excel
    </button>

    <!-- Botón para imprimir o descargar como PDF -->
    <button id="browserPrint" class="btn btn-custom float-end me-2">
      <i class="bi bi-file-earmark-pdf"></i> Descargar PDF
    </button>

    <!-- Tabla de Repuestos Inactivos -->
    <div id="printableArea">
      <table class="table mt-4" id="inactivePartsTable">
        <thead>
        <tr>
          <th>ID</th>
          <th>Nombre</th>
          <th>Descripción</th>
          <th>Tipo de Compatibilidad</th>
          <th>Categoría</th>
          <th>Marca</th>
          <th>Stock</th>
          <th>Fecha de Entrada</th>
          <th>Estado</th>
          <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="repuestoI" items="${partsI}">
          <tr>
            <td>${repuestoI.id}</td>
            <td>${repuestoI.name}</td>
            <td>${repuestoI.description}</td>
            <td>${repuestoI.compatibilityType}</td>
            <td>${repuestoI.categoryName}</td> <!-- Mostrar nombre de la categoría -->
            <td>${repuestoI.brandName}</td>    <!-- Mostrar nombre de la marca -->
            <td>${repuestoI.stock}</td>
            <td><fmt:formatDate value="${repuestoI.entryDate}" pattern="dd-MMM-yyyy"/></td>
            <td>
              <span class="badge bg-secondary">${repuestoI.state}</span>
            </td>
            <td>
              <form action="/restaurar" method="post" style="display:inline;" onsubmit="return confirm('¿Está seguro de que quieres restaurar este repuesto?');">
                <input type="hidden" name="id" value="${repuestoI.id}">
                <button type="submit" class="btn btn-outline-success">
                  <i class="bi bi-arrow-clockwise"></i>
                </button>
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

    <script>
      // Código para permitir que la búsqueda funcione, poniendo al menos un campo seleccionado
      function toggleButton() {
        const nombre = document.getElementById("nombre").value.trim();
        const marca = document.getElementById("brandId").value; // Cambiado a brandId
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || marca);
      }

      function validateForm() {
        return !document.getElementById("searchButton").disabled;
      }

      function downloadPDFWithBrowserPrint() {
        window.print();
      }
      document.querySelector('#browserPrint').addEventListener('click', downloadPDFWithBrowserPrint);

      function exportTableToExcel(tableID, filename = '') {
        let table = document.getElementById(tableID);
        let wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
        XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Repuestos-Inactivo.xlsx');
      }
    </script>
  </div>
</div>
</body>
</html>


