package solar.cmm.uoprcd.service;

import java.util.List;

import solar.cmm.uoprcd.dao.UoprcdVO;

public interface UoprcdService {
	List<UoprcdVO> uoprcdList(UoprcdVO uoprcdVO);
	public UoprcdVO findById(String no);
	public int uoprcdInsert(UoprcdVO uoprcdVO);
	public int uoprcdUpdate(UoprcdVO uoprcdVO);
	public int uoprcdDelete(UoprcdVO uoprcdVO);
}
