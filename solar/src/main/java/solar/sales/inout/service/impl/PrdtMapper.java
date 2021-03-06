package solar.sales.inout.service.impl;

import java.util.List;

import solar.sales.inout.dao.Prdt;
import solar.sales.order.dao.ModifyVO;

public interface PrdtMapper {
	List<Prdt> findList(Prdt vo);
	List<Prdt> findPrdt(Prdt vo);
	List<Prdt> findSlip(Prdt vo);
	List<Prdt> OutOrderList(Prdt vo);
	List<Prdt> OutOrderCdList(Prdt vo);
	List<Prdt> OutWaitList(Prdt vo);
	List<Prdt> findSlipList(Prdt vo);
	List<Prdt> findSlipLot(Prdt vo);
	List<Prdt> prdtSearch(Prdt vo);
	List<Prdt> prdtChart(Prdt vo);
	List<Prdt> prdtList(Prdt vo);
	List<Prdt> co();
	
	
	List<Prdt> findCo(Prdt vo);
	int inPrdt(Prdt vo);
	int modifyData(ModifyVO<Prdt> mvo);
	int insertInPrdt(Prdt vo);
	int updateInPrdt(Prdt vo);
	int deleteInPrdt(Prdt vo);
	int insertOutPrdt(Prdt vo);
	int endOrder(Prdt vo);
	int slipNoAdd(Prdt vo);

	int deleteOutPrdt(Prdt vo);
	int updateStatePrdt(Prdt vo);
	int modifyOutData(ModifyVO<Prdt> mvo);
	int resetOw(Prdt vo);
	int insertOw(Prdt vo);
	int insertOutD(Prdt vo);
	int updOrd(Prdt vo);
	int inStcUpdate(Prdt vo);
	
	
	int tempUpdStc(Prdt vo);
	String makeNum();
	
}
