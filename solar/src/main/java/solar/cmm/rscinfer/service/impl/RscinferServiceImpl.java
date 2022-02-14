package solar.cmm.rscinfer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfer.service.RscinferService;
import solar.sales.order.dao.ModifyVO;

@Service
public class RscinferServiceImpl implements RscinferService{

	@Autowired RscinferMapper rscinferMapper;
	@Autowired CmmndataMapper cmmndataMapper;
	
	@Override
	public List<RscinferVO> rscinferList(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferList(rscinferVO);
	}

	@Override
	public RscinferVO findById(String no) {
		// TODO Auto-generated method stub
		return rscinferMapper.findById(no);
	}

	@Override
	public int rscinferInsert(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferInsert(rscinferVO);
	}

	@Override
	public int rscinferUpdate(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferUpdate(rscinferVO);
	}

	@Override
	public int rscinferDelete(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferDelete(rscinferVO);
	}

	@Override
	public int modifyData(ModifyVO<RscinferVO> modifyVO) {
		if(modifyVO.getCreatedRows()!=null) {
		for(RscinferVO rscinferVO : modifyVO.getCreatedRows()) {
			rscinferMapper.rscinferInsert(rscinferVO);
			CmmndataVO cmmndataVO = new CmmndataVO();
			cmmndataVO.setCmmnCdDetaId(rscinferVO.getRtngdResnCd());
			cmmndataVO.setCmmnCdId("rscinfer");
			cmmndataVO.setCmmnCdNm(rscinferVO.getRscInferNm());
			cmmndataVO.setCmmnCdDesct(rscinferVO.getRscInferDesct());
			cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			}
		if(modifyVO.getDeletedRows()!=null) {
			for(RscinferVO rscinferVO : modifyVO.getDeletedRows()) {
				rscinferMapper.rscinferDelete(rscinferVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(rscinferVO.getRtngdResnCd());
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				}
			}
		if(modifyVO.getUpdatedRows()!=null) {
			for(RscinferVO rscinferVO : modifyVO.getUpdatedRows()) {
				rscinferMapper.rscinferUpdate(rscinferVO);
				CmmndataVO cmmndataVO = new CmmndataVO();
				cmmndataVO.setCmmnCdDetaId(rscinferVO.getRtngdResnCd());
				cmmndataVO.setCmmnCdId("rscinfer");
				cmmndataVO.setCmmnCdNm(rscinferVO.getRscInferNm());
				cmmndataVO.setCmmnCdDesct(rscinferVO.getRscInferDesct());
				cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
				}
			}
		}
		return 1;
	}

	@Override
	public List<RscinferVO> rscinferdataFind(RscinferVO rscinferVO) {
		// TODO Auto-generated method stub
		return rscinferMapper.rscinferdataFind(rscinferVO) ;
	}
}
