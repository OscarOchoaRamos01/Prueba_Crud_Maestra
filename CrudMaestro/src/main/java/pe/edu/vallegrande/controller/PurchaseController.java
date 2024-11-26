package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.service.PurcharseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/RegistrarCompra")
public class PurchaseController extends HttpServlet {
    private PurcharseService purchaseService = new PurcharseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Leer datos JSON del cuerpo de la solicitud
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            // Convertir JSON a objetos
            Gson gson = new Gson();
            JsonObject data = gson.fromJson(json.toString(), JsonObject.class);

            // Procesar cabecera de la compra
            PurcharseDto purcharseDto = new PurcharseDto();
            purcharseDto.setSupplierId(data.get("supplierId").getAsInt());
            purcharseDto.setPaymentMethod(data.get("paymentMethod").getAsString());
            purcharseDto.setTotalAmount(new BigDecimal(data.get("totalAmount").getAsString()));
            purcharseDto.setDiscount(new BigDecimal(data.get("discount").getAsString()));
            purcharseDto.setDate(new Date(System.currentTimeMillis())); // Fecha del sistema
            purcharseDto.setStatus("COMPLETED");

            // Procesar detalles de la compra
            List<PurcharseDetailDto> details = new ArrayList<>();
            JsonArray products = data.getAsJsonArray("products");

            for (JsonElement element : products) {
                JsonObject product = element.getAsJsonObject();
                PurcharseDetailDto detail = new PurcharseDetailDto();
                detail.setSparePartsId(product.get("productId").getAsInt());
                detail.setQuantity(product.get("quantity").getAsInt());
                detail.setSubtotal(new BigDecimal(product.get("subtotal").getAsString()));
                details.add(detail);
            }

            // Registrar compra
            boolean success = purchaseService.registrarCompra(purcharseDto, details);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

