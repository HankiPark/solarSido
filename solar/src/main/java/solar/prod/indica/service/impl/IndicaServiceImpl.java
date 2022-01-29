package solar.prod.indica.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
			System.out.println("등록:" + mvo);
			}
		if(mvo.getDeletedRows()!=null) {
			System.out.println("삭제" + mvo);
			}
		if(mvo.getUpdatedRows()!=null) {
			System.out.println("수정" + mvo);
		}
		return 1;
	}
}
