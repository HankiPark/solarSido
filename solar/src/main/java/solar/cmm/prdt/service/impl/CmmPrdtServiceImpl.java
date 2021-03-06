package solar.cmm.prdt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.prdt.service.CmmPrdtService;
import solar.sales.order.dao.ModifyVO;

@Service
public class CmmPrdtServiceImpl implements CmmPrdtService {

	@Autowired CmmPrdtMapper prdtMapper;
	@Autowired CmmndataMapper cmmndataMapper;
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

	@Override
	public int modifyData(ModifyVO<PrdtInferVO> modifyVO) {
		if(modifyVO.getCreatedRows()!=null) {
		for(PrdtInferVO prdtInferVo : modifyVO.getCreatedRows()) {
			CmmndataVO cmmndataVO = new CmmndataVO();
			cmmndataVO.setCmmnCdDetaId(prdtInferVo.getPrdtInferCd());
			cmmndataVO.setCmmnCdId("prdtinfer");
			cmmndataVO.setCmmnCdNm(prdtInferVo.getPrdtInferNm());
			cmmndataVO.setCmmnCdDesct(prdtInferVo.getPrdtInferDesct());
			prdtMapper.prdtInsert(prdtInferVo);
			cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			}
		if(modifyVO.getDeletedRows()!=null) {
			for(PrdtInferVO prdtInferVo : modifyVO.getDeletedRows()) {
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(prdtInferVo.getPrdtInferCd());
				prdtMapper.prdtDelete(prdtInferVo);
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				}
			}	
		if(modifyVO.getUpdatedRows()!=null) {
			for(PrdtInferVO prdtInferVo : modifyVO.getUpdatedRows()) {
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(prdtInferVo.getPrdtInferCd());
				cmmndataVO.setCmmnCdId("prdtinfer");
				cmmndataVO.setCmmnCdNm(prdtInferVo.getPrdtInferNm());
				cmmndataVO.setCmmnCdDesct(prdtInferVo.getPrdtInferDesct());
				prdtMapper.prdtUpdate(prdtInferVo);
				cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
				}
			}
		}
		return 1;
	}

	@Override
	public List<PrdtInferVO> prdtinferdataFind(PrdtInferVO prdtInferVo) {
		// TODO Auto-generated method stub
		return prdtMapper.prdtinferdataFind(prdtInferVo);
	}

}
