<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <title>Clientes Jurídicos Activos</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmarEliminacion(id) {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                    confirmButton: 'btn btn-success',
                    cancelButton: 'btn btn-danger'
                },
                buttonsStyling: false
            });
            swalWithBootstrapButtons.fire({
                title: "¿Está seguro?",
                text: "¡Esta acción no se puede revertir!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "No, cancelar",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('deleteForm_' + id).submit();
                    swalWithBootstrapButtons.fire(
                        "¡Eliminado!",
                        "El cliente ha sido eliminado.",
                        "success"
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    swalWithBootstrapButtons.fire(
                        "Cancelado",
                        "La acción ha sido cancelada.",
                        "error"
                    );
                }
            });
        }

        function confirmarAgregarCliente(formId) {
            Swal.fire({
                title: "¿Está seguro?",
                text: "¿Desea agregar este cliente?",
                icon: "question",
                showCancelButton: true,
                confirmButtonText: "Sí, agregar",
                cancelButtonText: "No, cancelar",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById(formId).submit();
                    Swal.fire(
                        "¡Agregado!",
                        "El cliente ha sido agregado exitosamente.",
                        "success"
                    );
                }
            });
        }

        function toggleFields() {
            const tipoCliente = document.getElementById("typePerson").value;
            const personaNaturalFields = document.getElementById("personaNaturalFields");
            const personaJuridicaFields = document.getElementById("personaJuridicaFields");

            if (tipoCliente === "NATURAL") {
                personaNaturalFields.style.display = "block";
                personaJuridicaFields.style.display = "none";
            } else if (tipoCliente === "JURIDICA") {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "block";
            } else {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "none";
            }
        }

        function toggleEditForm(clientId) {
            // Toggle display of the edit form modal
            const editModal = document.getElementById('editClientModal_' + clientId);
            editModal.style.display = editModal.style.display === 'none' ? 'block' : 'none';
        }

        function submitEditForm(formId) {
            document.getElementById(formId).submit();
        }
    </script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos"><i class="fas fa-building me-2"></i> Cliente Natural inactivos</a></li>
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

    <!-- Contenido principal -->
    <div class="p-4 flex-grow-1 content">
        <h1>Clientes Jurídicos Activos</h1>
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addClientModal">Agregar Cliente</button>
<br>
        <!-- Modal para agregar cliente -->
        <div class="modal fade" id="addClientModal" tabindex="-1" role="dialog" aria-labelledby="addClientModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addClientModalLabel">Agregar Cliente</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="clientForm" onsubmit="event.preventDefault(); confirmarAgregarCliente('clientForm');" method="post" action="${pageContext.request.contextPath}/agregarCliente">
                            <div class="form-group">
                                <label for="typePerson">Tipo de Persona</label>
                                <select id="typePerson" name="typePerson" class="form-control" onchange="toggleFields()" required>
                                    <option value="">Seleccione</option>
                                    <option value="NATURAL">Natural</option>
                                    <option value="JURIDICA">Jurídica</option>
                                </select>
                            </div>

                            <!-- Sección de campos para Cliente Natural -->
                            <div id="personaNaturalFields" style="display:none;">
                                <h5>Datos de Cliente Natural</h5>
                                <div class="form-group">
                                    <label for="name">Nombre:</label>
                                    <input type="text" name="name" id="name" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Apellido:</label>
                                    <input type="text" name="lastName" id="lastName" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                </div>
                                <div class="form-group">
                                    <label for="documentType">Tipo de Documento:</label>
                                    <select name="documentType" class="form-control" id="documentType" >
                                        <option value="">Seleccione</option>
                                        <option value="DNI">DNI</option>
                                        <option value="CNE">CE</option>
                                        <option value="Pasaporte">Pasaporte</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="documentNumber">N° Documento:</label>
                                    <input type="text" name="documentNumber" id="documentNumber" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                </div>
                                <div class="form-group">
                                    <label for="birthdate">F. Nacimiento:</label>
                                    <input type="date" name="birthdate" id="birthdate" class="form-control" >
                                </div>
                                <div class="form-group">
                                    <label for="persona_email">Email:</label>
                                    <input type="email" name="persona_email" id="persona_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                </div>
                                <div class="form-group">
                                    <label for="persona_phone">Teléfono:</label>
                                    <input type="text" name="persona_phone" id="persona_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                </div>
                                <!-- Nuevos campos para la dirección -->
                                <div class="form-group">
                                    <label for="persona_address">Dirección:</label>
                                    <input type="text" name="persona_address" id="persona_address" class="form-control" >
                                </div>
                            </div>

                            <!-- Sección de campos para Cliente Jurídico -->
                            <div id="personaJuridicaFields" style="display:none;">
                                <h5>Datos de Cliente Jurídico</h5>
                                <div class="form-group">
                                    <label for="companyName">Razón Social:</label>
                                    <input type="text" name="companyName" id="companyName" class="form-control" >
                                </div>
                                <div class="form-group">
                                    <label for="ruc">RUC:</label>
                                    <input type="text" name="ruc" id="ruc" class="form-control"  pattern="\d{11}" title="Debe tener 11 dígitos">
                                </div>

                                <div class="form-group">
                                    <label for="juridica_email">Email:</label>
                                    <input type="email" name="juridica_email" id="juridica_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                </div>
                                <div class="form-group">
                                    <label for="juridica_phone">Teléfono:</label>
                                    <input type="text" name="juridica_phone" id="juridica_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                </div>
                                <!-- Nuevos campos para la dirección -->
                                <div class="form-group">
                                    <label for="juridica_address">Dirección:</label>
                                    <input type="text" name="juridica_address" id="juridica_address" class="form-control" >
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Agregar Cliente</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <table class="table table-striped">
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
            <c:forEach var="cliente" items="${personasJuridicas}">
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
                        <button type="button" class="btn btn-primary" onclick="toggleEditForm(${cliente.id})">Editar</button>

                        <form id="deleteForm_${cliente.id}" action="${pageContext.request.contextPath}/eliminarCliente" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${cliente.id}">
                            <button type="button" class="btn btn-danger" onclick="confirmarEliminacion(${cliente.id})">Eliminar</button>
                        </form>


                        <!-- Edit client modal -->
                        <div id="editClientModal_${cliente.id}" class="modal" style="display:none;">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Editar Cliente Jurídico</h5>
                                        <button type="button" class="btn-close" onclick="toggleEditForm(${cliente.id})"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="clientForm" onsubmit="event.preventDefault(); confirmarAgregarCliente('clientForm');" method="post" action="${pageContext.request.contextPath}/agregarCliente">
                                            <div class="form-group">
                                                <label for="typePerson">Tipo de Persona</label>
                                                <select id="typePerson" name="typePerson" class="form-control" onchange="toggleFields()" required>
                                                    <option value="">Seleccione</option>
                                                    <option value="NATURAL">Natural</option>
                                                    <option value="JURIDICA">Jurídica</option>
                                                </select>
                                            </div>

                                            <!-- Sección de campos para Cliente Natural -->
                                            <div id="personaNaturalFields" style="display:none;">
                                                <h5>Datos de Cliente Natural</h5>
                                                <div class="form-group">
                                                    <label for="name">Nombre:</label>
                                                    <input type="text" name="name" id="name" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                </div>
                                                <div class="form-group">
                                                    <label for="lastName">Apellido:</label>
                                                    <input type="text" name="lastName" id="lastName" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                </div>
                                                <div class="form-group">
                                                    <label for="documentType">Tipo de Documento:</label>
                                                    <select name="documentType" class="form-control" id="documentType" >
                                                        <option value="">Seleccione</option>
                                                        <option value="DNI">DNI</option>
                                                        <option value="CNE">CE</option>
                                                        <option value="Pasaporte">Pasaporte</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="documentNumber">N° Documento:</label>
                                                    <input type="text" name="documentNumber" id="documentNumber" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                </div>
                                                <div class="form-group">
                                                    <label for="birthdate">F. Nacimiento:</label>
                                                    <input type="date" name="birthdate" id="birthdate" class="form-control"  onchange="validateAge()">
                                                </div>
                                                <div class="form-group">
                                                    <label for="persona_email">Email:</label>
                                                    <input type="email" name="persona_email" id="persona_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                                </div>
                                                <div class="form-group">
                                                    <label for="persona_phone">Teléfono:</label>
                                                    <input type="text" name="persona_phone" id="persona_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                </div>
                                                <!-- Nuevos campos para la dirección -->
                                                <div class="form-group">
                                                    <label for="persona_address">Dirección:</label>
                                                    <input type="text" name="persona_address" id="persona_address" class="form-control" >
                                                </div>
                                            </div>

                                            <!-- Sección de campos para Cliente Jurídico -->
                                            <div id="personaJuridicaFields" style="display:none;">
                                                <h5>Datos de Cliente Jurídico</h5>
                                                <div class="form-group">
                                                    <label for="companyName">Razón Social:</label>
                                                    <input type="text" name="companyName" id="companyName" class="form-control" >
                                                </div>
                                                <div class="form-group">
                                                    <label for="ruc">RUC:</label>
                                                    <input type="text" name="ruc" id="ruc" class="form-control"  pattern="\d{11}" title="Debe tener 11 dígitos">
                                                </div>
                                                <div class="form-group">
                                                    <label for="juridica_contact">Persona de Contacto:</label>
                                                    <input type="text" name="juridica_contact" id="juridica_contact" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                </div>
                                                <div class="form-group">
                                                    <label for="juridica_email">Email:</label>
                                                    <input type="email" name="juridica_email" id="juridica_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                                </div>
                                                <div class="form-group">
                                                    <label for="juridica_phone">Teléfono:</label>
                                                    <input type="text" name="juridica_phone" id="juridica_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                </div>
                                                <!-- Nuevos campos para la dirección -->
                                                <div class="form-group">
                                                    <label for="juridica_address">Dirección:</label>
                                                    <input type="text" name="juridica_address" id="juridica_address" class="form-control" >
                                                </div>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Agregar Cliente</button>
                                        </form>
                                    </div>


                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" onclick="toggleEditForm(${cliente.id})">Cancelar</button>
                                        <button type="button" class="btn btn-primary" onclick="submitEditForm('editForm_${cliente.id}')">Guardar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script>
    function validateAge() {
        const birthdateInput = document.getElementById("birthdate");
        const birthdate = new Date(birthdateInput.value);
        const today = new Date();
        let age = today.getFullYear() - birthdate.getFullYear();
        const monthDiff = today.getMonth() - birthdate.getMonth();

        // Si la fecha de cumpleaños es mayor que la fecha actual, resta un año
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthdate.getDate())) {
            age--;
        }

        // Verificar si la persona tiene menos de 18 años
        if (age < 18) {
            alert("Debes ser mayor de 18 años.");
            birthdateInput.value = ""; // Limpia el campo
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
