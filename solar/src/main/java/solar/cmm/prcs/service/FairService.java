package solar.cmm.prcs.service;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;

public interface FairService {
	List<FairVO> fairList(FairVO fairVO);
	public FairVO findById(String no);
	public int fairInsert(FairVO fairVO);
	public int fairUpdate(FairVO fairVO);
	public int fairDelete(FairVO fairVO);
	
	public void createCode(FairVO fairVO);
	public void updateCode(FairVO fairVO);
	public void deleteCode(FairVO fairVO);
	void createCode(List<FairVO> createdRows) throws Exception;
	void updateCode(List<FairVO> updatedRows) throws Exception;
	void deleteCode(List<FairVO> deletedRows) throws Exception;
}
