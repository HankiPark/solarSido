package solar.cmm.prcs.service.impl;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;
import solar.sales.order.dao.ModifyVO;

public interface FairMapper {
	List<FairVO> fairList(FairVO fairVO);
	List<FairVO> findPrcs(FairVO fairVO);
	List<FairVO> prcsdataFind(FairVO fairVO);
	public int fairInsert(FairVO fairVO);
	public int fairUpdate(FairVO fairVO);
	public int fairDelete(FairVO fairVO);
	public int modifyData(ModifyVO<FairVO> mvo);

}
