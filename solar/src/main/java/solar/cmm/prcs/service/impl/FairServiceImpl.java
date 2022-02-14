package solar.cmm.prcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.sales.order.dao.ModifyVO;

@Service
public class FairServiceImpl implements FairService {

	@Autowired FairMapper fairMapper;
	@Autowired CmmndataMapper cmmndataMapper;
	
	@Override
	public List<FairVO> fairList(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairList(fairVO);
	}

	@Override
	public int fairInsert(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairInsert(fairVO);
	}

	@Override
	public int fairUpdate(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairUpdate(fairVO);
	}

	@Override
	public int fairDelete(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.fairDelete(fairVO);
	}

	@Override
	public int modifyData(ModifyVO<FairVO> mvo) {
		
		if(mvo.getCreatedRows()!=null) {
			for(FairVO fairVO : mvo.getCreatedRows()) {
				fairMapper.fairInsert(fairVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(fairVO.getPrcsCd());
				cmmndataVO.setCmmnCdId("prcs");
				cmmndataVO.setCmmnCdNm(fairVO.getPrcsNm());
				cmmndataVO.setCmmnCdDesct(fairVO.getPrcsDesct());
				cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			}
		}
		if(mvo.getDeletedRows()!=null) {
			for(FairVO fairVO : mvo.getDeletedRows()) {
				fairMapper.fairDelete(fairVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(fairVO.getPrcsCd());
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
			}
			if(mvo.getUpdatedRows()!=null) {
				for(FairVO fairVO : mvo.getUpdatedRows()) {
					fairMapper.fairUpdate(fairVO);
					CmmndataVO cmmndataVO = new CmmndataVO();
					cmmndataVO.setCmmnCdDetaId(fairVO.getPrcsCd());
					cmmndataVO.setCmmnCdId("prcs");
					cmmndataVO.setCmmnCdNm(fairVO.getPrcsNm());
					cmmndataVO.setCmmnCdDesct(fairVO.getPrcsDesct());
					cmmndataMapper.cmmnDetailUpdate(cmmndataVO);	
				}
			}	
	}
		return 1;
}
	@Override
	public List<FairVO> findPrcs(FairVO fairVO) {
		return fairMapper.findPrcs(fairVO);
	}

	@Override
	public List<FairVO> prcsdataFind(FairVO fairVO) {
		// TODO Auto-generated method stub
		return fairMapper.prcsdataFind(fairVO);
	}
}



