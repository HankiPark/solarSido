package solar.sales.order.service.impl;

import java.util.List;

import solar.sales.order.dao.CalendarVO;
import solar.sales.order.dao.Order;

public interface OrderMapper {
	List<Order> find(Order order);
	List<Order> findDetail(Order order);
	List<CalendarVO> orderCal();
	List<CalendarVO> orderEndCal();
	List<CalendarVO> inPrdtCal();
	List<CalendarVO> outPrdtCal();
	List<CalendarVO> rscCal();
	List<CalendarVO> prodCal();
	List<CalendarVO> eqmCal();
	List<CalendarVO> eqmEndCal();
	int inStcUpdate(Order order);
}
