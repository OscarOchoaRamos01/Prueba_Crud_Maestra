package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.Dto.SupplierDto;
import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.SupplierService;
import pe.edu.vallegrande.service.SparePartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Registrar_Compras")
public class PurchasePageController extends HttpServlet {
    private SupplierService supplierService = new SupplierService();
    private SparePartService sparePartService = new SparePartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cargar proveedores y repuestos
        List<SupplierDto> suppliers = supplierService.getSuppliers();
        List<SparePartDto> spareParts = sparePartService.getSpareParts();


        // Enviar datos al JSP
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("spareParts", spareParts);

        // Despachar al JSP
        request.getRequestDispatcher("purcharse.jsp").forward(request, response);
    }
}
