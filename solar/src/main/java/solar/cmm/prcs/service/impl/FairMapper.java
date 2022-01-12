package solar.cmm.prcs.service.impl;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;

public interface FairMapper {
	List<FairVO> fairList(FairVO fairVO);
	public FairVO findById(String no);
	public int fairInsert(FairVO fairVO);
	public int fairUpdate(FairVO fairVO);
	public int fairDelete(FairVO fairVO);
	
	public void createCode(FairVO fairVO);
	public void updateCode(FairVO fairVO);
	public void deleteCode(FairVO fairVO);
}
