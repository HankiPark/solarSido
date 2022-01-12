package solar.cmm.prdt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.prdt.service.PrdtService;

@Service
public class PrdtServiceImpl implements PrdtService {

	@Autowired PrdtMapper prdtMapper;
	
	@Override
	public List<PrdtInferVO> prdtList(PrdtInferVO prdtInferVo) {
		// TODO Auto-generated method stub
		return prdtMapper.prdtList(prdtInferVo);
	}

	@Override
	public PrdtInferVO findById(String no) {
		// TODO Auto-generated method stub
		return prdtMapper.findById(no);
	}

	@Override
	public int prdtInsert(PrdtInferVO prdtInferVo) {
		// TODO Auto-generated method stub
		return prdtMapper.prdtInsert(prdtInferVo);
	}

	@Override
	public int prdtUpdate(PrdtInferVO prdtInferVo) {
		// TODO Auto-generated method stub
		return prdtMapper.prdtUpdate(prdtInferVo);
	}

	@Override
	public int prdtDelete(PrdtInferVO prdtInferVo) {
		// TODO Auto-generated method stub
		return prdtMapper.prdtDelete(prdtInferVo);
	}

}
