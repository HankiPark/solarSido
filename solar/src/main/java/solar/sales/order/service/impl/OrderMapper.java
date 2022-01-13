package solar.sales.order.service.impl;

import java.util.List;

import solar.sales.order.dao.Order;

public interface OrderMapper {
	List<Order> find(Order order);
	List<Order> findDetail(Order order);
	int inStcUpdate(Order order);
}
