package solar.sales.inout.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.sales.inout.dao.Prdt;
import solar.sales.inout.service.PrdtService;
import solar.sales.order.dao.ModifyVO;

@Service
public class PrdtServiceImpl implements PrdtService {

	@Autowired
	PrdtMapper pmapper;

	@Override
	public List<Prdt> findList(Prdt vo) {

		return pmapper.findList(vo);
	}

	@Override
	public List<Prdt> findPrdt(Prdt vo) {
		return pmapper.findPrdt(vo);
	}

	@Override
	public int inPrdt(Prdt vo) {

		return pmapper.inPrdt(vo);
	}

	@Override
	public int modifyData(ModifyVO<Prdt> mvo) {
		if(mvo.getCreatedRows()!=null) {
		for(Prdt vo : mvo.getCreatedRows()) {
			System.out.println("vo는"+vo);
			pmapper.insertInPrdt(vo);
			}
		}
		if(mvo.getDeletedRows()!=null) {
			for(Prdt vo : mvo.getDeletedRows()) {
				pmapper.deleteInPrdt(vo);
			}
		}
		if(mvo.getUpdatedRows()!=null) {
			for(Prdt vo : mvo.getUpdatedRows()) {
				pmapper.deleteInPrdt(vo);
				pmapper.insertInPrdt(vo);
			}
		}
		return 1;
	}

	/*
	 * @Override public List<Prdt> findCo() {
	 * 
	 * return pmapper.findCo(); }
	 */

	@Override
	public String makeNum() {
		
		return pmapper.makeNum();
	}

	@Override
	public int modifyOutData(ModifyVO<Prdt> mvo) {
		
		if(mvo.getCreatedRows()!=null) {
			pmapper.insertOutPrdt(mvo.getCreatedRows().get(0));
			for(Prdt vo : mvo.getCreatedRows()) {
				
				pmapper.insertOutD(vo);
				
				System.out.println(pmapper.updateStatePrdt(vo)+"설정완료");
				pmapper.resetOw(vo);
				pmapper.updOrd(vo);
				
				}
			
			}
			if(mvo.getDeletedRows()!=null) {
				for(Prdt vo : mvo.getDeletedRows()) {
					pmapper.deleteOutPrdt(vo);
				}
			}
			if(mvo.getUpdatedRows()!=null) {
				for(Prdt vo : mvo.getUpdatedRows()) {
				
				}
			}
		return 1;
	}

	@Override
	public List<Prdt> findSlip(Prdt vo) {
		
		return pmapper.findSlip(vo);
	}

	@Override
	public List<Prdt> OutOrderList(Prdt vo) {
		
		return pmapper.OutOrderList(vo);
	}

	@Override
	public List<Prdt> OutOrderCdList(Prdt vo) {
		
		return pmapper.OutOrderCdList(vo);
	}

	@Override
	public int tempUpdStc(Prdt vo) {
		
		return pmapper.tempUpdStc(vo);
	}

	@Override
	public List<Prdt> OutWaitList(Prdt vo) {
		// TODO Auto-generated method stub
		return pmapper.OutWaitList(vo);
	}

	@Override
	public int resetOw(Prdt vo) {
		pmapper.resetOw(vo);
		return 1;
	}	
	@Override
	public int insertOw(ModifyVO<Prdt> mvo) {
		
	
		if(mvo.getRows()!=null) {
			for(Prdt vo : mvo.getRows()) {
				
				pmapper.insertOw(vo);
				}
			
			}

		return 1;
		
		
	}

	@Override
	public List<Prdt> findSlipList(Prdt vo) {
		
		return pmapper.findSlipList(vo);
	}

	@Override
	public List<Prdt> findSlipLot(Prdt vo) {
		return pmapper.findSlipLot(vo);
	}

	@Override
	public List<Prdt> prdtSearch(Prdt vo) {
		// TODO Auto-generated method stub
		return pmapper.prdtSearch(vo);
	}

	
	
	
}

