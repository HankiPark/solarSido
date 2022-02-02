package solar.prdt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.prdt.dao.PrdtChase;
import solar.prdt.service.PrdtChaseService;

@Service
public class PrdtChaseServiceImpl implements PrdtChaseService{

	@Autowired PrdtChaseMapper pmapper;
	@Override
	public List<PrdtChase> findLotList(PrdtChase vo) {
		
		return pmapper.findLotList(vo);
	}
	@Override
	public List<PrdtChase> prdtLotChase(PrdtChase vo) {
		// TODO Auto-generated method stub
		return pmapper.prdtLotChase(vo);
	}

}
