package solar.cmm.prcs.service;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;

public interface FairService {
	List<FairVO> fairList(FairVO fairVO);
	FairVO findById(String no);
	int insert(FairVO fairVO);
	int update(FairVO fairVO);
	int remove(FairVO fairVO);
}
