package solar.prod.indica.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.cmmndata.dao.CmmndataVO;
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
	public int modifyData(ModifyVO<IndicaVO> mvo) {
		if(mvo.getCreatedRows()!=null) {
			for(IndicaVO idcVo : mvo.getCreatedRows()) {
				System.out.println("등록:" + mvo);
				idcMapper.insertIndicaD(idcVo);
				}
			}
		if(mvo.getDeletedRows()!=null) {
			for(IndicaVO idcVo : mvo.getDeletedRows()) {
				System.out.println("삭제:" + mvo);
				idcMapper.deleteIndicaD(idcVo);
				}
			}
		if(mvo.getUpdatedRows()!=null) {
				System.out.println(mvo.getUpdatedRows().get(0).getIndicaNo());
				if (mvo.getUpdatedRows().get(0).getIndicaNo() != null) {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
					System.out.println("수정:" + mvo);
					idcMapper.updateIndica(idcVo);
					idcMapper.updateIndicaD(idcVo);
					}
				} else {
					for(IndicaVO idcVo : mvo.getUpdatedRows()) {
						System.out.println("등록:" + mvo);
						if (idcVo == mvo.getUpdatedRows().get(0)) {
							idcMapper.insertIndica(idcVo);
						}
						idcMapper.insertIndicaD(idcVo);
					}
				}
			}
		return 1;
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
		return 1;
	}

	@Override
	public List<?> rscCnt(CmmndataVO cVo) {
		return idcMapper.rscCnt(cVo);
	}
	
	
}
