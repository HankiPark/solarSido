package solar.cmm.prcs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.cmm.prcs.service.impl.FairMapper;

@Controller
@RequestMapping("/fair/")
public class FairController {

	@Autowired FairService fairService;
	@Autowired FairMapper fairMapper;

	@RequestMapping(value="/fairSelect")
	public String list(Model model, FairVO fairVO) {
		model.addAttribute("list", fairService.fairList(fairVO));
		return "/fair/list";
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
