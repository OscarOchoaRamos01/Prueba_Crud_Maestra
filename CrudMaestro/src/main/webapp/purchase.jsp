<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Compras</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Mantener el estilo original del menú */
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

        /* Estilos para el contenido */
        .content {
            flex-grow: 1;
            padding: 15px;
        }

        .layout {
            display: flex;
        }

        .table {
            font-size: 0.9rem;
        }

        .modal-body {
            font-size: 0.9rem;
        }

        .modal-title {
            font-size: 1.2rem;
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
        <h1 class="text-center mb-4">Listado de Compras</h1>

        <div class="mb-3 text-end">
            <a href="/Registrar_Compras" class="btn btn-primary">
                <i class="fas fa-plus"></i> Registrar Nueva Compra
            </a>
        </div>

        <table class="table mt-4">
            <thead>
            <tr>
                <th>ID</th>
                <th>Proveedor</th>
                <th>Fecha</th>
                <th>Total</th>
                <th>Método de Pago</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="purchase" items="${purchases}">
                <tr>
                    <td>${purchase.id}</td>
                    <td>${purchase.supplierName}</td>
                    <td>${purchase.date}</td>
                    <td>${purchase.totalAmount}</td>
                    <td>${purchase.paymentMethod}</td>
                    <td>${purchase.status}</td>
                    <td>
                        <button class="btn btn-info btn-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#detailModal"
                                onclick="loadPurchaseDetails(${purchase.id})">
                            <i class="fas fa-eye"></i> Ver Detalles
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal de Detalles -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">Detalles de la Compra</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>ID:</strong> <span id="purchaseId"></span></p>
                <p><strong>Proveedor:</strong> <span id="supplierName"></span></p>
                <p><strong>Fecha:</strong> <span id="purchaseDate"></span></p>
                <p><strong>Total:</strong> <span id="purchaseTotal"></span></p>
                <p><strong>Método de Pago:</strong> <span id="paymentMethod"></span></p>
                <h5 class="mt-4">Detalles de la Compra</h5>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Repuesto</th>
                        <th>Cantidad</th>
                        <th>Subtotal</th>
                    </tr>
                    </thead>
                    <tbody id="purchaseDetails">
                    <!-- Detalles dinámicos -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function loadPurchaseDetails(purchaseId) {
        fetch("/ComprasDetalles", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ id: purchaseId }),
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al obtener los detalles de la compra');
                }
                return response.json();
            })
            .then(data => {
                const purchase = data.purchase;
                const details = data.details;

                // Llenar datos generales
                document.getElementById('purchaseId').textContent = purchase.id;
                document.getElementById('supplierName').textContent = purchase.supplierName;
                document.getElementById('purchaseDate').textContent = purchase.date;
                document.getElementById('purchaseTotal').textContent = purchase.totalAmount;
                document.getElementById('paymentMethod').textContent = purchase.paymentMethod;

                // Llenar tabla de detalles
                const detailsTable = document.getElementById('purchaseDetails');
                detailsTable.innerHTML = ''; // Limpiar contenido previo
                details.forEach(detail => {
                    const row = document.createElement('tr');

                    const sparePartCell = document.createElement('td');
                    sparePartCell.textContent = detail.sparePartName || "N/A";
                    row.appendChild(sparePartCell);

                    const quantityCell = document.createElement('td');
                    quantityCell.textContent = detail.quantity;
                    row.appendChild(quantityCell);

                    const subtotalCell = document.createElement('td');
                    subtotalCell.textContent = detail.subtotal;
                    row.appendChild(subtotalCell);

                    detailsTable.appendChild(row);
                });
            })
            .catch(error => {
                console.error('Error al cargar los detalles:', error);
            });
    }
</script>
</body>
</html>
