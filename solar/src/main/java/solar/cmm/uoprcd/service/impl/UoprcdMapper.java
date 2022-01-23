package solar.cmm.uoprcd.service.impl;

import java.util.List;

import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.sales.order.dao.ModifyVO;

public interface UoprcdMapper {

	List<UoprcdVO> uoprcdList(UoprcdVO uoprcdVO);
	List<UoprcdVO> uoprcddataFind(UoprcdVO uoprcdVO);
	public UoprcdVO findById(String no);
	public int uoprcdInsert(UoprcdVO uoprcdVO);
	public int uoprcdUpdate(UoprcdVO uoprcdVO);
	public int uoprcdDelete(UoprcdVO uoprcdVO);
	public int modifyData(ModifyVO<UoprcdVO> mvo);
}
