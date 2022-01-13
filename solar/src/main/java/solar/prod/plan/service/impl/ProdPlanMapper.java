package solar.prod.plan.service.impl;

import java.util.List;

import solar.prod.plan.service.ProdPlanVO;

public interface ProdPlanMapper {
	List<ProdPlanVO> selectPlan(ProdPlanVO ppVo);
}
