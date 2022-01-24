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
import solar.cmm.rscinfo.dao.RscinfoVO;
import solar.cmm.rscinfo.service.RscinfoService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class PrdtbomController {

	@Autowired PrdtbomService prdtbomService;
	@Autowired PrdtbomMapper prdtbomMapper;
	@Autowired RscinfoService rscinfoService;
	
	@RequestMapping("common/prdtbom")
	public String prdtbomList() {
		return "common/prdtbom";
	}
	
	@RequestMapping("modal/prdtlistbom")
	public String prdtbommodal() {
		return "modal/prdtlistbom";
	}
	@RequestMapping("modal/rscinfoList")
	public String rscinfoList(Model model, RscinfoVO rscinfoVO) throws Exception{
		return "modal/rscinfoList";
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
	
	@GetMapping("/grid/prdtmodalList.do")
	public String prdtmodalList(Model model, PrdtbomVO prdtbomVO) throws Exception{
		List<?> prdtList = prdtbomService.prdtList(prdtbomVO);
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", prdtList);
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@GetMapping("/grid/prdtinfoSearch")
	public String prdtfind(Model model, PrdtbomVO prdtbomVO) throws Exception{
		
		List<?> prdtList = prdtbomService.prdtinfoFind(prdtbomVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", prdtList);
		map2.put("page", 1);
		map2.put("totalCount", prdtList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	@GetMapping("/grid/rscinfoModal")
	public String rscinfoModalList(Model model, RscinfoVO rscinfoVO) throws Exception {
		
		List<?> rsclist = rscinfoService.rscinfoList(rscinfoVO);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", rsclist);
		model.addAttribute("result", true);
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	@GetMapping("/grid/findRsc")
	public String findPrcs(Model model, RscinfoVO rscinfoVO) throws Exception{
		
		List<?> rscList = rscinfoService.findRsc(rscinfoVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", rscList);
		map2.put("page", 1);
		map2.put("totalCount", rscList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	@GetMapping("/grid/prdtbomSearch")
	public String prdtbomSearch(Model model, PrdtbomVO prdtbomVO) throws Exception{
		
		List<?> prdtbomList = prdtbomService.prdtbomSearch(prdtbomVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", prdtbomList);
		map2.put("page", 1);
		map2.put("totalCount", prdtbomList.size());
		model.addAttribute("data", map);
		
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
