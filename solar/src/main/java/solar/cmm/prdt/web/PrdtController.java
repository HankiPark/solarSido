package solar.cmm.prdt.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.prdt.service.PrdtService;
import solar.cmm.prdt.service.impl.PrdtMapper;

@Controller
public class PrdtController {

	@Autowired PrdtService prdtService;
	@Autowired PrdtMapper prdtMapper;
	
	@RequestMapping("common/prdtinfer")
	public String prdtList() {
		return "common/prdtinfer";
	}
	
	@GetMapping("/grid/prdtList.do")
	public String prdtList(Model model, PrdtInferVO prdtInferVO) {
		List<?> prdtList = prdtService.prdtList(prdtInferVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", prdtList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
}
