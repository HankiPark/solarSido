package solar.prod.plan.service.impl;

import java.util.List;
import java.util.Map;

import solar.prod.plan.service.ProdPlanVO;

public interface ProdPlanMapper {
	List<ProdPlanVO> searchProdPlan(Map<String, Object> param);
	int insertProdPlan(ProdPlanVO vo); 
	int updateProdPlan(ProdPlanVO vo);
	int deleteProdPlan(String ProdPlanCode);
	int deleteProdPlanD(int planDetaNo);
	int deleteAllProdPlanD(String ProdPlanCode);
}
