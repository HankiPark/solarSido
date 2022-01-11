package solar.sales.inout.service;

import java.util.List;

import solar.sales.inout.dao.Prdt;

public interface PrdtService {
	List<Prdt> findList(Prdt vo);
	List<Prdt> findPrdt(Prdt vo);
}
