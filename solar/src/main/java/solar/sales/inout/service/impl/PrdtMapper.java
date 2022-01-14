package solar.sales.inout.service.impl;

import java.util.List;

import solar.sales.inout.dao.Prdt;
import solar.sales.order.dao.ModifyVO;

public interface PrdtMapper {
	List<Prdt> findList(Prdt vo);
	List<Prdt> findPrdt(Prdt vo);
	List<Prdt> findCo();
	int inPrdt(Prdt vo);
	int modifyData(ModifyVO<Prdt> mvo);
	int insertInPrdt(Prdt vo);
	int updateInPrdt(Prdt vo);
	int deleteInPrdt(Prdt vo);
	int insertOutPrdt(Prdt vo);
	int updateOutPrdt(Prdt vo);
	int deleteOutPrdt(Prdt vo);
	int updateStatePrdt(Prdt vo);
	int modifyOutData(ModifyVO<Prdt> mvo);
	String makeNum();
}
