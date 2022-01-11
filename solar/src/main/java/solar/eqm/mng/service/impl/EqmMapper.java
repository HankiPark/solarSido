package solar.eqm.mng.service.impl;

import java.util.List;

import solar.eqm.mng.service.EqmVO;

public interface EqmMapper {
	List<EqmVO> eqmList(EqmVO vo); 		//조회
	int eqmInsert(EqmVO vo);			//등록
	int eqmDelete(EqmVO vo);			//삭제
	int eqmUpdate(EqmVO vo); 			//수정
}
