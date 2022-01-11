package solar.eqm.mng.service;

import java.util.List;
 
public interface EqmService {
	List<EqmVO> eqmList(EqmVO vo); 		//조회
	int eqmInsert(EqmVO vo);			//등록
	int eqmDelete(EqmVO vo);			//삭제
	int eqmUpdate(EqmVO vo); 			//수정
}
