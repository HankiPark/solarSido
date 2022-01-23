package solar.cmm.rscinfer.service;

import java.util.List;

import solar.cmm.rscinfer.dao.RscinferVO;
import solar.sales.order.dao.ModifyVO;

public interface RscinferService {
	List<RscinferVO> rscinferList(RscinferVO rscinferVO);
	List<RscinferVO> rscinferdataFind(RscinferVO rscinferVO);
	public RscinferVO findById(String no);
	public int rscinferInsert(RscinferVO rscinferVO);
	public int rscinferUpdate(RscinferVO rscinferVO);
	public int rscinferDelete(RscinferVO rscinferVO);
	public int modifyData(ModifyVO<RscinferVO> modifyVO);
}
