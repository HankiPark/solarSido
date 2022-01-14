package solar.prcs.prcs.service;

import java.util.List;

public interface PrcsService {

	List<PrcsVO> selectAll();
	List<IndicaVO> selectPDay(IndicaVO vo);
	/* List<ClotVO> selectPrcsItem(ClotVO vo); */
}
