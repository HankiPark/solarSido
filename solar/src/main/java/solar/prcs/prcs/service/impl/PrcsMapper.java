package solar.prcs.prcs.service.impl;

import java.util.List;

import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsVO;

public interface PrcsMapper {

	List<PrcsVO> selectAll();
	List<IndicaVO> selectPDay(IndicaVO vo);
	
}
