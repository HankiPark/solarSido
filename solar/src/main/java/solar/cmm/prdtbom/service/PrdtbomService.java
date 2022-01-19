package solar.cmm.prdtbom.service;

import java.util.List;

import solar.cmm.prdtbom.dao.PrdtbomVO;
import solar.sales.order.dao.ModifyVO;

public interface PrdtbomService {
	List<PrdtbomVO>	prdtbomList(PrdtbomVO prdtbomVO);
	List<PrdtbomVO>	prdtbomFind(PrdtbomVO prdtbomVO);
	public int prdtbomInsert(PrdtbomVO prdtbomVO);
	public int prdtbomUpdate(PrdtbomVO prdtbomVO);
	public int prdtbomDelete(PrdtbomVO prdtbomVO);
	public int modifyData(ModifyVO<PrdtbomVO> modifyVO);
}
