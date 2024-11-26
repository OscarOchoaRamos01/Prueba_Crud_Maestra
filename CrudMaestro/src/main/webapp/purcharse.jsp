<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <!DOCTYPE html>
    <html lang="es">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Registrar Compra</title>
      <!-- Bootstrap CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
      <style>
        .form-group {
          margin-bottom: 1.25rem;
        }

        .card-body {
          padding: 1.5rem;
        }

        .table th,
        .table td {
          text-align: center;
        }

        body {
          background-color: #fdfdf6;
        }
      </style>
    </head>

    <body>
      <div class="container mt-5">
        <h2 class="mb-4">Registrar Compra</h2>
        <form id="purchaseForm">
          <div class="row">
            <!-- Selección del Proveedor -->
            <div class="col-md-6">
              <div class="card">
                <div class="card-body">
                  <div class="form-group">
                    <label for="supplier">Proveedor</label>
                    <select id="supplier" name="supplierId" class="form-select" required>
                      <option value="">Seleccione un proveedor</option>
                      <c:forEach var="supplier" items="${suppliers}">
                        <option value="${supplier.id}">${supplier.company}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="paymentMethod">Método de Pago</label>
                    <select id="paymentMethod" name="paymentMethod" class="form-select" required>
                      <option value="Efectivo">Efectivo</option>
                      <option value="Tarjeta">Tarjeta</option>
                      <option value="Transferencia">Transferencia</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>

            <!-- Selección de Productos -->
            <div class="col-md-6">
              <div class="card">
                <div class="card-body">
                  <div class="form-group">
                    <label for="product">Producto</label>
                    <select id="product" class="form-select">
                      <option value="">Seleccione un producto</option>
                      <c:forEach var="sparePart" items="${spareParts}">
                        <option value="${sparePart.id}" data-name="${sparePart.name}"
                          data-price="${sparePart.priceUnit}">
                          ${sparePart.name} - ${sparePart.brand}
                        </option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="quantity">Cantidad</label>
                    <input type="number" id="quantity" class="form-control" min="1" placeholder="Cantidad">
                  </div>
                  <button type="button" class="btn btn-primary mt-3" onclick="addProduct()">Agregar Producto</button>
                </div>
              </div>
            </div>
          </div>

          <!-- Botón Ver Carrito -->
          <div class="mt-4">
            <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#cartModal">Ver Carrito de
              Compras</button>
          </div>
        </form>
      </div>

      <!-- Modal -->
      <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="cartModalLabel">Carrito de Compras</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <table class="table table-bordered" id="purchaseDetailsTable">
                <thead>
                  <tr>
                    <th>Producto</th>
                    <th>Precio Unitario</th>
                    <th>Cantidad</th>
                    <th>Subtotal</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- La tabla se llenará dinámicamente -->
                </tbody>
              </table>
              <div class="d-flex justify-content-between mt-3">
                <h5>Total: S/. <span id="totalAmount">0</span></h5>
                <h5>Descuento (18% IGV): S/. <span id="discount">0</span></h5>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
              <button type="button" class="btn btn-success" onclick="submitForm()">Registrar Compra</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Bootstrap JS -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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

          if (!productId || !quantity || quantity <= 0) {
            alert("Seleccione un producto y una cantidad válida.");
            return;
          }

          const subtotal = priceUnit * quantity;
          totalAmount += subtotal;

          const tableBody = document.getElementById("purchaseDetailsTable").querySelector("tbody");

          const row = `
      <tr>
        <td>${productName}</td>
        <td>S/. ${priceUnit.toFixed(2)}</td>
        <td>${quantity}</td>
        <td>S/. ${subtotal.toFixed(2)}</td>
        <td>
          <button type="button" class="btn btn-danger btn-sm" onclick="removeProduct(this, ${subtotal})">Eliminar</button>
        </td>
      </tr>
    `;
          tableBody.insertAdjacentHTML("beforeend", row);

          selectedProducts.push({ productId, productName, quantity, subtotal });
          console.log("Productos en memoria:", selectedProducts);

          updateTotals();

          productSelect.value = "";
          quantityInput.value = "";
        }

        function removeProduct(button, subtotal) {
          button.closest("tr").remove();
          totalAmount -= subtotal;
          updateTotals();
        }

        function updateTotals() {
          const discount = totalAmount * 0.18;
          document.getElementById("totalAmount").textContent = totalAmount.toFixed(2);
          document.getElementById("discount").textContent = discount.toFixed(2);
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
            totalAmount,
            discount: totalAmount * 0.18,
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