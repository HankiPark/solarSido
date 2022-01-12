package solar.cmm.prdt.service;

import java.util.List;

import solar.cmm.prdt.dao.PrdtInferVO;

public interface PrdtService {
	List<PrdtInferVO> prdtList(PrdtInferVO prdtInferVo);
	public PrdtInferVO findById(String no);
	public int prdtInsert(PrdtInferVO prdtInferVo);
	public int prdtUpdate(PrdtInferVO prdtInferVo);
	public int prdtDelete(PrdtInferVO prdtInferVo);
}
