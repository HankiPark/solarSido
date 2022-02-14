package solar.cmm.cmmndata.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.CmmndataService;
import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.impl.FairMapper;
import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.prdt.service.impl.CmmPrdtMapper;
import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfer.service.impl.RscinferMapper;
import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.rscinfo.service.impl.RscinfoMapper;
import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.cmm.uoprcd.service.impl.UoprcdMapper;
import solar.sales.order.dao.ModifyVO;

@Service
public class CmmndataServiceImpl implements CmmndataService {

	@Autowired CmmndataMapper cmmndataMapper;
	@Autowired RscinferMapper rscinferMapper;
	@Autowired UoprcdMapper uoprcdMapper;
	@Autowired CmmPrdtMapper prdtinferMapper;
	@Autowired FairMapper fairMapper;
	@Autowired RscinfoMapper rscinfoMapper;
	
//마스터 테이블
	
	@Override
	public List<CmmndataVO> cmmndataList(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmndataList(cmmndataVO);
	}

	@Override
	public CmmndataVO cmmndataInfo(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmndataInfo(cmmndataVO);
	}

	
//디테일 테이블
	@Override
	public List<CmmndataVO> cmmndataDetailList(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmndataDetailList(cmmndataVO);
	}

	@Override
	public List<CmmndataVO> cmmndataFind(CmmndataVO cmmndataVO) {
		return cmmndataMapper.cmmndataFind(cmmndataVO);
	}

	@Override
	public int cmmnDetailInsert(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmnDetailInsert(cmmndataVO);
	}

	@Override
	public int cmmnDetailUpdate(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
	}

	@Override
	public int cmmnDetailDelete(CmmndataVO cmmndataVO) {
		// TODO Auto-generated method stub
		return cmmndataMapper.cmmnDetailDelete(cmmndataVO);
	}

