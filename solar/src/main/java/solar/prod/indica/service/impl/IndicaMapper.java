package solar.prod.indica.service.impl;

import java.util.List;

import solar.prod.indica.service.IndicaVO;

public interface IndicaMapper {

	List<?> selectIdc(IndicaVO idcVo);
}
