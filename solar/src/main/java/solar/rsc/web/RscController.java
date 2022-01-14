package solar.rsc.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.cmm.code.service.CmmnCdService;
import solar.rsc.cmmn.service.RscService;
import solar.rsc.infer.service.RscInferService;
import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class RscController {

	@Autowired
	RscOrdrService rscOrdrService;
	@Autowired
	RscService rscService;
	@Autowired
	RscInferService rscInferService;
	@Autowired
	CmmnCdService cmmnCdService;
	
	@GetMapping("rsc/ordr")
	public String rscOrdr() {
		return "rsc/ordr";
	}

	@GetMapping("rsc/ordrData")
	public String rscOrdrData(@RequestParam Map<String,String> map, Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscOrdrService.search(map);
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		System.out.println(model);
		return "jsonView";
	}

	@GetMapping("co")
	public String getCo() {
		return "modal/searchCo";
	}
	
	@GetMapping("rsc")
	public String rsc() {
		return "modal/searchRsc";
	}
	
	@GetMapping("rsc/rscData")
	public String rscData(Model model) {
		model.addAttribute("rsc",rscService.selectAll());
		return "jsonView";
	}
	
	@GetMapping("cmmn/codes")
	public String cmmnCodes(Model model) {
		model.addAttribute("codes", cmmnCdService.select(Arrays.asList("rscst","rscinfer","rsc")));
		return "jsonView";
	}
	
	//검수관리페이지 이동
	@GetMapping("rsc/insp")
	public String rscInsp(Model model) {
		return "rsc/insp";
	}
	
	//
	@GetMapping("rsc/inspData")
	public String rscInspData(/*@RequestParam Map<String,String> map, */Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscInferService.selectAll();
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	@GetMapping("rsc/inspModal")
	public String rscInspModal() {
		return "modal/searchInsp";
	}
	
	@ResponseBody
	@PutMapping("rsc/ordrData")
	public int rscOrdrData(@RequestBody ModifyVO<RscOrdr> mvo) {
		rscOrdrService.modify(mvo);
		return 201;
	}
	
	@GetMapping("rsc/inout")
	public String rscInOut() {
		return "rsc/inout";
	}
	
	@GetMapping("rsc/inoutData")
	public String rscInoutData(Model model) {
		return "";
	}

}