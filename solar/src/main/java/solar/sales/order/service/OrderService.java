package solar.sales.order.service;

import java.util.List;

import solar.sales.order.dao.CalenderVO;
import solar.sales.order.dao.Order;


public interface OrderService {
	List<Order> find(Order order);
	List<Order> findDetail(Order order);
	List<CalenderVO> orderCal();
	List<CalenderVO> inPrdtCal();
	List<CalenderVO> outPrdtCal();
	List<CalenderVO> rscCal();
	List<CalenderVO> prodCal();
	int inStcUpdate(Order order);
}
