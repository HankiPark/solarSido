package solar.prod.plan.service;

import java.util.List;
import java.util.Map;

import solar.sales.order.dao.ModifyVO;

public interface ProdPlanService {
	
	//생산계획 조회
	List<ProdPlanVO> selectPlan(ProdPlanVO ppVo);
	List<?> selectRstc(ProdPlanVO ppVo);
	
	//검색모달
	List<ProdPlanVO> findProdPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> searchPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> findOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> searchOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> findCoCd(ProdPlanVO ppVo);
	List<ProdPlanVO> findPrdtCd(ProdPlanVO ppVo);

	//modify
	int modifyData(ModifyVO<ProdPlanVO> mvo);
	int planDmndData(Map<String, List<ProdPlanVO>> map);	
}
