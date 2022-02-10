package solar.cmm.cmmndata.service;

import java.util.List;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.sales.order.dao.ModifyVO;

public interface CmmndataService {
	
	//마스터 테이블
	List<CmmndataVO> cmmndataList(CmmndataVO cmmndataVO);
	List<CmmndataVO> cmmndataFind(CmmndataVO cmmndataVO);
	public CmmndataVO cmmndataInfo(CmmndataVO cmmndataVO);
	
	//디테일 테이블
	List<CmmndataVO> cmmndataDetailList(CmmndataVO cmmndataVO);
	public int cmmnDetailInsert(CmmndataVO cmmndataVO);
	public int cmmnDetailUpdate(CmmndataVO cmmndataVO);
	public int cmmnDetailDelete(CmmndataVO cmmndataVO);
	public int modifyData(ModifyVO<CmmndataVO> modifyVO);
}
