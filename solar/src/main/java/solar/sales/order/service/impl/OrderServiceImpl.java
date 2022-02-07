package solar.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.sales.order.dao.CalendarVO;
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
	public List<CalendarVO> orderCal() {
		return omapper.orderCal();
	}

	@Override
	public List<CalendarVO> inPrdtCal() {
		return omapper.inPrdtCal();
	}
	@Override
	public List<CalendarVO> outPrdtCal() {
		return omapper.outPrdtCal();
	}

	@Override
	public List<CalendarVO> rscCal() {
		return omapper.rscCal();
	}

	@Override
	public List<CalendarVO> prodCal() {
		return omapper.prodCal();
	}

	@Override
	public List<CalendarVO> eqmCal() {
		return omapper.eqmCal();
	}

	@Override
	public List<CalendarVO> eqmEndCal() {
		return omapper.eqmEndCal();
	}

	@Override
	public List<CalendarVO> orderEndCal() {
		return omapper.orderEndCal();
	}

} 
