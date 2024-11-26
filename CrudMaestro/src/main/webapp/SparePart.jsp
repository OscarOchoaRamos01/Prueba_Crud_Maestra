<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Repuestos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
    <div class="p-4 flex-grow-1 content">
        <h1 class="text-center mb-4">Lista de Repuestos</h1>

        <div class="Busqueda mb-1">
            <form action="${pageContext.request.contextPath}/listar" method="get" class="d-flex" onsubmit="return validateForm()">
                <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

                <label for="brandId-B" class="form-label me-2">Marca:</label>
                <select id="brandId-B" name="brandId" class="form-select me-2" onchange="toggleButton()">
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

        <!-- Modal agregar -->
        <div class="modal fade" id="addRepuestoModal" tabindex="-1" aria-labelledby="addRepuestoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <form action="/create" method="post" id="addRepuestoForm">
                        <!-- Header -->
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="addRepuestoModalLabel">Agregar Repuesto</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <!-- Body -->
                        <div class="modal-body">
                            <div class="row g-3">
                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Nombre:</label>
                                    <input type="text" id="name" name="name" class="form-control" placeholder="Ingrese el nombre del repuesto" required>
                                </div>
                                <!-- Descripción -->
                                <div class="col-md-6">
                                    <label for="description" class="form-label">Descripción:</label>
                                    <textarea id="description" name="description" class="form-control" placeholder="Ingrese una breve descripción" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="row g-3 mt-3">
                                <!-- Tipo de Compatibilidad -->
                                <div class="col-md-6">
                                    <label for="compatibilityType" class="form-label">Tipo de Calidad:</label>
                                    <select id="compatibilityType" name="compatibilityType" class="form-select" required>
                                        <option value="">Seleccione una opción</option>
                                        <option value="Original">Original</option>
                                        <option value="Generico">Generico</option>
                                    </select>
                                </div>
                                <!-- Categoría -->
                                <div class="col-md-6">
                                    <label for="categoryId" class="form-label">Categoría:</label>
                                    <select id="categoryId" name="categoryId" class="form-select" required>
                                        <option value="">Seleccione una categoría</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-3 mt-3">
                                <!-- Marca -->
                                <div class="col-md-6">
                                    <label for="brandId" class="form-label">Marca:</label>
                                    <select id="brandId" name="brandId" class="form-select" required>
                                        <option value="">Seleccione una marca</option>
                                        <c:forEach var="brand" items="${brands}">
                                            <option value="${brand.id}">${brand.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Fecha de Entrada -->
                                <div class="col-md-6">
                                    <label for="entryDate" class="form-label">Fecha de Entrada:</label>
                                    <input type="date" id="entryDate" name="entryDate" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <!-- Footer -->
                        <div class="modal-footer bg-light">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Tabla -->
        <div id="printableArea">
            <table class="table mt-4" id="partsTable">
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
                <c:forEach var="repuesto" items="${parts}">
                    <tr>
                        <td>${repuesto.id}</td>
                        <td>${repuesto.name}</td>
                        <td>${repuesto.description}</td>
                        <td>${repuesto.compatibilityType}</td>
                        <td>${repuesto.categoryName}</td> <!-- Mostrar nombre de la categoría -->
                        <td>${repuesto.brandName}</td>    <!-- Mostrar nombre de la marca -->
                        <td>${repuesto.stock}</td>
                        <td><fmt:formatDate value="${repuesto.entryDate}" pattern="dd-MMM-yyyy"/></td>
                        <td>
                    <span class="badge ${repuesto.state == 'A' ? 'bg-success' : 'bg-secondary'}">
                            ${repuesto.state}
                    </span>
                        </td>
                        <td>
                            <button
                                    type="button"
                                    class="btn btn-primary"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editRepuestoModal"
                                    data-id="${repuesto.id}"
                                    data-name="${repuesto.name}"
                                    data-description="${repuesto.description}"
                                    data-compatibilityType="${repuesto.compatibilityType}"
                                    data-categoryId="${repuesto.categoryId}"
                                    data-brandId="${repuesto.brandId}"
                                    data-entryDate="${repuesto.entryDate}"
                                    onclick="loadEditModal(event)">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <form action="/eliminar" method="post" style="display:inline;" onsubmit="return confirm('¿Está seguro de eliminar este repuesto?');">
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

        <!-- Modal editar -->
        <div class="modal fade" id="editRepuestoModal" tabindex="-1" aria-labelledby="editRepuestoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="/editar" method="post" id="editRepuestoForm">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editRepuestoModalLabel">Editar Repuesto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="edit-id" name="id">
                            <div class="mb-3">
                                <label for="edit-name" class="form-label">Nombre:</label>
                                <input type="text" id="edit-name" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="edit-description" class="form-label">Descripción:</label>
                                <textarea id="edit-description" name="description" class="form-control" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="edit-compatibilityType" class="form-label">Tipo de Calidad:</label>
                                <select id="edit-compatibilityType" name="compatibilityType" class="form-select" required>
                                    <option value="">Seleccione una opción</option>
                                    <option value="Original">Original</option>
                                    <option value="Generico">Generico</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editCategoryId" class="form-label">Categoría:</label>
                                <select id="editCategoryId" name="categoryId" class="form-select" required>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${category.id == sparePart.categoryId ? 'selected' : ''}>${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editBrandId" class="form-label">Marca:</label>
                                <select id="editBrandId" name="brandId" class="form-select" required>
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.id}" ${brand.id == sparePart.brandId ? 'selected' : ''}>${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="edit-entryDate" class="form-label">Fecha de Entrada:</label>
                                <input type="date" id="edit-entryDate" name="entryDate" class="form-control" required>
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<script>

    document.addEventListener("DOMContentLoaded", function () {
        // Validaciones para el formulario de agregar repuesto
        const addForm = document.getElementById("addRepuestoForm");
        const addFields = {
            name: {
                element: document.getElementById("name"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("description"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            compatibilityType: {
                element: document.getElementById("compatibilityType"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un tipo de compatibilidad.");
                    return isValid;
                }
            },
            categoryId: {
                element: document.getElementById("categoryId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una categoría.");
                    return isValid;
                }
            },
            brandId: {
                element: document.getElementById("brandId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("entryDate"),
                validate: function () {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Validaciones para el formulario de editar repuesto
        const editForm = document.getElementById("editRepuestoForm");
        const editFields = {
            name: {
                element: document.getElementById("edit-name"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("edit-description"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            compatibilityType: {
                element: document.getElementById("edit-compatibilityType"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un tipo de compatibilidad.");
                    return isValid;
                }
            },
            categoryId: {
                element: document.getElementById("editCategoryId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una categoría.");
                    return isValid;
                }
            },
            brandId: {
                element: document.getElementById("editBrandId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("edit-entryDate"),
                validate: function () {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Eventos de validación en tiempo real para agregar
        Object.values(addFields).forEach(field => {
            field.element.addEventListener("input", field.validate.bind(field));
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general al enviar el formulario de agregar
        addForm.addEventListener("submit", function (event) {
            const isFormValid = Object.values(addFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

        // Eventos de validación en tiempo real para editar
        Object.values(editFields).forEach(field => {
            field.element.addEventListener("input", field.validate.bind(field));
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general al enviar el formulario de editar
        editForm.addEventListener("submit", function (event) {
            const isFormValid = Object.values(editFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

        // Función para alternar clases de validación y mensajes de error
        function toggleValidity(element, isValid, message) {
            if (isValid) {
                element.setCustomValidity("");
                element.classList.add("is-valid");
                element.classList.remove("is-invalid");
            } else {
                element.setCustomValidity(message);
                element.classList.add("is-invalid");
                element.classList.remove("is-valid");
            }
        }

        // Función para campos requeridos
        function checkRequired(element, message) {
            const isValid = element.value.trim() !== "";
            toggleValidity(element, isValid, message);
            return isValid;
        }
    });

    // Código para permitir que la búsqueda funcione, poniendo al menos un campo seleccionado
    function toggleButton() {
        const nombre = document.getElementById("nombre").value.trim();
        const marca = document.getElementById("brandId-B").value; // Cambiado a brandId
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || marca);
    }

    function validateForm() {
        return !document.getElementById("searchButton").disabled;
    }
    // Fin del código para habilitar la búsqueda con al menos un campo seleccionado

    document.getElementById('editRepuestoModal').addEventListener('hidden.bs.modal', function () {
        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) {
            backdrop.remove();
        }
    });

    // Llenar el modal de edición con los datos del repuesto seleccionado
    function loadEditModal(event) {
        const button = event.currentTarget; // Botón que activó el modal

        // Extraer los valores de los atributos data-*
        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');
        const description = button.getAttribute('data-description');
        const compatibilityType = button.getAttribute('data-compatibilityType');
        const categoryId = button.getAttribute('data-categoryId');
        const brandId = button.getAttribute('data-brandId');
        const entryDate = button.getAttribute('data-entryDate');

        // Asignar los valores a los campos del modal
        document.getElementById('edit-id').value = id;
        document.getElementById('edit-name').value = name;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-compatibilityType').value = compatibilityType;
        document.getElementById('editCategoryId').value = categoryId;
        document.getElementById('editBrandId').value = brandId;
        document.getElementById('edit-entryDate').value = entryDate;

        // Mostrar el modal
        new bootstrap.Modal(document.getElementById('editRepuestoModal')).show();
    }

    function downloadPDFWithBrowserPrint() {
        window.print();
    }
    document.querySelector('#browserPrint').addEventListener('click', downloadPDFWithBrowserPrint);

    function exportTableToExcel(tableID, filename = '') {
        let table = document.getElementById(tableID);
        let wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
        XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Repuestos.xlsx');
    }

    // Establecer la fecha máxima al cargar la página
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        // Establecer max para ambos elementos por separado
        document.getElementById('entryDate').setAttribute('max', today);
        document.getElementById('edit-entryDate').setAttribute('max', today);
    });
</script>
</body>
</html>