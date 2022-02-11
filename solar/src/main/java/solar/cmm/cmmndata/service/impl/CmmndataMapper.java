package solar.cmm.cmmndata.service.impl;

import java.util.List;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.sales.order.dao.ModifyVO;

public interface CmmndataMapper {
	
	//마스터테이블
	List<CmmndataVO> cmmndataList(CmmndataVO cmmndataVO);
	List<CmmndataVO> cmmndataFind(CmmndataVO cmmndataVO);
	public CmmndataVO cmmndataInfo(CmmndataVO cmmndataVO);
	
	//디테일 테이블
	List<CmmndataVO> cmmndataDetailList(CmmndataVO cmmndataVO);
	public int cmmnDetailInsert(CmmndataVO cmmndataVO);
	public int cmmnDetailInsert(RscinferVO rscinferVO);
	public int cmmnDetailInsert(FairVO fairVO);
	public int cmmnDetailInsert(RscinfoVO rscinfoVO);
	public int cmmnDetailInsert(UoprcdVO uoprcdVO);
	public int cmmnDetailInsert(PrdtInferVO prdtInferVO);
	public int cmmnDetailUpdate(CmmndataVO cmmndataVO);
	public int cmmnDetailDelete(CmmndataVO cmmndataVO);
	public int modifyData(ModifyVO<CmmndataVO> modifyVO);
}
