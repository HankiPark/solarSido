package solar.eqm.mng.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import solar.eqm.mng.service.EqmService;
import solar.eqm.mng.service.EqmVO;
import solar.sales.order.dao.ModifyVO;

@Service 
public class EqmServiceImpl implements EqmService{
	
	@Autowired EqmMapper mapper;

	@Override
	public List<EqmVO> eqmList(Map map) {
		return mapper.eqmList(map);
	}

	@Override
	public String modifyData(ModifyVO<EqmVO> mvo) {
		String duplicatedEqmCds = "";
		
		if(mvo.getCreatedRows() != null	) {
			
			for(EqmVO eqmVo : mvo.getCreatedRows()) {
				
				try {
				mapper.insert(eqmVo);
				} catch (DuplicateKeyException e) {
					System.out.println("중복됨");
					duplicatedEqmCds += ","+eqmVo.getEqmCd();
				}
			}
		}
		
		System.out.println(duplicatedEqmCds);
		if(duplicatedEqmCds.length()==0) {
			return "true";
		} else {
			duplicatedEqmCds = duplicatedEqmCds.substring(1);
			return duplicatedEqmCds;
		}
	}

}
