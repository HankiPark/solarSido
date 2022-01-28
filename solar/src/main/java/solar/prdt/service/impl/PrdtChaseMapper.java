package solar.prdt.service.impl;

import java.util.List;

import solar.prdt.dao.PrdtChase;

public interface PrdtChaseMapper {

	List<PrdtChase> findLotList(PrdtChase vo);
}
