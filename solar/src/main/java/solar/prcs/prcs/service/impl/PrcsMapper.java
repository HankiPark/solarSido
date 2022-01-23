package solar.prcs.prcs.service.impl;

import java.util.List;

import solar.prcs.prcs.service.ClotVO;
import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsEqmVO;
import solar.prcs.prcs.service.PrcsPrMVO;
import solar.prcs.prcs.service.RscConVO;

public interface PrcsMapper {

	List<PrcsPrMVO> selectAll();
	
	List<IndicaVO> selectPDay(IndicaVO vo);
	List<ClotVO> selectPrcsItem(ClotVO vo);
	List<PrcsEqmVO> selectPrcsEqm(PrcsEqmVO vo);
	List<RscConVO> selectPrcsItemRSC(RscConVO vo);
	
	List<PrcsPrMVO> insertPrcsPrM(PrcsPrMVO vo);
	List<PrcsPrMVO> updatePrcsPrM(PrcsPrMVO vo);
}
