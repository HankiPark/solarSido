package solar.prod.indica.service;

import java.util.List;

import solar.prod.plan.service.ProdPlanVO;

public interface IndicaService {

	List<?> selectIdc(IndicaVO idcVo);

	List<?> findIndica(IndicaVO idcVo);

	List<?> selectRscList(IndicaVO idcVo);

	List<?> selectRscLot(IndicaVO idcVo);

	List<?> noIndicaPlan(ProdPlanVO ppVo);

}
