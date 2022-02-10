package solar.prod.indica.service;

import java.util.List;
import java.util.Map;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

public interface IndicaService {

	List<?> selectIdc(IndicaVO idcVo);
	List<?> findIndica(IndicaVO idcVo);
	List<?> selectRscList(IndicaVO idcVo);
	List<?> selectRscLot(IndicaVO idcVo);
	List<?> noIndicaPlan(ProdPlanVO ppVo);
	List<?> findEqmUo(IndicaVO idcVo);
	List<?> rscCnt(CmmndataVO cVo);
	
	//getSeq
	String makeDno();
	String makePrdtNo();

	//modify
	int modifyData(ModifyVO<IndicaVO> mvo);
	int hiddenData(Map<String, List<IndicaVO>> map);

}
