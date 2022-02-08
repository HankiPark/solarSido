package solar.prcs.prcs.service;

import java.util.List;

public interface PrcsService {

	List<PrcsPrMVO> selectAll();
	List<IndicaVO> selectPDay(IndicaVO vo);
	List<ClotVO> selectBasicItem(ClotVO vo);
	List<ClotVO> selectPrcsItem(ClotVO vo);
	int updateRscClot(ClotVO vo);
	int insertRscClot(ClotVO vo);
	int insertPrdtStc(PrdtStcVO vo);
	
	List<PrcsEqmVO> selectPrcs(PrcsEqmVO vo);
	List<PrcsFlowVO> selectPrcsFlow(PrcsFlowVO vo);
	List<PrcsEqmVO> selectPrcsEqm(PrcsEqmVO vo);
	
	
	List<RscConVO> selectPrcsItemRSC(RscConVO vo);
	
	int insertPrcsPrM(PrcsPrMVO vo);
	List<PrcsPrMVO> updatePrcsPrM(PrcsPrMVO vo);
	int insertRslt(RsltVO vo);
	
	void test(String scheduledId);
	void test1(String scheduledId);
	void test3();
}
