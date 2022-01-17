package solar.cmm.uoprcd.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.cmm.uoprcd.dao.UoprcdVO;
import solar.cmm.uoprcd.service.UoprcdService;
import solar.cmm.uoprcd.service.impl.UoprcdMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class UoprcdController {

	@Autowired UoprcdService uoprcdService;
	@Autowired UoprcdMapper uoprcdMapper;
	@Autowired FairService fairService;
	
	@RequestMapping("common/uoprcd")
	public String uoprcdList() {
		return "common/uoprcd";
	}
	@RequestMapping("modal/prcsinfoList")
	public String prcsinfoList(Model model, UoprcdVO uoprcdVO) throws Exception{
		return "modal/prcsinfoList";
	}
	
	@GetMapping("/grid/uoprcdList.do")
	public String uorpcdList(Model model, UoprcdVO uoprcdVO) {
		
		List<?> uoprcdList = uoprcdService.uoprcdList(uoprcdVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", uoprcdList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		
		return "jsonView";
	}	
	@GetMapping("/grid/prcsinfoModal")
	public String prcsinfoList(Model model, FairVO fairVO) throws Exception {
		
		List<?> prcslist = fairService.fairList(fairVO);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", prcslist);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	@GetMapping("/grid/findPrcs")
	public String prcsfind(Model model, FairVO fairVO) throws Exception{
		
		List<?> prcsList = fairService.findPrcs(fairVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", prcsList);
		map2.put("page", 1);
		map2.put("totalCount", prcsList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	
	@PostMapping("/grid/uoprcdUpdate.do")
	public String insertUpdate(Model model, UoprcdVO uoprcdVO, @RequestBody ModifyVO<UoprcdVO> mvo) throws Exception{
		System.out.println(mvo);
		uoprcdService.modifyData(mvo);
		model.addAttribute("mode", "upd");
		
		return "jsonView";
	}
}
