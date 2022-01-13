package solar.cmm.cmmndata.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.cmmndata.dao.CmmndataVO;
import solar.cmm.cmmndata.service.CmmndataService;
import solar.cmm.cmmndata.service.impl.CmmndataMapper;

@Controller
public class CmmndataController {

	@Autowired CmmndataService cmmndataService;
	@Autowired CmmndataMapper cmmndataMapper;
	
	@RequestMapping("common/cmmndata")
	public String cmmndataList() {
		return "common/cmmndata";
	}
	
	@GetMapping("/grid/cmmndataList.do")
	public String cmmndataList(Model model, CmmndataVO cmmndataVO) {
		
		List<?> cmmndataList = cmmndataService.cmmndataList(cmmndataVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", cmmndataList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		
		return "jsonView";
	}
	
	@GetMapping("/grid/cmmndataDetail.do")
	public String cmmndataDetailList(Model model, CmmndataVO cmmndataVO) {
		List<CmmndataVO> cmmndataDetailList = cmmndataService.cmmndataDetailList(cmmndataVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map =
				new HashMap<>();
		data.put("contents", cmmndataDetailList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);	
		return "jsonView";
	}
}
