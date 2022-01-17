package solar.sales.order.dao;

import java.util.List;

import lombok.Data;

@Data
public class ModifyVO<T> {
	List<T> createdRows;
	List<T> updatedRows;
	List<T> deletedRows;
	List<T> rows;
}
