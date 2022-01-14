package solar.prod.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;

@Service
public class ProdPlanServiceImpl implements ProdPlanService {

	@Autowired ProdPlanMapper ppMapper;

	//생산계획조회
	@Override
	public List<ProdPlanVO> selectPlan(ProdPlanVO ppVo) {
		return ppMapper.selectPlan(ppVo);
	}

	
}
