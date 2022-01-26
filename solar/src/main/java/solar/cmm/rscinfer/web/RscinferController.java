package solar.cmm.rscinfer.web;

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

import solar.cmm.rscinfer.dao.RscinferVO;
import solar.cmm.rscinfer.service.RscinferService;
import solar.cmm.rscinfer.service.impl.RscinferMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class RscinferController {

	@Autowired RscinferService rscinferService;
	@Autowired RscinferMapper rscinferMapper;
	
	
	@RequestMapping("common/rscinfer")
	public String rscinferList() {
		return "common/mng/rscinfer";
	}
	
	@GetMapping("grid/rscinferList.do")
	public String rscinferList(Model model, RscinferVO rscinferVO) throws Exception{
		List<?> rscinferList = rscinferService.rscinferList(rscinferVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", rscinferList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@PostMapping("/grid/rscinferModify.do")
	public String insertUpdate(Model model, RscinferVO rscinferVO, @RequestBody ModifyVO<RscinferVO> modifyVO) throws Exception{
		rscinferService.modifyData(modifyVO);
		model.addAttribute("mode", "upd");
		
		return "jsonView";
	}
	
	@GetMapping("/grid/rscinferdataFind")
	public String rscinferFind(Model model, RscinferVO rscinferVO) throws Exception{
		
		List<?> rscinferList = rscinferService.rscinferdataFind(rscinferVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", rscinferList);
		map2.put("page", 1);
		map2.put("totalCount", rscinferList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
}
