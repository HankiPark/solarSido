package solar.cmm.prdt.web;

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

import solar.cmm.prdt.dao.PrdtInferVO;
import solar.cmm.prdt.service.CmmPrdtService;
import solar.cmm.prdt.service.impl.CmmPrdtMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class CmmPrdtController {

	@Autowired CmmPrdtService prdtService;
	@Autowired CmmPrdtMapper prdtMapper;
	
	@RequestMapping("common/prdtinfer")
	public String prdtList() {
		return "common/mng/prdtinfer";
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
	
	@PostMapping("/grid/prdtinferModify.do")
	public String insertUpdate(Model model, PrdtInferVO prdtInferVo, @RequestBody ModifyVO<PrdtInferVO> modifyVO) throws Exception{
		prdtService.modifyData(modifyVO);
		model.addAttribute("mode", "upd");
		
		return "jsonView";
	}
	
	@GetMapping("/grid/prdtinferdataFind")
	public String prdtinferfind(Model model, PrdtInferVO prdtInferVO) throws Exception{
		
		List<?> prdtinferList = prdtService.prdtinferdataFind(prdtInferVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", prdtinferList);
		map2.put("page", 1);
		map2.put("totalCount", prdtinferList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
}
