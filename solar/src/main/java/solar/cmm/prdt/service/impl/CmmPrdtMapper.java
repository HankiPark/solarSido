package solar.cmm.prdt.service.impl;

import java.util.List;

import solar.cmm.prdt.dao.PrdtInferVO;
import solar.sales.order.dao.ModifyVO;

public interface CmmPrdtMapper {
	List<PrdtInferVO> prdtList(PrdtInferVO prdtInferVo);
	public PrdtInferVO findById(String no);
	public int prdtInsert(PrdtInferVO prdtInferVo);
	public int prdtUpdate(PrdtInferVO prdtInferVo);
	public int prdtDelete(PrdtInferVO prdtInferVo);
	public int modifyData(ModifyVO<PrdtInferVO> modifyVO);
}
