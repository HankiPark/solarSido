package solar.prcs.prcs.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prcs.prcs.service.IndicaVO;
import solar.prcs.prcs.service.PrcsService;

@Controller
public class PrcsController {

	@Autowired PrcsService prcsservice;
	
	@RequestMapping("/prcs")									// 공정관리 페이지 이동
	public String go() {
		return "prcs/prcsprog";
	}
	
	/*------------------------------------------------------------------------------------------------ */
	// 생산지시검색 / 자재 / 제품 LOT 제외
	
	@RequestMapping("/modal/searchIndicaDetail")				// 생산지시상세 Modal 페이지 호출
	public String callIndicaModal() {
		return "modal/searchIndicaDetail";
	}
	
	@GetMapping("/modal/searchIndicaDetail/indica")				// 생산지시상세 Modal 페이지 데이터 호출
	public String insIndicaModal(IndicaVO vo, Model model) {
			
		Map<String, Object> map = new HashMap();
		map.put("contents", prcsservice.selectPDay(vo));
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	/*------------------------------------------------------------------------------------------------ */
	// 공정명검색
	
	
	
	
}
