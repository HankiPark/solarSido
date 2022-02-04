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

	String makeDno();

	List<?> findEqmUo(IndicaVO idcVo);

	String makePrdtNo();

	int hiddenData(Map<String, List<IndicaVO>> map);

	List<?> rscCnt(CmmndataVO cVo);

	int modifyData(ModifyVO<IndicaVO> mvo);
	
	int modifyRscCon(ModifyVO<IndRscVO> mvo);

	int modifyPrdtRsc(ModifyVO<IndRscVO> mvo);

}
