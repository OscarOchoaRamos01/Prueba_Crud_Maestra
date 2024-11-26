package pe.edu.vallegrande.service;

import lombok.var;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.db.AccesoDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class PurcharseService {
    public boolean registrarCompra(PurcharseDto purcharseDto, List<PurcharseDetailDto> details) {
        Connection con = null;
        PreparedStatement psCabecera = null;
        PreparedStatement psDetalle = null;
        boolean isSuccess = false;

        try {
            con = AccesoDB.getConnection();
            con.setAutoCommit(false); // Inicia la transacción

            // Inserta la cabecera de la compra
            String sqlCabecera = "INSERT INTO Purchase(date, total_amount, discount, payment_method, status, supplier_id) VALUES (?, ?, ?, ?, ?, ?)";
            psCabecera = con.prepareStatement(sqlCabecera, PreparedStatement.RETURN_GENERATED_KEYS);
            psCabecera.setDate(1, purcharseDto.getDate());
            psCabecera.setBigDecimal(2, purcharseDto.getTotalAmount());
            psCabecera.setBigDecimal(3, purcharseDto.getDiscount());
            psCabecera.setString(4, purcharseDto.getPaymentMethod());
            psCabecera.setString(5, purcharseDto.getStatus());
            psCabecera.setInt(6, purcharseDto.getSupplierId());
            psCabecera.executeUpdate();

            // Obtiene el ID generado de la cabecera
            var rs = psCabecera.getGeneratedKeys();
            int purchaseId = 0;
            if (rs.next()) {
                purchaseId = rs.getInt(1);
            }

            // Inserta los detalles de la compra
            String sqlDetalle = "INSERT INTO Purchase_Detail(quantity, subtotal, purchase_id, spare_parts_id) VALUES (?, ?, ?, ?)";
            psDetalle = con.prepareStatement(sqlDetalle);

            for (PurcharseDetailDto detail : details) {
                psDetalle.setInt(1, detail.getQuantity());
                psDetalle.setBigDecimal(2, detail.getSubtotal());
                psDetalle.setInt(3, purchaseId);
                psDetalle.setInt(4, detail.getSparePartsId());
                psDetalle.addBatch();
            }

            psDetalle.executeBatch();

            // Actualiza el stock de los repuestos
            String sqlActualizarStock = "UPDATE spare_parts SET stock = stock + ? WHERE id = ?";
            psDetalle = con.prepareStatement(sqlActualizarStock);

            for (PurcharseDetailDto detail : details) {
                psDetalle.setInt(1, detail.getQuantity());
                psDetalle.setInt(2, detail.getSparePartsId());
                psDetalle.addBatch();
            }

            psDetalle.executeBatch();

            con.commit();
            isSuccess = true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            try {
                if (psCabecera != null) psCabecera.close();
                if (psDetalle != null) psDetalle.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }
}
