package solar.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import solar.sales.order.dao.GridVO;

import solar.sales.order.dao.Order;
import solar.sales.order.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired OrderMapper omapper;
	
	@Override
	public List<Order> find() {
		
		return omapper.find();
	}

	@Override
	public List<Order> findDetail(Order order) {
		// TODO Auto-generated method stub
		return omapper.findDetail(order);
	}

	public Order produceCommandUpdate(GridVO gridData) {
		
		return null;
	}
	

} 
