package solar.prod.indica.service.impl;

import java.util.List;

import solar.prod.indica.service.IndicaVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

public interface IndicaMapper {

	List<?> selectIdc(IndicaVO idcVo);
	
	List<?> findIndica(IndicaVO idcVo);
	
	List<?> selectRscList(IndicaVO idcVo);
	
	List<?> selectRscLot(IndicaVO idcVo);
	
	List<?> noIndicaPlan(ProdPlanVO ppVo);

	String makeDno();

	int modifyData(ModifyVO<IndicaVO> mvo);

	List<?> findEqmUo(IndicaVO idcVo);
	
	String makePrdtNo();
}
