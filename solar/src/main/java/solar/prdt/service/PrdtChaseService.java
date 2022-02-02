package solar.prdt.service;

import java.util.List;

import solar.prdt.dao.PrdtChase;

public interface PrdtChaseService {
	List<PrdtChase> findLotList(PrdtChase vo);
	List<PrdtChase> prdtLotChase(PrdtChase vo);
}
