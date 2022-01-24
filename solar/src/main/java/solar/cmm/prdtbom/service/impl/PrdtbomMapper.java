package solar.cmm.prdtbom.service.impl;

import java.util.List;

import solar.cmm.prdtbom.dao.PrdtbomVO;
import solar.sales.order.dao.ModifyVO;

public interface PrdtbomMapper {
	List<PrdtbomVO>	prdtbomList(PrdtbomVO prdtbomVO);
	List<PrdtbomVO> prdtbomSearch(PrdtbomVO prdtbomVO);
	List<PrdtbomVO> prdtList(PrdtbomVO prdtbomVO);
	List<PrdtbomVO>	prdtbomFind(PrdtbomVO prdtbomVO);
	List<PrdtbomVO> prdtinfoFind(PrdtbomVO prdtvomVO);
	public int prdtbomInsert(PrdtbomVO prdtbomVO);
	public int prdtbomUpdate(PrdtbomVO prdtbomVO);
	public int prdtbomDelete(PrdtbomVO prdtbomVO);
	public int modifyData(ModifyVO<PrdtbomVO> modifyVO);
}
