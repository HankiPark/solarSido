package solar.prcs2.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prcs2.dao.EqmAble;
import solar.prcs2.dao.Prcs2;
import solar.prcs2.dao.PrcsIng;
import solar.prcs2.service.Prcs2Service;
import solar.sales.order.dao.ModifyVO;

@Service
public class Prcs2ServiceImpl implements Prcs2Service {

	@Autowired Prcs2Mapper pmapper;

	@Override
	public List<Prcs2> searchPlanList(Prcs2 vo) {
		return pmapper.searchPlanList(vo);
	}

	@Override
	public int insertData(Prcs2 vo) {
		
		return pmapper.insertData(vo);
	}


	/*
	 * @Override public int insertDetail(ModifyVO<Prcs2> mvo) {
	 * if(mvo.getCreatedRows()!=null) { for(Prcs2 vo : mvo.getCreatedRows()) {
	 * 
	 * } } if(mvo.getDeletedRows()!=null) { for(Prcs2 vo : mvo.getDeletedRows()) {
	 * 
	 * } } if(mvo.getUpdatedRows()!=null) { for(Prcs2 vo : mvo.getUpdatedRows()) {
	 * pmapper.insertDetail(vo); } }
	 * 
	 * return 1; }
	 */

	@Override
	public int insertDetailO(ModifyVO<Prcs2> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(Prcs2 vo : mvo.getCreatedRows()) {
				
				}
			}
			if(mvo.getDeletedRows()!=null) {
				for(Prcs2 vo : mvo.getDeletedRows()) {

				}
			}
			if(mvo.getUpdatedRows()!=null) {
				for(Prcs2 vo : mvo.getUpdatedRows()) {
					pmapper.insertDetailO(vo);
				}
			}
		
		return 1;
	}

	@Override
	public List<Prcs2> findTemp() {
		return pmapper.findTemp();
	}

	@Override
	public List<Prcs2> repeat(Prcs2 vo) {
		
	
		if(pmapper.findTemp().isEmpty()) {
			return pmapper.listPrcs(vo);
		}else {
			return pmapper.findTemp();
		}
		
		
	}

	@Override
	public List<PrcsIng> prIng(Prcs2 vo) {
		return pmapper.prIng(vo);
	}

	@Override
	public List<EqmAble> allYEqm() {
		// TODO Auto-generated method stub
		return pmapper.allYEqm();
	}

	@Override
	public List<Prcs2> prdtInferList(Prcs2 vo) {
		return pmapper.prdtInferList(vo);
	}

	@Override
	public List<Prcs2> inspaEqmChart() {
		return pmapper.inspaEqmChart();
	}

	@Override
	public List<Prcs2> EqmKindChart(Prcs2 vo) {
		// TODO Auto-generated method stub
		return pmapper.EqmKindChart(vo);
	}

	@Override
	public List<Prcs2> findInspaPrdt(Prcs2 vo) {
		// TODO Auto-generated method stub
		return pmapper.findInspaPrdt(vo);
	}

	
	
}
