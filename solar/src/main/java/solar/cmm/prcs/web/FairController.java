package solar.cmm.prcs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.cmm.prcs.service.impl.FairMapper;

@Controller
public class FairController {

	@Autowired FairService fairService;
	@Autowired FairMapper fairMapper;

	@RequestMapping("common/fair")
	public String fairList() {
		return "common/fair";
	}
	
	@GetMapping("/grid/fairList.do")
	public String fairList(Model model, FairVO fairVO) throws Exception {
		
		List<?> fairList = fairService.fairList(fairVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", fairList);
		map.put("page", 1);
		map.put("totalCount", data.size());
		
		model.addAttribute("data", data);
		model.addAttribute("pagination", map);
		return "jsonView";
	}
	
	@RequestMapping(value="/fairInsert", method=RequestMethod.POST)
	public String insert(FairVO fairVO) {
		fairService.insert(fairVO);
		return "fair/insert";
	} 
	
	@RequestMapping(value="/fairUpdate", method=RequestMethod.POST)
	public String update(FairVO fairVO) {
		fairService.update(fairVO);
		return "fair/update";
	}
	@RequestMapping(value="/fairRemove", method=RequestMethod.POST)
	public String remove(FairVO fairVO) {
		fairService.remove(fairVO);
		return "redirect:/fair/list";
		
	}
	
}
