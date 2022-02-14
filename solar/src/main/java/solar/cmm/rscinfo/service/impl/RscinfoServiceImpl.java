package solar.cmm.rscinfo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.rscinfo.service.RscinfoService;
import solar.rsc.stc.service.RscStc;
import solar.rsc.stc.service.impl.RscStcMapper;
import solar.sales.order.dao.ModifyVO;

@Service
public class RscinfoServiceImpl implements RscinfoService{

	@Autowired RscinfoMapper rscinfoMapper;
	@Autowired CmmndataMapper cmmndataMapper;
	@Autowired RscStcMapper rscstcMapper;
	
	@Override
	public List<RscinfoVO> rscinfoList(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoList(rscinfoVO);
	}

	@Override
	public List<RscinfoVO> rscinfofind(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfofind(rscinfoVO);
	}

	@Override
	public int rscinfoInsert(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoInsert(rscinfoVO);
	}

	@Override
	public int rscinfoUpdate(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoUpdate(rscinfoVO);
	}

	@Override
	public int rscinfoDelete(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscinfoDelete(rscinfoVO);
	}

	@Override
	public int modifyData(ModifyVO<RscinfoVO> modifyVO) {
		
		if(modifyVO.getCreatedRows()!=null) {
			for(RscinfoVO rscinfoVO : modifyVO.getCreatedRows()) {
				rscinfoMapper.rscinfoInsert(rscinfoVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
				cmmndataVO.setCmmnCdId("rsc");
				cmmndataVO.setCmmnDtCdNm(rscinfoVO.getRscNm());
				rscinfoMapper.rscinfoStc(rscinfoVO);
				cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			}
		}
		if(modifyVO.getDeletedRows()!=null) {
			for(RscinfoVO rscinfoVO : modifyVO.getDeletedRows()) {
				rscinfoMapper.rscinfoDelete(rscinfoVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				
			}
			if(modifyVO.getUpdatedRows()!=null) {
				for(RscinfoVO rscinfoVO : modifyVO.getUpdatedRows()) {
					rscinfoMapper.rscinfoUpdate(rscinfoVO);
					CmmndataVO cmmndataVO = new CmmndataVO();
					cmmndataVO.setCmmnCdDetaId(rscinfoVO.getRscCd());
					cmmndataVO.setCmmnCdId("rsc");
					cmmndataVO.setCmmnDtCdNm(rscinfoVO.getRscNm());
					cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
				}
			}	
	}
		
		return 1;
	}

	@Override
	public RscinfoVO rscinfo(RscinfoVO rscinfoVO) {
		return rscinfoMapper.rscinfo(rscinfoVO);
	}

	@Override
	public List<RscinfoVO> findRsc(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.findRsc(rscinfoVO);
	}

	@Override
	public int rscinfoStc(RscinfoVO rscinfoVO) {
		return rscinfoMapper.rscinfoStc(rscinfoVO);
	}

	@Override
	public int rscstcDelete(RscinfoVO rscinfoVO) {
		// TODO Auto-generated method stub
		return rscinfoMapper.rscstcDelete(rscinfoVO);
	}

}
