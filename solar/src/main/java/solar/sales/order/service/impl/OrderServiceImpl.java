package solar.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.sales.order.dao.CalenderVO;
import solar.sales.order.dao.Order;
import solar.sales.order.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired OrderMapper omapper;
	
	@Override
	public List<Order> find(Order order) {
		
		return omapper.find(order);
	}

	@Override
	public List<Order> findDetail(Order order) {
		return omapper.findDetail(order);
	}

	@Override
	public int inStcUpdate(Order order) {
		
		return omapper.inStcUpdate(order);
	}



	@Override
	public List<CalenderVO> orderCal() {
		return omapper.orderCal();
	}

	@Override
	public List<CalenderVO> inPrdtCal() {
		return omapper.inPrdtCal();
	}
	@Override
	public List<CalenderVO> outPrdtCal() {
		return omapper.outPrdtCal();
	}

	@Override
	public List<CalenderVO> rscCal() {
		return omapper.rscCal();
	}

	@Override
	public List<CalenderVO> prodCal() {
		return omapper.prodCal();
	}

} 
