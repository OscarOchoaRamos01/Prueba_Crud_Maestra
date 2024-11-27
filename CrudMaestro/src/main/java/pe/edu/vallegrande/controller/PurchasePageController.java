package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.service.PurchaseService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Compras")
public class PurchasePageController extends HttpServlet {

    private PurchaseService purchaseService = new PurchaseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener todas las compras
        List<PurcharseDto> purchases = purchaseService.listarCompras();

        // Pasar los datos al JSP
        request.setAttribute("purchases", purchases);

        // Despachar al JSP
        request.getRequestDispatcher("purchase.jsp").forward(request, response);
    }
}
