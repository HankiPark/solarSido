package solar.prdt.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.prdt.dao.PrdtChase;
import solar.prdt.service.PrdtChaseService;

@Controller
public class PrdtChaseController {

	@Autowired PrdtChaseService pservice;
	
	@RequestMapping("/prdt/ref/prdtLotChase")
	public String prdtLotChasePage() {
		return "prdt/ref/prdtLotChase";
	}
	@RequestMapping("/grid/prdtLotChaseList.do")
	public String prdtLotListGrid(Model model, PrdtChase vo) {
		List<?> list = pservice.findLotList(vo);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		map.put("pagination", map2);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	@RequestMapping("/grid/prdtLotChase.do")
	public String prdtLotGrid(Model model, PrdtChase vo) {
		List<?> list = pservice.prdtLotChase(vo);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
}
