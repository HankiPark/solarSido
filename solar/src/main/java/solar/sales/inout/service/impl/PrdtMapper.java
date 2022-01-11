package solar.sales.inout.service.impl;

import java.util.List;

import solar.sales.inout.dao.Prdt;

public interface PrdtMapper {
	List<Prdt> findList(Prdt vo);
	List<Prdt> findPrdt(Prdt vo);
}
