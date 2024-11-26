<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Repuestos</title>
    <!-- Bootstrap CSS --> <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
            text-align: left;
        }
        .table th, .table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }
        .table tbody tr:hover {
            background-color: #f9f9f9;
        }
        .table .btn {
            padding: 6px 10px;
            font-size: 0.875rem;
            border-radius: 4px;
        }
        .btn-primary {
            color: #fff;
            background-color: #007bff;
            border: none;
        }
        .btn-danger {
            color: #fff;
            background-color: #dc3545;
            border: none;
        }
        .badge {
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .bg-secondary {
            --bs-bg-opacity: 1;
            background-color: #28a745 !important;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
        }
        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .modal-body {
            background-color: #f8f9fa;
        }
        .form-label {
            margin-top: .5rem;
            font-weight: 500;
        }
        .description-field {
            height: 150px;
            resize: none;
        }
        .mb-3 {
            margin-bottom: 0 !important;
        }

        .mb-1 {
            margin-bottom: 1rem !important;
        }

        .custom-btn {
            background-color: #495057; /* Gris azulado oscuro */
            border: none;
            color: white;
        }

        .custom-btn:hover {
            background-color: #343a40; /* Gris más oscuro para el hover */
        }

        .btn-custom {
            background-color: #ff5722; /* Color de fondo */
            color: white; /* Color del texto */
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
    <div class="bg-light p-3 menu">
        <h5 class="pb-3 border-bottom">Menú</h5>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active d-flex align-items-center" href="/index.jsp"><i class="fas fa-home me-2"></i> Opción 1</a>
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
                <a class="nav-link d-flex align-items-center" href="#opcion4"><i class="fas fa-shopping-cart me-2"></i> Compra </a>
            </li>
        </ul>
    </div>

    <div class="p-4 flex-grow-1 content">
        <h1 class="text-center my-4">Lista de Repuestos</h1>

        <div class="Busqueda mb-1">
            <form action="${pageContext.request.contextPath}/listar" method="get" class="d-flex" onsubmit="return validateForm()">
                <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>
                <label for="brand" class="form-label me-2">Marca:</label>
                <select id="marca" name="marca" class="form-select me-2" onchange="toggleButton()">
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

        <!-- Botón para abrir el modal de agregar repuesto -->
        <button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addRepuestoModal">
            <i class="bi bi-plus-circle"></i> Agregar Nuevo Repuesto
        </button>

        <a href="/listarInactivo" class="btn btn-dark">
            <i class="bi bi-eye-slash"></i> Inactivos
        </a>

        <a href="${pageContext.request.contextPath}/listar" class="btn btn-primary custom-btn">Restaurar tabla</a>

        <!-- Botón para exportar la tabla a Excel -->
        <button class="btn btn-success float-end me-2" onclick="exportTableToExcel('partsTable', 'Repuestos')">
            <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a Excel
        </button>

        <!-- Botón para imprimir o descargar como PDF -->
        <button id="browserPrint" class="btn btn-custom float-end me-2">
            <i class="bi bi-file-earmark-pdf"></i> Descargar PDF
        </button>

        <!-- Modal para agregar repuesto -->
        <div class="modal fade" id="addRepuestoModal" tabindex="-1" aria-labelledby="addRepuestoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addRepuestoModalLabel">Agregar Nuevo Repuesto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="addRepuestoForm" action="/create" method="post" novalidate>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="name" class="form-label">Nombre:</label>
                                <input type="text" id="name" name="name" class="form-control" required>
                                <div class="invalid-feedback">El nombre es obligatorio.</div>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Descripción:</label>
                                <textarea id="description" name="description" class="form-control" required></textarea>
                                <div class="invalid-feedback">La descripción es obligatoria.</div>
                            </div>
                            <div class="mb-3">
                                <label for="priceUnit" class="form-label">Precio:</label>
                                <input type="number" step="0.10" id="priceUnit" name="priceUnit" class="form-control" required>
                                <div class="invalid-feedback">El precio es obligatorio y debe ser un número positivo.</div>
                            </div>
                            <div class="mb-3">
                                <label for="brand" class="form-label">Marca:</label>
                                <select id="brand" name="brand" class="form-control" required>
                                    <option value="">Seleccione una marca</option>
                                    <option value="Toyota">Toyota</option>
                                    <option value="Honda">Honda</option>
                                    <option value="Ford">Ford</option>
                                    <option value="Chevrolet">Chevrolet</option>
                                    <option value="Nissan">Nissan</option>
                                    <option value="BMW">BMW</option>
                                    <option value="Audi">Audi</option>
                                </select>
                                <div class="invalid-feedback">Seleccione una marca.</div>
                            </div>
                            <div class="mb-3">
                                <label for="stock" class="form-label">Stock:</label>
                                <input type="number" id="stock" name="stock" class="form-control" required min="1">
                                <div class="invalid-feedback">El stock debe ser un número entero.</div>
                            </div>
                            <div class="mb-3">
                                <label for="compatibleModel" class="form-label">Modelo Compatible:</label>
                                <select id="compatibleModel" name="compatibleModel" class="form-control" required>
                                    <option value="">Seleccione un modelo</option>
                                    <option value="Original">Original</option>
                                    <option value="Compatible">Compatible</option>
                                </select>
                                <div class="invalid-feedback">Seleccione un modelo compatible.</div>
                            </div>
                            <div class="mb-3">
                                <label for="entryDate" class="form-label">Fecha de Entrada:</label>
                                <input type="date" id="entryDate" name="entryDate" class="form-control" required>
                                <div class="invalid-feedback">La fecha de entrada es obligatoria.</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="printableArea">
            <!-- Lista de Repuestos -->
            <table class="table mt-4" id="partsTable">
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
                <c:forEach var="repuesto" items="${parts}">
                    <tr>
                        <td>${repuesto.id}</td>
                        <td>${repuesto.name}</td>
                        <td>${repuesto.description}</td>
                        <td>S/. <fmt:formatNumber value="${repuesto.priceUnit}" pattern="#,##0.00"/></td>
                        <td>${repuesto.brand}</td>
                        <td>${repuesto.stock}</td>
                        <td>${repuesto.compatibleModel}</td>
                        <td><fmt:formatDate value="${repuesto.entryDate}" pattern="dd-MMM-yyyy"/></td>
                        <td>
                            <span class="badge bg-secondary">${repuesto.state}</span>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                                    data-id="${repuesto.id}" data-name="${repuesto.name}" data-description="${repuesto.description}"
                                    data-price="${repuesto.priceUnit}" data-brand="${repuesto.brand}" data-stock="${repuesto.stock}"
                                    data-model="${repuesto.compatibleModel}" data-date="${repuesto.entryDate}">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <form action="/eliminar" method="post" style="display: inline;" onsubmit="return confirm('¿Estás seguro de que quieres eliminar este repuesto?');">
                                <input type="hidden" name="id" value="${repuesto.id}">
                                <button type="submit" class="btn btn-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Modal para editar repuesto -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Editar Repuesto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editRepuestoForm" action="/editar" method="post" novalidate>
                        <div class="modal-body">
                            <input type="hidden" id="edit-id" name="id">
                            <div class="mb-3">
                                <label for="edit-name" class="form-label">Nombre:</label>
                                <input type="text" id="edit-name" name="name" class="form-control" required>
                                <div class="invalid-feedback">El nombre es obligatorio.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-description" class="form-label">Descripción:</label>
                                <textarea id="edit-description" name="description" class="form-control" required></textarea>
                                <div class="invalid-feedback">La descripción es obligatoria.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-priceUnit" class="form-label">Precio:</label>
                                <input type="number" step="0.10" id="edit-priceUnit" name="priceUnit" class="form-control" required>
                                <div class="invalid-feedback">El precio es obligatorio y debe ser un número positivo.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-brand" class="form-label">Marca:</label>
                                <select id="edit-brand" name="brand" class="form-control" required>
                                    <option value="">Seleccione una marca</option>
                                    <option value="Toyota">Toyota</option>
                                    <option value="Honda">Honda</option>
                                    <option value="Ford">Ford</option>
                                    <option value="Chevrolet">Chevrolet</option>
                                    <option value="Nissan">Nissan</option>
                                    <option value="BMW">BMW</option>
                                    <option value="Audi">Audi</option>
                                </select>
                                <div class="invalid-feedback">Seleccione una marca.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-stock" class="form-label">Stock:</label>
                                <input type="number" id="edit-stock" name="stock" class="form-control" required min="1">
                                <div class="invalid-feedback">El stock debe ser un número entero y mayor que cero.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-compatibleModel" class="form-label">Modelo Compatible:</label>
                                <select id="edit-compatibleModel" name="compatibleModel" class="form-control" required>
                                    <option value="">Seleccione un modelo</option>
                                    <option value="Original">Original</option>
                                    <option value="Compatible">Compatible</option>
                                </select>
                                <div class="invalid-feedback">Seleccione un modelo compatible.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit-entryDate" class="form-label">Fecha de Entrada:</label>
                                <input type="date" id="edit-entryDate" name="entryDate" class="form-control" required>
                                <div class="invalid-feedback">La fecha de entrada es obligatoria.</div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<script>
    let totalAmount = 0;
    const selectedProducts = [];

    function addProduct() {
        const productSelect = document.getElementById("product");
        const quantityInput = document.getElementById("quantity");

        const productId = productSelect.value;
        const productName = productSelect.options[productSelect.selectedIndex]?.getAttribute("data-name");
        const priceUnit = parseFloat(productSelect.options[productSelect.selectedIndex]?.getAttribute("data-price"));
        const quantity = parseInt(quantityInput.value);

        // Validaciones
        if (!productId || !quantity || quantity <= 0) {
            alert("Seleccione un producto y una cantidad válida.");
            return;
        }

        const subtotal = (priceUnit * quantity).toFixed(2); // Aseguramos precisión de dos decimales
        totalAmount += parseFloat(subtotal);

        // Actualizamos la memoria de productos seleccionados
        selectedProducts.push({ productId, productName, quantity, subtotal });

        // Renderizamos la tabla
        renderTable();

        // Limpiamos los campos del formulario
        productSelect.value = "";
        quantityInput.value = "";
    }

    function renderTable() {
        const tableBody = document.getElementById("purchaseDetailsTable").querySelector("tbody");
        tableBody.innerHTML = ""; // Limpiamos antes de redibujar

        selectedProducts.forEach((product, index) => {
            const row = `
        <tr>
          <td>${product.productName}</td>
          <td>S/. ${parseFloat(product.subtotal / product.quantity).toFixed(2)}</td>
          <td>${product.quantity}</td>
          <td>S/. ${product.subtotal}</td>
          <td>
            <button type="button" class="btn btn-danger btn-sm" onclick="removeProduct(${index})">Eliminar</button>
          </td>
        </tr>
      `;
            tableBody.insertAdjacentHTML("beforeend", row);
        });

        updateTotals();
    }

    function removeProduct(index) {
        // Eliminamos el producto de la memoria
        const removedProduct = selectedProducts.splice(index, 1)[0];
        totalAmount -= parseFloat(removedProduct.subtotal);

        // Redibujamos la tabla
        renderTable();
    }

    function updateTotals() {
        const discount = (totalAmount * 0.18).toFixed(2); // Calculamos el IGV con 2 decimales
        document.getElementById("totalAmount").textContent = totalAmount.toFixed(2);
        document.getElementById("discount").textContent = discount;
    }

    function submitForm() {
        const supplierId = document.getElementById("supplier").value;
        const paymentMethod = document.getElementById("paymentMethod").value;

        if (!supplierId || selectedProducts.length === 0) {
            alert("Debe seleccionar un proveedor y agregar productos.");
            return;
        }

        const data = {
            supplierId,
            paymentMethod,
            totalAmount: totalAmount.toFixed(2),
            discount: (totalAmount * 0.18).toFixed(2),
            products: selectedProducts,
        };

        fetch("/RegistrarCompra", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(data),
        })
            .then((response) => {
                if (response.ok) {
                    alert("Compra registrada exitosamente.");
                    location.reload();
                } else {
                    alert("Error al registrar la compra.");
                }
            })
            .catch((error) => {
                console.error("Error:", error);
                alert("Ocurrió un error al procesar la solicitud.");
            });
    }
</script>
</body>
</html>



