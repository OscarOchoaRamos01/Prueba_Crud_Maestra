package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.service.PurcharseDetailService;

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
public class PurchaseDetailController extends HttpServlet {
    private PurcharseDetailService purchaseService = new PurcharseDetailService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            System.out.println("Procesando solicitud POST...");

            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            System.out.println("JSON recibido: " + json.toString());

            Gson gson = new Gson();
            JsonObject data = gson.fromJson(json.toString(), JsonObject.class);

            PurcharseDto purchaseDto = new PurcharseDto();
            purchaseDto.setSupplierId(data.get("supplierId").getAsInt());
            purchaseDto.setPaymentMethod(data.get("paymentMethod").getAsString());
            purchaseDto.setTotalAmount(new BigDecimal(data.get("totalAmount").getAsString()));
            purchaseDto.setDate(new Date(System.currentTimeMillis()));
            purchaseDto.setStatus("A");

            List<PurcharseDetailDto> details = new ArrayList<>();
            JsonArray products = data.getAsJsonArray("products");

            for (JsonElement element : products) {
                JsonObject product = element.getAsJsonObject();
                PurcharseDetailDto detail = new PurcharseDetailDto();
                detail.setSparePartsId(product.get("productId").getAsInt());
                detail.setQuantity(product.get("quantity").getAsInt());
                detail.setPriceUnit(new BigDecimal(product.get("priceUnit").getAsString()));
                detail.setSubtotal(new BigDecimal(product.get("subtotal").getAsString()));
                details.add(detail);
            }

            System.out.println("Cabecera de compra: " + purchaseDto);
            System.out.println("Detalles de compra: " + details);

            boolean success = purchaseService.registrarCompra(purchaseDto, details);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}


