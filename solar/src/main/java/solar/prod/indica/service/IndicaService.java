package solar.prod.indica.service;

import java.util.List;

public interface IndicaService {

	List<?> selectIdc(IndicaVO idcVo);

	List<?> findIndica(IndicaVO idcVo);

	List<?> selectRscList(IndicaVO idcVo);

	List<?> selectRscLot(IndicaVO idcVo);

}
