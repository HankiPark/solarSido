package solar.cmm.rscinfer.service;

import java.util.List;

import solar.cmm.rscinfer.dao.RscinferVO;

public interface RscinferService {
	List<RscinferVO> rscinferList(RscinferVO rscinferVO);
	public RscinferVO findById(String no);
	public int rscinferInsert(RscinferVO rscinferVO);
	public int rscinferUpdate(RscinferVO rscinferVO);
	public int rscinferDelete(RscinferVO rscinferVO);
}
