package solar.eqm.mng.service.impl;

import java.util.List;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.eqm.mng.service.EqmService;
import solar.eqm.mng.service.EqmVO;

@Service 
public class EqmServiceImpl implements EqmService{
	
	@Autowired EqmMapper mapper;

	@Override
	public List<EqmVO> eqmList(EqmVO vo) {
		return mapper.eqmList(vo);
	}

	@Override
	public int eqmInsert(EqmVO vo) {
		return mapper.eqmInsert(vo);
	}

	@Override
	public int eqmDelete(EqmVO vo) {
		int result = mapper.eqmDelete(vo);
		return result;
	}

	@Override
	public int eqmUpdate(EqmVO vo) {
		int result = mapper.eqmUpdate(vo);
		return result;
	}
	
}
