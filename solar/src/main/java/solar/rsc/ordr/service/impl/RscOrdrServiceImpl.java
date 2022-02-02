	package solar.rsc.ordr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;
import solar.rsc.rt.service.impl.RscRtMapper;
import solar.sales.order.dao.ModifyVO;

@Service
public class RscOrdrServiceImpl implements RscOrdrService {

	@Autowired
	RscOrdrMapper rscOrdrMapper;
	@Autowired
	RscRtMapper rscRtMapper;
	
	
	@Override
	public List<RscOrdr> search(Map map) {
		return rscOrdrMapper.search(map);
	}

	@Override
	public void modify(ModifyVO<RscOrdr> mvo) {
		
		if(mvo.getCreatedRows() != null) {
			for(RscOrdr rscOrdr : mvo.getCreatedRows()) {
				rscOrdrMapper.insert(rscOrdr);
			}
		}
		
		if(mvo.getUpdatedRows() != null) {
			for(RscOrdr rscOrdr : mvo.getUpdatedRows()) {
				System.out.println("@@@@@@@@");
				System.out.println(rscOrdr);
				rscOrdrMapper.update(rscOrdr);
				
				if(rscOrdr.getInspCls().equals("rs002") && !rscOrdr.getRscInferQty().equals("0")) {
					Map<Object,Object> map = new HashMap<Object, Object>();
					map.put("rtngdResnCd", rscOrdr.getRtngdResnCd());
					map.put("ordrCd", rscOrdr.getOrdrCd());
					map.put("rscCd", rscOrdr.getRscCd());
					map.put("ordrDt", rscOrdr.getOrdrDt());
					System.out.println(map);
					rscRtMapper.insert(map);
				}
			}
		}
		if(mvo.getDeletedRows() != null) {
			for(RscOrdr rscOrdr : mvo.getDeletedRows()) {
				rscOrdrMapper.delete(rscOrdr);
			}
		}
	}
}