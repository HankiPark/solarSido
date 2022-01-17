package solar.prod.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prod.plan.service.ProdPlanService;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Service
public class ProdPlanServiceImpl implements ProdPlanService {

	@Autowired ProdPlanMapper ppMapper;

	@Override
	public List<ProdPlanVO> selectPlan(ProdPlanVO ppVo) {
		return ppMapper.selectPlan(ppVo);
	}

	@Override
	public int insertPlan(ModifyVO<ProdPlanVO> pplist) {
		/*
		 * for(ProdPlanVO ppVo : pplist.getDeletedRows()){ ppMapper.insertPlanD(ppVo);
		 * } ppMapper.insertPlan(pplist.getUpdatedRows().get(0));
		 */
		return 1;
	}

	@Override
	public int deletePlan(ModifyVO<ProdPlanVO> pplist) {
		/*
		 * for(ProdPlanVO ppVo : pplist.getDeletedRows()){ ppMapper.deletePlan(ppVo); }
		 */
		return 1;
	}
	
	@Override
	public List<ProdPlanVO> findProdPlan(ProdPlanVO ppVo) {
		return ppMapper.findProdPlan(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> searchPlan(ProdPlanVO ppVo) {
		return ppMapper.searchPlan(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> searchOrder(ProdPlanVO ppVo) {
		return ppMapper.searchOrder(ppVo);
	}
	
	@Override
	public List<ProdPlanVO> findCoCd(ProdPlanVO ppVo) {
		return ppMapper.findCoCd(ppVo);
	}

	@Override
	public List<ProdPlanVO> findPrdtCd(ProdPlanVO ppVo) {
		return ppMapper.findPrdtCd(ppVo);
	}
	
}
