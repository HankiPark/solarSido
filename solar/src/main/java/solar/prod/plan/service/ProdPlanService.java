package solar.prod.plan.service;

import java.util.List;
import java.util.Map;

public interface ProdPlanService {
	List<ProdPlanVO> searchProdPlan(Map<String, Object> param);
	int insertProdPlan(ProdPlanVO vo); 
	int updateProdPlan(ProdPlanVO vo);
	int deleteProdPlan(String ProdPlanCode);
	int deleteProdPlanD(int planDetaNo);
	int deleteAllProdPlanD(String ProdPlanCode);
}
