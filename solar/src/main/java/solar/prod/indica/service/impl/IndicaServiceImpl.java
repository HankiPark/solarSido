package solar.prod.indica.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.prod.indica.service.IndRscVO;
import solar.prod.indica.service.IndicaService;
import solar.prod.indica.service.IndicaVO;
import solar.prod.plan.service.ProdPlanVO;
import solar.sales.order.dao.ModifyVO;

@Service
public class IndicaServiceImpl implements IndicaService {
	
	@Autowired IndicaMapper idcMapper;

	@Override
	public List<?> selectIdc(IndicaVO idcVo) {
		return idcMapper.selectIdc(idcVo);
	}

	@Override
	public List<?> findIndica(IndicaVO idcVo) {
		return idcMapper.findIndica(idcVo);
	}

	@Override
	public List<?> selectRscList(IndicaVO idcVo) {
		return idcMapper.selectRscList(idcVo);
	}

	@Override
	public List<?> selectRscLot(IndicaVO idcVo) {
		return idcMapper.selectRscLot(idcVo);
	}

	@Override
	public List<?> noIndicaPlan(ProdPlanVO ppVo) {
		return idcMapper.noIndicaPlan(ppVo);
	}

	@Override
	public String makeDno() {
		return idcMapper.makeDno();
	}
	
	@Override
	public List<?> findEqmUo(IndicaVO idcVo) {
		return idcMapper.findEqmUo(idcVo);
	}

	@Override
	public String makePrdtNo() {
		return idcMapper.makePrdtNo();
	}

	@Override
	public int hiddenData(Map<String, List<IndicaVO>> map) {
		System.out.println("히든service");
		IndRscVO irVo = new IndRscVO();
		System.out.println("생산소요자재 데이터 등록");
		System.out.println(irVo);
		//idcMapper.insertRscCon(irVo);
		
		irVo = new IndRscVO();
		System.out.println("자재사용현황 데이터 등록");
		System.out.println(irVo);
		//idcMapper.insertPdRc(irVo);
		return 1;
	}

	@Override
	public List<?> rscCnt(CmmndataVO cVo) {
		return idcMapper.rscCnt(cVo);
	}

	@Override
	public int modifyData(ModifyVO<IndicaVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(IndicaVO idcVo : mvo.getCreatedRows()) {
				System.out.println("등록c:" + mvo);
				if (idcVo == mvo.getUpdatedRows().get(0)) {
					//idcMapper.insertIndica(idcVo);
					}
				//idcMapper.insertIndicaD(idcVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(IndicaVO idcVo : mvo.getDeletedRows()) {
				System.out.println("삭제:" + mvo);
				//idcMapper.deleteIndicaD(idcVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
				System.out.println(mvo.getUpdatedRows().get(0).getIndicaNo());
				if (mvo.getUpdatedRows().get(0).getIndicaNo() != null) {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
					System.out.println("수정:" + mvo);
					//idcMapper.updateIndica(idcVo);
					//idcMapper.updateIndicaD(idcVo);
					}
				} else {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
						System.out.println("등록:" + mvo);
						if (idcVo == mvo.getUpdatedRows().get(0)) {
							//idcMapper.insertIndica(idcVo);
							System.out.println("지시등록");
						}
						System.out.println("지시D등록");
						//idcMapper.insertIndicaD(idcVo);
						System.out.println("주문상세 지시량 수정");
						//idcMapper.updateOdIdQty(idcVo);
					}
				}
			}
		return 1;
	}

	@Override
	public int modifyRscCon(ModifyVO<IndRscVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(IndRscVO irVo : mvo.getCreatedRows()) {
				System.out.println("등록c:" + mvo);
				//idcMapper.insertRscCon(irVo);
				//idcMapper.insertRscOut(irVo);
				//idcMapper.updateUseRscStc(irVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(IndRscVO irVo : mvo.getDeletedRows()) {
				System.out.println("삭제:" + mvo);
				//idcMapper.insertRscCon(irVo);
				//idcMapper.insertRscOut(irVo);
				//idcMapper.updateUseRscStc(irVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
			for(IndRscVO irVo : mvo.getDeletedRows()) {
				System.out.println("수정:" + mvo);
				//idcMapper.insertRscCon(irVo);
				//idcMapper.insertRscOut(irVo);
				//idcMapper.updateUseRscStc(irVo);
				}
			}
		return 0;
	}

	@Override
	public int modifyPrdtRsc(ModifyVO<IndRscVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(IndRscVO irVo : mvo.getCreatedRows()) {
				System.out.println("등록c:" + mvo);
				//idcMapper.updateOdIdQty(irVo);
				//idcMapper.insertPdRc(irVo);
				//idcMapper.insertPdSc(irVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(IndRscVO irVo : mvo.getDeletedRows()) {
				System.out.println("삭제:" + mvo);
				//idcMapper.updateOdIdQty(irVo);
				//idcMapper.insertPdRc(irVo);
				//idcMapper.insertPdSc(irVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
			for(IndRscVO irVo : mvo.getDeletedRows()) {
				System.out.println("수정:" + mvo);
				//idcMapper.updateOdIdQty(irVo);
				//idcMapper.insertPdRc(irVo);
				//idcMapper.insertPdSc(irVo);
				}
			}
		return 0;
	}
}
