package solar.cmm.cmmndata.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.CmmndataService;
import solar.sales.order.dao.ModifyVO;

@Service
public class CmmndataServiceImpl implements CmmndataService {

	@Autowired CmmndataMapper cmmndataMapper;

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

			}
		if(modifyVO.getDeletedRows()!=null) {
			for(CmmndataVO cmmndataVO : modifyVO.getDeletedRows()) {
				cmmndataMapper.cmmnDetailDelete(cmmndataVO);
				}
			}
		if(modifyVO.getUpdatedRows()!=null) {
			for(CmmndataVO cmmndataVO : modifyVO.getUpdatedRows()) {
				cmmndataMapper.cmmndataDetailList(cmmndataVO);
				}
			}
		}
		return 1;
	}

	
}
