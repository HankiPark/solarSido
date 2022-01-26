package solar.rsc.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import solar.cmm.code.service.CmmnCdService;
import solar.rsc.cmmn.service.RscService;
import solar.rsc.infer.service.RscInferRate;
import solar.rsc.infer.service.RscInferService;
import solar.rsc.inout.service.RscInOut;
import solar.rsc.inout.service.RscInOutService;
import solar.rsc.ordr.service.RscOrdr;
import solar.rsc.ordr.service.RscOrdrService;
import solar.rsc.rt.service.RscRtService;
import solar.rsc.stc.service.RscStcService;
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
	@Autowired
	RscInOutService rscInOutService;
	@Autowired
	RscStcService rscStcService;
	@Autowired
	RscRtService rscRtService;
	
	//발주참조 페이지 요청
	@GetMapping("/rsc/ref/ordr")
	public String rscOrdr() {
		return "rsc/ref/ordr";
	}
	
	//발주관리 페이지 요청
	@GetMapping("/rsc/mng/ordradmin")
	public String rscOrdrAdmin() {
		return "rsc/mng/ordradmin";
	}
	
	//발주데이터
	@GetMapping("/rsc/ordrData")
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
		return "jsonView";
	}

	//자재목록 모달
	@GetMapping("/rsc")
	public String rsc() {
		return "modal/searchRsc";
	}
	
	//자재목록 데이터요청
	@GetMapping("/rsc/rscData")
	public String rscData(@RequestParam Map map, Model model) {
		model.addAttribute("rsc",rscService.search(map));
		return "jsonView";
	}
	
	//공통코드 목록 요청
	@GetMapping("/cmmn/codes")
	public String cmmnCodes(Model model) {
		model.addAttribute("codes", cmmnCdService.select(Arrays.asList("rscst","rscinfer","rsc")));
		return "jsonView";
	}
	
	//검수조회페이지 이동
	@GetMapping("/rsc/ref/insp")
	public String rscInsp() {
		return "rsc/ref/insp";
	}
	
	//검수관리페이지 이동
	@GetMapping("/rsc/mng/inspadmin")
	public String rscInspAdmin() {
		return "rsc/mng/inspadmin";
	}
	
	//검수 목록 요청
	@GetMapping("/rsc/inspData")
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
	
	//검수 모달
	@GetMapping("/rsc/inspModal")
	public String rscInspModal() {
		return "modal/searchInsp";
	}
	
	//발주데이터 dataSource modify
	@ResponseBody
	@PutMapping("/rsc/ordrData")
	public int rscOrdrData(@RequestBody ModifyVO<RscOrdr> mvo) {
		rscOrdrService.modify(mvo);
		return 201;
	}
	
	//입고관리페이지
	@GetMapping("/rsc/mng/inadmin")
	public String rscInAdmin() {
		return "rsc/mng/inadmin";
	}
	
	//입고조회페이지
	@GetMapping("/rsc/ref/in")
	public String rscIn() {
		return "rsc/ref/in";
	}
	
	//입고조회페이지 데이터
	@GetMapping("/rsc/inData")
	public String rscInData(@RequestParam Map map, Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscInOutService.search(map);
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	//입고 처리 요청
	@ResponseBody
	@PostMapping("/rsc/in/rscin")
	public int rscIn(@RequestBody RscInOut rscInOut, Model model) {
		rscInOutService.insert(rscInOut);
		rscInOutService.stcInc(rscInOut);
		return 202;
	}
	
	//출고페이지
	@GetMapping("/rsc/ref/out")
	public String rscOut() {
		return "rsc/ref/out";
	}
	
	//자재재고페이지
	@GetMapping("/rsc/ref/stc")
	public String rscStc() {
		return "rsc/ref/stc";
	}
	
	//재고데이터 요청
	@GetMapping("/rsc/stcData")
	public String rscStcData(@RequestParam Map map, Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscStcService.search(map);
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	//자재반품페이지 요청
	@GetMapping("/rsc/ref/rt")
	public String rscRt() {
		return "rsc/ref/rt";
	}
	
	//자재반품데이터요청
	@GetMapping("/rsc/rtData")
	public String rscRtData(@RequestParam Map map, Model model) {
		Map<String,Object> data = new HashMap<String, Object>();
		Map<String,Object> page = new HashMap<String, Object>();
		List<?> list = rscRtService.search(map);
		
		model.addAttribute("result",true);
		
		page.put("page", 1);
		page.put("totalCount", list.size());
		
		data.put("contents", list);
		data.put("pagination", page);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	//불량률그래프
	@GetMapping("/rsc/ref/inferGraph")
	public String rscInferGraph() {
		return "rsc/ref/infergraph";
	}
	
	//불량률그래프 데이터
	@PostMapping("/rsc/inferGraphData")
	public String rscInferGraphData(@RequestBody Map map, Model model) {
		System.out.println(map);
		List<RscInferRate> list = rscInferService.getQuarteredInferRate(map);
		System.out.println(list);
		model.addAttribute("inferRates",list);
		return "jsonView";
	}
	
}