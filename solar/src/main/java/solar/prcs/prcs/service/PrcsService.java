package solar.prcs.prcs.service;

import java.util.List;

public interface PrcsService {

	List<PrcsPrMVO> selectAll();
	List<IndicaVO> selectPDay(IndicaVO vo);
	List<ClotVO> selectPrcsItem(ClotVO vo);
	List<PrcsEqmVO> selectPrcsEqm(PrcsEqmVO vo);
	List<RscConVO> selectPrcsItemRSC(RscConVO vo);
	
	List<PrcsPrMVO> insertPrcsPrM(PrcsPrMVO vo);
	List<PrcsPrMVO> updatePrcsPrM(PrcsPrMVO vo);
	
}
