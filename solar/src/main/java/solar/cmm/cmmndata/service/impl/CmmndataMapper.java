package solar.cmm.cmmndata.service.impl;

import java.util.List;

import solar.cmm.cmmndata.dao.CmmndataVO;

public interface CmmndataMapper {
	
	//마스터테이블
	List<CmmndataVO> cmmndataList(CmmndataVO cmmndataVO);
	public CmmndataVO cmmndataInfo(CmmndataVO cmmndataVO);
	
	//디테일 테이블
	List<CmmndataVO> cmmndataDetailList(CmmndataVO cmmndataVO);
}
