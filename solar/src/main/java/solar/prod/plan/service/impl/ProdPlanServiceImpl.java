package solar.prod.plan.service.impl;

import java.util.List;
import java.util.Map;

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
	public int modifyData(ModifyVO<ProdPlanVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(ProdPlanVO ppVo : mvo.getCreatedRows()) {
				System.out.println("등록:" + mvo);
				ppMapper.insertPlanD(ppVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(ProdPlanVO ppVo : mvo.getDeletedRows()) {
				System.out.println("삭제:" + mvo);
				ppMapper.deletePlanD(ppVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
				System.out.println(mvo.getUpdatedRows().get(0).getPlanNo());
				if (mvo.getUpdatedRows().get(0).getPlanNo() != null) {
					for(ProdPlanVO ppVo : mvo.getUpdatedRows()) {
					System.out.println("수정:" + mvo);
						ppMapper.updatePlan(ppVo);
						ppMapper.updatePlanD(ppVo);
					}
				} else {
					for(ProdPlanVO ppVo : mvo.getUpdatedRows()) {
						System.out.println("등록:" + mvo);
						if (ppVo == mvo.getUpdatedRows().get(0)) {
							ppMapper.insertPlan(ppVo);
						}
						ppMapper.insertPlanD(ppVo);
					}
				}
			}
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
	public List<ProdPlanVO> findOrder(ProdPlanVO ppVo) {
		return ppMapper.findOrder(ppVo);
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

	@Override
	public List<?> selectRstc(ProdPlanVO ppVo) {
		return ppMapper.selectRstc(ppVo);
	}

	@Override
	public int planDmndData(Map<String, List<ProdPlanVO>> map) {
		if(map.get("dmnd") !=null) {
			for(ProdPlanVO ppVo : map.get("dmnd")) {
				System.out.println("발주요청 자재등록:" + ppVo);
				ppMapper.insertDmnd(ppVo);
			}
		}
		return 1;
	}

}
