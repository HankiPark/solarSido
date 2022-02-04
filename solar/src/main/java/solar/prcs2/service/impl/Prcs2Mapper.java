package solar.prcs2.service.impl;

import java.util.List;

import solar.prcs2.dao.Prcs2;

public interface Prcs2Mapper {
	List<Prcs2> searchPlanList(Prcs2 vo);
	int insertData(Prcs2 vo);
	int insertDetail(Prcs2 vo);
}
