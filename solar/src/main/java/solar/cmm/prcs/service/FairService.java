package solar.cmm.prcs.service;

import java.util.List;

import solar.cmm.prcs.dao.FairVO;
import solar.sales.order.dao.ModifyVO;

public interface FairService {
	List<FairVO> fairList(FairVO fairVO);
	List<FairVO> findPrcs(FairVO fairVO);
	public int fairInsert(FairVO fairVO);
	public int fairUpdate(FairVO fairVO);
	public int fairDelete(FairVO fairVO);
	public int modifyData(ModifyVO<FairVO> mvo);
}
