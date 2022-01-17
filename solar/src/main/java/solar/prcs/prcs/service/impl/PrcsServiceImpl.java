package solar.prcs.prcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs.prcs.service.ClotVO;
import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsEqmVO;
import solar.prcs.prcs.service.PrcsService;
import solar.prcs.prcs.service.PrcsVO;

@Service
public class PrcsServiceImpl implements PrcsService {

	
	@Autowired PrcsMapper prcsmapper;  

	
	@Override
	public List<PrcsVO> selectAll() {
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
	 
	 
	
	
}
