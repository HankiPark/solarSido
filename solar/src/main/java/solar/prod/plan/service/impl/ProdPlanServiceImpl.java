package solar.prod.plan.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;

@Service
public class ProdPlanServiceImpl implements ProdPlanService {

	@Autowired ProdPlanMapper mapper;

	@Override
	public List<ProdPlanVO> searchProdPlan(Map<String, Object> param) {
		return null;
	}

	@Override
	public int insertProdPlan(ProdPlanVO vo) {
		return 0;
	}

	@Override
	public int updateProdPlan(ProdPlanVO vo) {
		return 0;
	}

	@Override
	public int deleteProdPlan(String ProdPlanCode) {
		return 0;
	}

	@Override
	public int deleteProdPlanD(int planDetaNo) {
		return 0;
	}

	@Override
	public int deleteAllProdPlanD(String ProdPlanCode) {
		return 0;
	}
	
	
	
}
