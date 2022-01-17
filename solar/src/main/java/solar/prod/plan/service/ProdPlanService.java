package solar.prod.plan.service;

import java.util.List;

import solar.sales.order.dao.ModifyVO;

public interface ProdPlanService {
	
	//생산계획 조회
	List<ProdPlanVO> selectPlan(ProdPlanVO ppVo);
	
	//생산계획 등록
	int insertPlan(ModifyVO<ProdPlanVO> pplist);
	
	//생산계획 삭제
	int deletePlan(ModifyVO<ProdPlanVO> pplist);
	
	//검색모달
	List<ProdPlanVO> findProdPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> searchPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> findOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> searchOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> findCoCd(ProdPlanVO ppVo);
	List<ProdPlanVO> findPrdtCd(ProdPlanVO ppVo);
}
