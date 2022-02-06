package solar.sales.order.service.impl;

import java.util.List;

import solar.sales.order.dao.CalenderVO;
import solar.sales.order.dao.Order;

public interface OrderMapper {
	List<Order> find(Order order);
	List<Order> findDetail(Order order);
	List<CalenderVO> orderCal();
	List<CalenderVO> inPrdtCal();
	List<CalenderVO> outPrdtCal();
	int inStcUpdate(Order order);
}
