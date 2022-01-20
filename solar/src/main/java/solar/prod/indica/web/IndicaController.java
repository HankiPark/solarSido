package solar.prod.indica.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prod.indica.service.IndicaService;
import solar.prod.indica.service.IndicaVO;

@Controller
public class IndicaController {
	
	@Autowired IndicaService idcService;

	//생산지시관리 페이지이동
	 @RequestMapping("/prod/indicaMng")
		public String indMng() {
			return "prod/indicaMng";
		}
	 
	//생산지시조회 페이지이동
	 @RequestMapping("/prod/indicaList")
		public String indList() {
			return "prod/indicaList";
		}
	
	 //생산지시상세 조회
	@GetMapping("/grid/indicaGrid.do")
	public String indicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectIdc(idcVo);
		Map<String,Object> map = new HashMap<>();
		map.put("contents", list);
		System.out.println("list:"+list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
		}
	
	//생산지시서검색 모달
	@RequestMapping("/modal/findIndica")
	public String findIndica() {
		System.out.println("생산지시서검색 모달호출");
		return "modal/findIndica";
	}
		
	//생산지시서검색 모달그리드
	@GetMapping("/grid/findIndica.do")
	public String findIndicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.findIndica(idcVo);
		Map<String, Object> map = new HashMap<>();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		System.out.println("map:" + map);
		return "jsonView";
	}
		
	//생산지시서검색 - 계획상세조회
	@GetMapping("/grid/searchIndica.do")
	public String selectIndicaGrid(Model model, IndicaVO idcVo) throws Exception {
		List<?> list = idcService.selectIdc(idcVo);
		model.addAttribute("data", list);
		return "jsonView";
	}
}
