package solar.prcs.prcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import solar.prcs.prcs.SchedulerService;
import solar.prcs.prcs.service.ClotVO;
import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsEqmVO;
import solar.prcs.prcs.service.PrcsFlowVO;
import solar.prcs.prcs.service.PrcsPrMVO;
import solar.prcs.prcs.service.PrcsService;
import solar.prcs.prcs.service.PrdtStcVO;
import solar.prcs.prcs.service.RscConVO;
import solar.prcs.prcs.service.RsltVO;

@Service
public class PrcsServiceImpl implements PrcsService {

	
	@Autowired PrcsMapper prcsmapper;  
	@Autowired SchedulerService schedulerService;
	
	@Override
	public List<PrcsPrMVO> selectAll() {
		return prcsmapper.selectAll();
	}


	@Override
	public List<IndicaVO> selectPDay(IndicaVO vo) {
		return prcsmapper.selectPDay(vo);
	}


	
	@Override 
	public List<ClotVO> selectPrcsItem(ClotVO vo) { 
		return prcsmapper.selectPrcsItem(vo);
	}


	@Override
	public List<PrcsEqmVO> selectPrcsEqm(PrcsEqmVO vo) {
		return prcsmapper.selectPrcsEqm(vo);
	}


	@Override
	public List<RscConVO> selectPrcsItemRSC(RscConVO vo) {
		return prcsmapper.selectPrcsItemRSC(vo);
	}


	@Override
	public int insertPrcsPrM(PrcsPrMVO vo) {
		return prcsmapper.insertPrcsPrM(vo);
	}


	@Override
	public List<PrcsPrMVO> updatePrcsPrM(PrcsPrMVO vo) {
		// TODO Auto-generated method stub
		return prcsmapper.updatePrcsPrM(vo);
	}


	@Override
	public List<PrcsEqmVO> selectPrcs(PrcsEqmVO vo) {
		return prcsmapper.selectPrcs(vo);
	}


	@Override
	public List<PrcsFlowVO> selectPrcsFlow(PrcsFlowVO vo) {
		return prcsmapper.selectPrcsFlow(vo);
	}


	@Override
	public int updateRscClot(ClotVO vo) {
		return prcsmapper.updateRscClot(vo);
	}


	@Override
	public int insertRscClot(ClotVO vo) {
		return prcsmapper.insertRscClot(vo);
	}


	@Override
	public List<ClotVO> selectBasicItem(ClotVO vo) {
		return prcsmapper.selectBasicItem(vo);
	}


	@Override
	public int insertRslt(RsltVO vo) {
		return prcsmapper.insertRslt(vo);
	}


	@Override
	public int insertPrdtStc(PrdtStcVO vo) {
		return prcsmapper.insertPrdtStc(vo);
	}
	
	public void  test(String scheduledId) {
		schedulerService.register(scheduledId);
	}
	
	public void test1(String scheduledId) {
		schedulerService.remove(scheduledId);
	}
	
	
	 @Scheduled(fixedDelay=1000) // 주기 : 1/1000초
	 public void test3() {
	  System.out.println("Scheduler Test ===========================================");
	  System.out.println("id : " + Thread.currentThread().getId());

	  }




	
}
