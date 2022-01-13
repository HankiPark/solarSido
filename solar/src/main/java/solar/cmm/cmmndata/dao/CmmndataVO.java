package solar.cmm.cmmndata.dao;

import lombok.Data;

@Data
public class CmmndataVO {
	
	//공통자료관리 마스터 테이블
	String cmmnCdId;
	String cmmnCdNm;
	
	//공통자료관리 디테일
	String cmmnCdDetaId;
	String cmmnDtCdNm;
	String cmmnCdDesct;
	
}
