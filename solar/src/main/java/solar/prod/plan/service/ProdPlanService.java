package solar.prod.plan.service;

import java.util.List;

import solar.sales.order.dao.ModifyVO;

public interface ProdPlanService {
	
	//생산계획 조회
	List<ProdPlanVO> selectPlan(ProdPlanVO ppVo);

	/*
	 * //생산계획 등록 int insertPlan(ProdPlanVO ppVo);
	 * 
	 * //생산계획 수정 int updatePlan(ProdPlanVO ppVo);
	 * 
	 * //생산계획 삭제 int deletePlan(ProdPlanVO ppVo);
	 */
	//modify
	int modifyData(ModifyVO<ProdPlanVO> mvo);
	
	//검색모달
	List<ProdPlanVO> findProdPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> searchPlan(ProdPlanVO ppVo);
	List<ProdPlanVO> findOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> searchOrder(ProdPlanVO ppVo);
	List<ProdPlanVO> findCoCd(ProdPlanVO ppVo);
	List<ProdPlanVO> findPrdtCd(ProdPlanVO ppVo);

	List<?> selectPstc(ProdPlanVO ppVo);

	List<?> selectRstc(ProdPlanVO ppVo);
}
