package solar.sales.inout.web;

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

import solar.sales.inout.dao.Prdt;
import solar.sales.inout.service.PrdtService;
import solar.sales.order.dao.ModifyVO;

@Controller
public class PrdtController {

	@Autowired
	PrdtService pservice;

	// 입출고관리 페이지 open
	@RequestMapping("/sales/prdt_inout_mng")
	public String prdtPage(Model model) {
		model.addAttribute("num", pservice.makeNum());
		return "sales/prdt_inout_mng";
	}

	// 입출고 조회
	@RequestMapping("/grid/prdtInput.do")
	public String prdtList(Model model, Prdt prdt) throws Exception {
		List<?> list = pservice.findList(prdt);
		Map<String, Object> map = new HashMap();
		map.put("contents", list);
		model.addAttribute("result", true);
		model.addAttribute("data", map);

		return "jsonView";
	}

	// 제품명 조회
	@RequestMapping("/modal/prdtNmList")
	public String prdtNmList(Model model, Prdt prdt) throws Exception {
		return "modal/prdtNmList";
	}

	// 제품입고대기목록 조회
	@RequestMapping("/modal/prdtInWaitList")
	public String prdtInWait(Model model, Prdt prdt) throws Exception {
		return "modal/prdtInWaitList";
	}

	// 제품 검색 그리드
	@GetMapping("/grid/prdtNmList.do")
	public String orderDetailListGrid(Model model, Prdt prdt) throws Exception {
		List<?> list = pservice.findPrdt(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);

		return "jsonView";
	}

	// 입고 그리드 업데이트(저장)
	@PostMapping("/grid/prdtInputUpdate.do")
	public String insertInput(Model model, Prdt prdt, @RequestBody ModifyVO<Prdt> mvo) throws Exception {
		System.out.println(mvo);
		pservice.modifyData(mvo);
		model.addAttribute("mode", "upd");

		return "jsonView";

	}

	/*
	 * //회사이름조회
	 * 
	 * @GetMapping("/modal/coNmList") public String CoNmList() {
	 * 
	 * return "modal/coNmList"; }
	 * 
	 * //회사이름검색 grid 불러오기
	 * 
	 * @GetMapping("/grid/coNmList.do") public String CoNmListGrid(Model model,Prdt
	 * prdt) { List<?> list=pservice.findCo(prdt);
	 * model.addAttribute("result",true); Map<String,Object> map = new HashMap();
	 * Map<String,Object> map2 = new HashMap(); map.put("contents", list);
	 * map2.put("page",1); map2.put("totalCount", list.size());
	 * model.addAttribute("data", map);
	 * 
	 * return "jsonView"; }
	 */
	// 전표저장 및 전표번호 재발급
	@PostMapping("/grid/slipOutputUpdate.do")
	public String slipOutputUpdate(Model model, Prdt prdt, @RequestBody ModifyVO<Prdt> mvo) {
		pservice.modifyOutData(mvo);
		model.addAttribute("mode", "upd");
		model.addAttribute("num", pservice.makeNum());
		model.addAttribute("coList", pservice.findCo());

		return "jsonView";
	}

	// 전표번호 조회
	@GetMapping("/modal/slipOutput")
	public String SlipOutputListGrid(Model model, Prdt prdt) throws Exception {

		return "modal/SlipNameList";
	}

	@GetMapping("/ajax/showSlipNum.do")
	public String showSlipNum(Model model, Prdt prdt) {

		/*
		 * List<?> list = pservice.findSlip(prdt); model.addAttribute("result", true);
		 * Map<String, Object> map = new HashMap(); Map<String, Object> map2 = new
		 * HashMap(); map.put("contents", list); map2.put("page", 1);
		 * map2.put("totalCount", list.size()); model.addAttribute("data", map);
		 */
		return "jsonView";
	}

}
