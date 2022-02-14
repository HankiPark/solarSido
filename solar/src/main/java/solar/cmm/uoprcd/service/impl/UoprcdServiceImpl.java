package solar.cmm.uoprcd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;
import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.cmm.uoprcd.service.UoprcdService;
import solar.sales.order.dao.ModifyVO;

@Service
public class UoprcdServiceImpl implements UoprcdService{

	@Autowired UoprcdMapper uoprcdMapper;
	@Autowired CmmndataMapper cmmndataMapper;
	
	@Override
	public List<UoprcdVO> uoprcdList(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdList(uoprcdVO);
	}

	@Override
	public UoprcdVO findById(String no) {
		// TODO Auto-generated method stub
		return uoprcdMapper.findById(no);
	}

	@Override
	public int uoprcdInsert(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdInsert(uoprcdVO);
	}

	@Override
	public int uoprcdUpdate(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdUpdate(uoprcdVO);
	}

	@Override
	public int uoprcdDelete(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcdDelete(uoprcdVO);
	}

	@Override
	public int modifyData(ModifyVO<UoprcdVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
		for(UoprcdVO uoprcdVO : mvo.getCreatedRows()) {
			uoprcdMapper.uoprcdInsert(uoprcdVO);
			CmmndataVO cmmndataVO = new CmmndataVO();
			cmmndataVO.setCmmnCdDetaId(uoprcdVO.getUoprCd());
			cmmndataVO.setCmmnCdId("uopr");
			cmmndataVO.setCmmnCdNm(uoprcdVO.getUoprNm());
			cmmndataVO.setCmmnCdDesct(uoprcdVO.getUoprDesct());
			cmmndataMapper.cmmnDetailInsert(cmmndataVO);
			}
		if(mvo.getDeletedRows()!=null) {
			for(UoprcdVO uoprcdVO : mvo.getDeletedRows()) {
					CmmndataVO cmmndataVO = new CmmndataVO();
					cmmndataVO.setCmmnCdDetaId(uoprcdVO.getUoprCd());
					uoprcdMapper.uoprcdDelete(uoprcdVO);
					cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
			for(UoprcdVO uoprcdVO : mvo.getUpdatedRows()) {
					CmmndataVO cmmndataVO = new CmmndataVO();
					cmmndataVO.setCmmnCdDetaId(uoprcdVO.getUoprCd());
					cmmndataVO.setCmmnCdId("uopr");
					cmmndataVO.setCmmnCdNm(uoprcdVO.getUoprNm());
					cmmndataVO.setCmmnCdDesct(uoprcdVO.getUoprDesct());
					uoprcdMapper.uoprcdUpdate(uoprcdVO);
					cmmndataMapper.cmmnDetailUpdate(cmmndataVO);
				}
			}
		}
		return 1;
	}

	@Override
	public List<UoprcdVO> uoprcddataFind(UoprcdVO uoprcdVO) {
		// TODO Auto-generated method stub
		return uoprcdMapper.uoprcddataFind(uoprcdVO);
	}

}
