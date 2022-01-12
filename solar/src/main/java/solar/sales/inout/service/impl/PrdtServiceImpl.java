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
				pmapper.updateInPrdt(vo);
			}
		}
		return 1;
	}
}
