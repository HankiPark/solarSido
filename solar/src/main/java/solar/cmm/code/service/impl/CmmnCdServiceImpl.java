package solar.cmm.code.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.cmm.code.service.CmmnCdService;

@Service
public class CmmnCdServiceImpl implements CmmnCdService {

	@Autowired CmmnCdMapper cmmnCdMapper;
	
	@Override
	public Map<String, List<Map>> select(List<String> cds) {
		Map<String, List<Map>> map = new HashMap<String, List<Map>>();
		for(String cd:cds) {
			map.put(cd,cmmnCdMapper.select(cd));
		}
		return map;
	}
	
	@Override
	public Map<String, List<Map>> selectCd(List<String> cds) {
		Map<String, List<Map>> map = new HashMap<String, List<Map>>();
		for(String cd:cds) {
			map.put(cd,cmmnCdMapper.selectCd(cd));
		}
		return map;
	}

}
