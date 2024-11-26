<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registrar Compra</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Estilos del menú */
    .menu {
      min-height: 100vh;
      width: 300px;
      background-color: #f8f9fa;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-right: 1px solid #dee2e6;
    }

    .menu h5 {
      font-size: 1.25rem;
      font-weight: 600;
      color: #495057;
    }

    .nav-item {
      margin-bottom: 10px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      font-size: 1.1rem;
      color: #495057;
      padding: 12px 15px;
      border-radius: 5px;
      transition: all 0.3s ease-in-out;
    }

    .nav-link:hover,
    .nav-link.active {
      background-color: #e9ecef;
      color: #0d6efd;
      font-weight: 500;
      text-decoration: none;
    }

    .nav-link i {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #6c757d;
      transition: color 0.3s ease-in-out;
    }

    .nav-link:hover i,
    .nav-link.active i {
      color: #0d6efd;
    }

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

    /* Estilo de contenido */
    .content {
      padding: 20px;
      flex-grow: 1;
    }

    .layout {
      display: flex;
    }
  </style>
</head>
<body>
<div class="layout">
  <!-- Menú vertical -->
  <div class="bg-light p-3 menu">
    <h5 class="pb-3 border-bottom">Menú</h5>
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/index.jsp"><i class="fas fa-home me-2"></i> Opción 1</a>
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
  <div class="content">
    <div class="container py-5">
      <h2 class="mb-4 text-center">Registrar Compra</h2>
      <form id="purchaseForm">
        <div class="row g-3">
          <form id="purchaseForm">
            <div class="row g-3">
              <!-- Proveedor -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="supplier" name="supplierId" class="form-select" required>
                    <option value="" selected>Seleccione un proveedor</option>
                    <c:forEach var="supplier" items="${suppliers}">
                      <option value="${supplier.id}">${supplier.company}</option>
                    </c:forEach>
                  </select>
                  <label for="supplier">Proveedor</label>
                </div>
              </div>

              <!-- Método de Pago -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="paymentMethod" name="paymentMethod" class="form-select" required>
                    <option value="Efectivo">Efectivo</option>
                    <option value="Tarjeta">Tarjeta</option>
                    <option value="Transferencia">Transferencia</option>
                  </select>
                  <label for="paymentMethod">Método de Pago</label>
                </div>
              </div>

              <!-- Producto -->
              <div class="col-md-6">
                <div class="form-floating">
                  <select id="product" class="form-select">
                    <option value="" selected>Seleccione un producto</option>
                    <c:forEach var="sparePart" items="${spareParts}">
                      <option value="${sparePart.id}" data-name="${sparePart.name}">
                          ${sparePart.name} - ${sparePart.brandName} - ${sparePart.compatibilityType}
                      </option>
                    </c:forEach>
                  </select>
                  <label for="product">Producto</label>
                </div>
              </div>

              <!-- Precio Unitario -->
              <div class="col-md-3">
                <div class="form-floating">
                  <input type="number" id="priceUnit" class="form-control" min="0" step="0.01" placeholder="Precio Unitario">
                  <label for="priceUnit">Precio Unitario</label>
                </div>
              </div>

              <!-- Cantidad -->
              <div class="col-md-3">
                <div class="form-floating">
                  <input type="number" id="quantity" class="form-control" min="1" placeholder="Cantidad">
                  <label for="quantity">Cantidad</label>
                </div>
              </div>

              <!-- Botón Agregar Producto -->
              <div class="col-12 text-end">
                <button type="button" class="btn btn-primary" onclick="addProduct()">Agregar Producto</button>
              </div>
            </div>
          </form>
        </div>
      </form>

      <!-- Tabla de Detalles -->
      <div class="mt-5">
        <h4>Detalle de Compra</h4>
        <table class="table table-striped table-hover text-center" id="purchaseDetailsTable">
          <thead class="table-secondary">
          <tr>
            <th>Producto</th>
            <th>Precio Unitario</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
            <th>Acciones</th>
          </tr>
          </thead>
          <tbody></tbody>
        </table>
        <h5 class="text-end">Total: S/. <span id="totalAmount">0</span></h5>
      </div>

      <!-- Botón Registrar Compra -->
      <div class="mt-3 text-end">
        <button type="button" class="btn btn-success" onclick="submitForm()">Registrar Compra</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  let totalAmount = 0;
  const selectedProducts = [];

  function addProduct() {
    const productSelect = document.getElementById("product");
    const priceInput = document.getElementById("priceUnit");
    const quantityInput = document.getElementById("quantity");
    const supplierSelect = document.getElementById("supplier"); // Obtener el proveedor seleccionado
    const paymentMethodSelect = document.getElementById("paymentMethod"); // Obtener el método de pago

    const supplierId = supplierSelect.value;
    const productId = productSelect.value;
    const selectedOption = productSelect.options[productSelect.selectedIndex];
    const productName = selectedOption?.getAttribute("data-name");
    const priceUnit = parseFloat(priceInput.value);
    const quantity = parseInt(quantityInput.value);

    if (!supplierId || !productId || isNaN(priceUnit) || priceUnit <= 0 || isNaN(quantity) || quantity <= 0) {
      alert("Debe seleccionar un proveedor, un producto, e ingresar un precio y cantidad válidos.");
      return;
    }

    const subtotal = priceUnit * quantity;

    const tableBody = document.getElementById("purchaseDetailsTable").querySelector("tbody");
    const row = document.createElement("tr");

    // Crear y agregar las celdas
    const nameCell = document.createElement("td");
    nameCell.textContent = productName;

    const priceCell = document.createElement("td");
    priceCell.textContent = "S/. " + priceUnit.toFixed(2);

    const quantityCell = document.createElement("td");
    quantityCell.textContent = quantity;

    const subtotalCell = document.createElement("td");
    subtotalCell.textContent = "S/. " + subtotal.toFixed(2);

    const actionCell = document.createElement("td");
    const deleteButton = document.createElement("button");
    deleteButton.type = "button";
    deleteButton.className = "btn btn-danger btn-sm";
    deleteButton.textContent = "Eliminar";
    deleteButton.onclick = function () {
      removeProduct(row, subtotal);
    };

    actionCell.appendChild(deleteButton);

    // Agregar las celdas a la fila
    row.appendChild(nameCell);
    row.appendChild(priceCell);
    row.appendChild(quantityCell);
    row.appendChild(subtotalCell);
    row.appendChild(actionCell);

    // Agregar la fila al cuerpo de la tabla
    tableBody.appendChild(row);

    // Actualizar los totales
    selectedProducts.push({ productId, productName, priceUnit, quantity, subtotal });
    totalAmount += subtotal;
    updateTotals();

    // Deshabilitar los campos de proveedor y método de pago
    supplierSelect.disabled = true;
    paymentMethodSelect.disabled = true;

    // Limpiar los campos excepto el proveedor y el método de pago
    productSelect.value = "";
    priceInput.value = "";
    quantityInput.value = "";
  }

  function submitForm() {
    const supplierId = document.getElementById("supplier").value;
    const paymentMethod = document.getElementById("paymentMethod").value;

    if (selectedProducts.length === 0) {
      alert("Debe agregar al menos un producto antes de registrar la compra.");
      return;
    }

    fetch("/RegistrarCompra", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ supplierId, paymentMethod, totalAmount, products: selectedProducts }),
    })
            .then((response) => {
              if (response.ok) {
                alert("Compra registrada exitosamente.");
                resetForm(); // Reiniciar todo el formulario y desbloquear campos
              } else {
                alert("Error al registrar la compra.");
              }
            })
            .catch((error) => console.error("Error:", error));
  }

  function resetForm() {
    // Resetear los campos del formulario
    document.getElementById("purchaseForm").reset();

    // Limpiar la tabla de detalles
    const tableBody = document.getElementById("purchaseDetailsTable").querySelector("tbody");
    tableBody.innerHTML = "";

    // Reiniciar las variables y totales
    selectedProducts.length = 0;
    totalAmount = 0;
    updateTotals();

    // Rehabilitar los campos de proveedor y método de pago
    document.getElementById("supplier").disabled = false;
    document.getElementById("paymentMethod").disabled = false;
  }

  function updateTotals() {
    document.getElementById("totalAmount").textContent = totalAmount.toFixed(2);
  }

</script>
</body>
</html>
