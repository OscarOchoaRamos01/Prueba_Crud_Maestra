package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import java.math.BigDecimal;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PurcharseDetailDto {
    private int id;
    private int quantity;
    private BigDecimal subtotal;
    private int purchaseId;
    private int sparePartsId;
}