	@Override
	public int modifyData(ModifyVO<CmmndataVO> modifyVO) {
		if(modifyVO.getCreatedRows()!=null) {
		for(CmmndataVO cmmndataVO : modifyVO.getCreatedRows()) {
			cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			if(cmmndataVO.getCmmnCdId().equals("rscinfer")) {
				RscinferVO rscinferVO = new RscinferVO();
				rscinferVO.setRtngdResnCd(cmmndataVO.getCmmnCdDetaId());
				rscinferVO.setRscInferNm(cmmndataVO.getCmmnCdNm());
				rscinferVO.setRscInferDesct(cmmndataVO.getCmmnCdDesct());
				rscinferMapper.rscinferInsert(rscinferVO);
			}else if (cmmndataVO.getCmmnCdId().equals("uopr")) {
				UoprcdVO uoprcdVO = new UoprcdVO();
				uoprcdVO.setUoprCd(cmmndataVO.getCmmnCdDetaId());
				uoprcdVO.setUoprNm(cmmndataVO.getCmmnCdNm());
				uoprcdVO.setUoprDesct(cmmndataVO.getCmmnCdDesct());
				uoprcdMapper.uoprcdInsert(uoprcdVO);
			}else if (cmmndataVO.getCmmnCdId().equals("prdtinfer")) {
				PrdtInferVO prdtinferVO = new PrdtInferVO();
				prdtinferVO.setPrdtInferCd(cmmndataVO.getCmmnCdDetaId());
				prdtinferVO.setPrdtInferNm(cmmndataVO.getCmmnCdNm());
				prdtinferVO.setPrdtInferDesct(cmmndataVO.getCmmnCdDesct());
				prdtinferMapper.prdtInsert(prdtinferVO);
			}else if (cmmndataVO.getCmmnCdId().equals("prcs")) {
				FairVO fairVO = new FairVO();
				fairVO.setPrcsCd(cmmndataVO.getCmmnCdDetaId());
				fairVO.setPrcsNm(cmmndataVO.getCmmnCdNm());
				fairVO.setPrcsDesct(cmmndataVO.getCmmnCdDesct());
				fairMapper.fairInsert(fairVO);
			}else if(cmmndataVO.getCmmnCdId().equals("rsc")) {
				RscinfoVO rscinfoVO = new RscinfoVO();
				rscinfoVO.setRscCd(cmmndataVO.getCmmnCdDetaId());
				rscinfoVO.setRscNm(cmmndataVO.getCmmnCdNm());
				rscinfoMapper.rscinfoStc(rscinfoVO);
				rscinfoMapper.rscinfoInsert(rscinfoVO);
			}

			}
		if(modifyVO.getDeletedRows()!=null) {
			for(CmmndataVO cmmndataVO : modifyVO.getDeletedRows()) {
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				if(cmmndataVO.getCmmnCdId().equals("rscinfer")) {
					RscinferVO rscinferVO = new RscinferVO();
					rscinferVO.setRtngdResnCd(cmmndataVO.getCmmnCdDetaId());
					rscinferMapper.rscinferDelete(rscinferVO);
				}else if (cmmndataVO.getCmmnCdId().equals("uopr")) {
					UoprcdVO uoprcdVO = new UoprcdVO();
					uoprcdVO.setUoprCd(cmmndataVO.getCmmnCdDetaId());
					uoprcdMapper.uoprcdDelete(uoprcdVO);
				}else if (cmmndataVO.getCmmnCdId().equals("prdtinfer")) {
					PrdtInferVO prdtinferVO = new PrdtInferVO();
					prdtinferVO.setPrdtInferCd(cmmndataVO.getCmmnCdDetaId());
					prdtinferMapper.prdtDelete(prdtinferVO);
				}else if (cmmndataVO.getCmmnCdId().equals("prcs")) {
					FairVO fairVO = new FairVO();
					fairVO.setPrcsCd(cmmndataVO.getCmmnCdDetaId());
					fairMapper.fairDelete(fairVO);
				}else if(cmmndataVO.getCmmnCdId().equals("rsc")) {
					RscinfoVO rscinfoVO = new RscinfoVO();
					rscinfoVO.setRscCd(cmmndataVO.getCmmnCdDetaId());
					rscinfoMapper.rscinfoDelete(rscinfoVO);
				}
				
				}
			}
		if(modifyVO.getUpdatedRows()!=null) {
			for(CmmndataVO cmmndataVO : modifyVO.getUpdatedRows()) {
				cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
				
				if(cmmndataVO.getCmmnCdId().equals("rscinfer")) {
					RscinferVO rscinferVO = new RscinferVO();
					rscinferVO.setRtngdResnCd(cmmndataVO.getCmmnCdDetaId());
					rscinferVO.setRscInferNm(cmmndataVO.getCmmnCdNm());
					rscinferVO.setRscInferDesct(cmmndataVO.getCmmnCdDesct());
					rscinferMapper.rscinferUpdate(rscinferVO);
				}else if (cmmndataVO.getCmmnCdId().equals("uopr")) {
					UoprcdVO uoprcdVO = new UoprcdVO();
					uoprcdVO.setUoprCd(cmmndataVO.getCmmnCdDetaId());
					uoprcdVO.setUoprNm(cmmndataVO.getCmmnCdNm());
					uoprcdVO.setUoprDesct(cmmndataVO.getCmmnCdDesct());
					uoprcdMapper.uoprcdUpdate(uoprcdVO);
				}else if (cmmndataVO.getCmmnCdId().equals("prdtinfer")) {
					PrdtInferVO prdtinferVO = new PrdtInferVO();
					prdtinferVO.setPrdtInferCd(cmmndataVO.getCmmnCdDetaId());
					prdtinferVO.setPrdtInferNm(cmmndataVO.getCmmnCdNm());
					prdtinferVO.setPrdtInferDesct(cmmndataVO.getCmmnCdDesct());
					prdtinferMapper.prdtUpdate(prdtinferVO);
				}else if (cmmndataVO.getCmmnCdId().equals("prcs")) {
					FairVO fairVO = new FairVO();
					fairVO.setPrcsCd(cmmndataVO.getCmmnCdDetaId());
					fairVO.setPrcsNm(cmmndataVO.getCmmnCdNm());
					fairVO.setPrcsDesct(cmmndataVO.getCmmnCdDesct());
					fairMapper.fairUpdate(fairVO);
				}else if(cmmndataVO.getCmmnCdId().equals("rsc")) {
					RscinfoVO rscinfoVO = new RscinfoVO();
					rscinfoVO.setRscCd(cmmndataVO.getCmmnCdDetaId());
					rscinfoVO.setRscNm(cmmndataVO.getCmmnCdNm());
					rscinfoMapper.rscinfoUpdate(rscinfoVO);
				}
				}
			}
		}
		return 1;
	}

	
}
