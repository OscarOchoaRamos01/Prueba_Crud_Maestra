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
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Montserrat', sans-serif;
    }
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
  <div class="bg-light p-3 menu" style="min-height: 100vh; width: 300px;">
    <h5 class="pb-3 border-bottom">Menú</h5>
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link" href="/index.jsp"><i class="fas fa-home me-2"></i> Opción 1</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
        <a class="nav-link d-flex align-items-center" href="#opcion4"><i class="fas fa-shopping-cart me-2"></i> Compra </a>
      </li>
    </ul>
  </div>

  <div class="p-4 flex-grow-1 content">
    <h1 class="text-center mb-4">Lista de Repuestos Inactivos</h1>

    <div class="Busqueda mb-1">
      <form action="${pageContext.request.contextPath}/listarInactivo" method="get" class="d-flex" onsubmit="return validateForm()">
        <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

        <label for="brand" class="form-label me-2">Marca:</label>
        <select id="brand" name="marca" class="form-select me-2" onchange="toggleButton()">
          <option value="">Seleccione una marca</option>
          <option value="Toyota">Toyota</option>
          <option value="Honda">Honda</option>
          <option value="Ford">Ford</option>
          <option value="Chevrolet">Chevrolet</option>
          <option value="Nissan">Nissan</option>
          <option value="BMW">BMW</option>
          <option value="Audi">Audi</option>
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

    <div id="printableArea">
      <!-- Lista de Repuestos Inactivos -->
      <table class="table mt-4 table-striped table-hover table-sm" id="partsTable">
        <thead>
        <tr>
          <th>ID</th>
          <th>NOMBRE</th>
          <th>DESCRIPCIÓN</th>
          <th>PRECIO</th>
          <th>MARCA</th>
          <th>STOCK</th>
          <th>MODELO COMPATIBLE</th>
          <th>FECHA DE ENTRADA</th>
          <th>ESTADO</th>
          <th>ACCIONES</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="repuestoI" items="${partsI}">
          <tr>
            <td>${repuestoI.id}</td>
            <td>${repuestoI.name}</td>
            <td>${repuestoI.description}</td>
            <td>S/. <fmt:formatNumber value="${repuestoI.priceUnit}" pattern="#,##0.00"/></td>
            <td>${repuestoI.brand}</td>
            <td>${repuestoI.stock}</td>
            <td>${repuestoI.compatibleModel}</td>
            <td><fmt:formatDate value="${repuestoI.entryDate}" pattern="dd-MMM-yyyy"/></td>
            <td>
              <span class="badge" style="background-color: black;">${repuestoI.state}</span>
            </td>
            <td>
              <form action="/restaurar" method="post" style="display: inline;" onsubmit="return confirm('¿Estás seguro de que quieres restaurar este repuesto?');">
                <input type="hidden" name="id" value="${repuestoI.id}">
                <button type="submit" class="btn btn-outline-success btn-sm">
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
        const brand = document.getElementById("brand").value;
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || brand);
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


