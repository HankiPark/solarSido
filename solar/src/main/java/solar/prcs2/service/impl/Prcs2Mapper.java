package solar.prcs2.service.impl;

import java.util.List;

import solar.prcs2.dao.EqmAble;
import solar.prcs2.dao.Prcs2;

public interface Prcs2Mapper {
	List<Prcs2> searchPlanList(Prcs2 vo);
	int insertData(Prcs2 vo);
	int insertDetail(Prcs2 vo);
	int insertDetailO(Prcs2 vo);
	List<Prcs2> findTemp();
	List<Prcs2> listPrcs(Prcs2 vo);
	List<EqmAble> ableEqm(EqmAble vo);
	int updatePEqm(EqmAble vo);
	int updateYEqm(EqmAble vo);
	int insertMid(Prcs2 vo);
	int updateFr(Prcs2 vo);
	int updateTo(Prcs2 vo);
	int updateFg(Prcs2 vo);
	int completePrcs();
	int inPrdt(Prcs2 vo);
	double random();
	
}
