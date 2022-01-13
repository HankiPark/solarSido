package solar.sales.order.service;

import java.util.List;

import solar.sales.order.dao.Order;


public interface OrderService {
	List<Order> find(Order order);
	List<Order> findDetail(Order order);
	int inStcUpdate(Order order);
}
