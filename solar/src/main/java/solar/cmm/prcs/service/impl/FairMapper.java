package solar.cmm.prcs.service.impl;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;

public interface FairMapper {
	List<FairVO> fairList(FairVO fairVO);
	public FairVO findById(String no);
	public int insert(FairVO fairVO);
	public int update(FairVO fairVO);
	public int remove(FairVO fairVO);
}
