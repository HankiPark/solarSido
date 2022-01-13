package solar.cmm.cmmndata.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.CmmndataService;

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
	
}
