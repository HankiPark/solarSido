package solar.cmm.prdtbom.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.cmm.prdtbom.dao.PrdtbomVO;
import solar.cmm.prdtbom.service.PrdtbomService;
import solar.cmm.prdtbom.service.impl.PrdtbomMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class PrdtbomController {

	@Autowired PrdtbomService prdtbomService;
	@Autowired PrdtbomMapper prdtbomMapper;
	
	@RequestMapping("common/prdtbom")
	public String prdtbomList() {
		return "common/prdtbom";
	}
	
	@GetMapping("/grid/prdtbomList.do")
	public String prdtbomList(Model model, PrdtbomVO prdtbomVO) throws Exception{
		List<?> prdtbomList = prdtbomService.prdtbomList(prdtbomVO);
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", prdtbomList);
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@RequestMapping("/grid/prdtbomUpdateIn.do")
	public String prdtbomUpdateIn(Model model, PrdtbomVO prdtbomVO, @RequestBody ModifyVO<PrdtbomVO> modifyVO) throws Exception
	{
		prdtbomService.modifyData(modifyVO);
		model.addAttribute("mode", "upd");
		return "jsonView";
	}
	
}
