package solar.prcs2.service;

import java.util.List;

import solar.prcs2.dao.Prcs2;
import solar.sales.order.dao.ModifyVO;

public interface Prcs2Service {
	List<Prcs2> searchPlanList(Prcs2 vo);
	int insertData(Prcs2 vo);
	int insertDetail(ModifyVO<Prcs2> mvo);
}
