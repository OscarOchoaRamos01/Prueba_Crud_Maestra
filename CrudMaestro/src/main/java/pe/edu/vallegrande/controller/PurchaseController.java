package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.service.PurcharseDetailService;
import pe.edu.vallegrande.service.PurchaseService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ComprasDetalles")
public class PurchaseController extends HttpServlet {

    private PurchaseService purchaseService = new PurchaseService();
    private PurcharseDetailService purcharseDetailService = new PurcharseDetailService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json; charset=UTF-8"); // Establecer UTF-8
        response.setCharacterEncoding("UTF-8");

        try {
            // Leer el ID de la compra desde el cuerpo de la solicitud
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }

            Gson gson = new Gson();
            JsonObject jsonRequest = gson.fromJson(sb.toString(), JsonObject.class);
            int purchaseId = jsonRequest.get("id").getAsInt();

            // Obtener datos generales de la compra
            PurcharseDto purchase = purchaseService.getPurchaseById(purchaseId);
            if (purchase == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Compra no encontrada.");
                return;
            }

            // Obtener detalles de la compra
            List<PurcharseDetailDto> details = purcharseDetailService.getPurchaseDetailsByPurchaseId(purchaseId);

            // Crear respuesta JSON
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.add("purchase", gson.toJsonTree(purchase));
            jsonResponse.add("details", gson.toJsonTree(details));

            response.getWriter().write(gson.toJson(jsonResponse));

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error al obtener los datos: " + e.getMessage());
        }
    }
}