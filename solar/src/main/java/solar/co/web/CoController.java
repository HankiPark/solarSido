package solar.co.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import solar.co.cmmn.service.CoService;

@Controller
public class CoController {
	
	@Autowired
	CoService coService;
	
	//업체목록 모달
	@GetMapping("/modal/co")
	public String getCo() {
		return "modal/searchCo";
	}
	
	//업체 다중선택 모달
	@GetMapping("/modal/comul")
	public String getCoMul() {
		return "modal/searchCoMul";
	}
	
	//업체목록 모달 데이터
	@GetMapping("co/coData")
	public String getCoData(@RequestParam Map map, Model model) {
		model.addAttribute("co", coService.search(map));
		return "jsonView";
	}
}
