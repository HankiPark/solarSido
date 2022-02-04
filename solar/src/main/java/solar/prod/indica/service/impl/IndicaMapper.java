package solar.prod.indica.service.impl;

import java.util.List;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.prod.indica.service.IndRscVO;
import solar.prod.indica.service.IndicaVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

public interface IndicaMapper {

	List<?> selectIdc(IndicaVO idcVo);
	
	List<?> findIndica(IndicaVO idcVo);
	
	List<?> selectRscList(IndicaVO idcVo);
	
	List<?> selectRscLot(IndicaVO idcVo);
	
	List<?> noIndicaPlan(ProdPlanVO ppVo);

	List<?> findEqmUo(IndicaVO idcVo);
	
	List<?> rscCnt(CmmndataVO cVo);

	String makeDno();
	
	String makePrdtNo();
	
	//modify
	int modifyData(ModifyVO<IndicaVO> mvo);
	int modifyRscCon(ModifyVO<IndRscVO> mvo);
	int modifyPrdtRsc(ModifyVO<IndRscVO> mvo);
	
	//생산지시 등록
	int insertIndica(IndicaVO idcVo);
	int insertIndicaD(IndicaVO idcVo);
	//생산지시 수정
	int updateIndica(IndicaVO idcVo);
	int updateIndicaD(IndicaVO idcVo);
	//생산지시 삭제
	int deleteIndica(IndicaVO idcVo);
	int deleteIndicaD(IndicaVO idcVo);
	
	//타테이블 데이터 변경
	int insertPdRc(IndRscVO iprVo);
	int updateOdIdQty(IndicaVO idcVo);
}
