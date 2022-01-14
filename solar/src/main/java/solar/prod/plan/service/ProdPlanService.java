package solar.prod.plan.service;

import java.util.List;

public interface ProdPlanService {
	
	//생산계획 조회
	List<ProdPlanVO> selectPlan(ProdPlanVO ppVo);
}
