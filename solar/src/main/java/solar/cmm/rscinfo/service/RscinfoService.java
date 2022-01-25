package solar.cmm.rscinfo.service;

import java.util.List;

import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.sales.order.dao.ModifyVO;

public interface RscinfoService {
	List<RscinfoVO> findRsc(RscinfoVO rscinfoVO);
	List<RscinfoVO> rscinfoList(RscinfoVO rscinfoVO);
	List<RscinfoVO> rscinfofind(RscinfoVO rscinfoVO);
	RscinfoVO rscinfo(RscinfoVO rscinfoVO);
	public int rscinfoInsert(RscinfoVO rscinfoVO);
	public int rscinfoUpdate(RscinfoVO rscinfoVO);
	public int rscinfoDelete(RscinfoVO rscinfoVO);
	public int modifyData(ModifyVO<RscinfoVO> modifyVO);
}
