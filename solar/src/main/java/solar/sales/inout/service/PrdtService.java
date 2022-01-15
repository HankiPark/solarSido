package solar.sales.inout.service;

import java.util.List;

import solar.sales.inout.dao.Prdt;
import solar.sales.order.dao.ModifyVO;

public interface PrdtService {
	List<Prdt> findList(Prdt vo);
	List<Prdt> findPrdt(Prdt vo);
	List<Prdt> findSlip(Prdt vo);

	//List<Prdt> findCo();
	int inPrdt(Prdt vo);
	int modifyData(ModifyVO<Prdt> mvo);
	int modifyOutData(ModifyVO<Prdt> mvo);
	String makeNum();
}
	