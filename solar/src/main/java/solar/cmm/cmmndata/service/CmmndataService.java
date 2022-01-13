package solar.cmm.cmmndata.service;

import java.util.List;

import solar.cmm.cmmndata.dao.CmmndataVO;

public interface CmmndataService {
	
	//마스터 테이블
	List<CmmndataVO> cmmndataList(CmmndataVO cmmndataVO);
	public CmmndataVO cmmndataInfo(CmmndataVO cmmndataVO);
	
	//디테일 테이블
	List<CmmndataVO> cmmndataDetailList(CmmndataVO cmmndataVO);
}
