package solar.sales.inout.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.sales.inout.dao.Prdt;
import solar.sales.inout.service.PrdtService;
import solar.sales.order.dao.GridVO;

@Service
public class PrdtServiceImpl implements PrdtService{

	@Autowired PrdtMapper pmapper;

	@Override
	public List<Prdt> findList(Prdt vo) {
		
		return pmapper.findList(vo);
	}

	@Override
	public List<Prdt> findPrdt(Prdt vo) {
		return pmapper.findPrdt(vo);
	}
}
