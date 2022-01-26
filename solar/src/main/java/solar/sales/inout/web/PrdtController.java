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
		/* model.addAttribute("coList", (pservice.findCo())); */
		return "sales/mng/prdt_inout_mng";
	}
	@RequestMapping("/sales/prdt_inout_ref")
	public String prdtPageRef(Model model) {
		/* model.addAttribute("coList", (pservice.findCo())); */
		return "sales/ref/prdt_inout_ref";
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
		
		pservice.modifyData(mvo);
		model.addAttribute("mode", "upd");

		return "jsonView";

	}

	
	  //회사이름조회
	  
	  @GetMapping("/modal/coNmList") public String CoNmList() {
	  
	  return "modal/coNmList"; }
	  
	  //회사이름검색 grid 불러오기
	  
	  @GetMapping("/grid/coNmList.do") 
	  public String CoNmListGrid(Model model,Prdt  prdt) {
		  List<?> list=pservice.findCo(prdt);
	  model.addAttribute("result",true); Map<String,Object> map = new HashMap();
	  Map<String,Object> map2 = new HashMap(); map.put("contents", list);
	  map2.put("page",1); map2.put("totalCount", list.size());
	  model.addAttribute("data", map);
	  
	  return "jsonView"; }
	 
	// 전표저장 및 전표번호 재발급
	@PostMapping("/grid/slipOutputUpdate.do")
	public String slipOutputUpdate(Model model, Prdt prdt, @RequestBody ModifyVO<Prdt> mvo) {
		pservice.modifyOutData(mvo);
		
		model.addAttribute("mode", "upd");
		

		return "jsonView";
	}

	// 전표번호 조회 modal
	@GetMapping("/modal/slipOutput")
	public String SlipOutputListGrid(Model model, Prdt prdt) throws Exception {	
		/*
		 * model.addAttribute("coList", pservice.findCo());
		 * System.out.println(pservice.findCo());
		 */
		return "modal/slipNameList";
	}
	//전표번호 검색
	@GetMapping("/grid/slipList.do")
	public String showSlipNum(Model model, Prdt prdt) {
		
		List<?> list = pservice.findSlip(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);

		return "jsonView";
	}

	@GetMapping("/modal/orderList.do")
	public String orderList(Model model, Prdt prdt) {
		
		
		return "modal/orderList";
	}
	//모달창 그리드 뿌리기
	@GetMapping("/grid/outOrderList.do")
	public String orderListGird(Model model, Prdt prdt) {
		List<?> list = pservice.OutOrderList(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);

		return "jsonView";
	}
	
	//선택된 주문번호의 제품리스트불러오기
	@GetMapping("/ajax/prdList.do")
	public String ajaxPrdList(Model model, Prdt prdt) {
		List<?> list = pservice.OutOrderCdList(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	
	//출고 대기중인 물건리스트 modal
	@GetMapping("/modal/outWaitList.do")
	public String outWaitList(Model model, Prdt prdt) {
		
		
		return "modal/outWaitList";
	}
	//출고 완료 차트 modal
	@GetMapping("/modal/prdtOutChart")
	public String prdtOutChart(Model model, Prdt prdt) {
		
		
		return "modal/prdtOutChart";
	}

	
	//출고 대기중인 물건리스트 
	@GetMapping("/grid/outWaitList.do")
	public String outWaitListGrid(Model model, Prdt prdt) {
		List<?> list = pservice.OutWaitList(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);

		return "jsonView";
	}
	
	//Ow초기화
	@GetMapping("/ajax/resetOw.do")
	public String updateOw(Model model, Prdt prdt) {
		 pservice.resetOw(prdt);
		 model.addAttribute("num2", pservice.makeNum());
		
		return "jsonView";
	}
	//Ow초기화
	@GetMapping("/ajax/prdtChart.do")
	public String prdtChartData(Model model, Prdt prdt) {
		List<Prdt> list = pservice.prdtList(prdt);
		Map<String,Object> map = new HashMap();
		model.addAttribute("pr",  list);
		Prdt pd = new Prdt();
		for(int i =0;i<list.size();i++) {
			pd.setPrdtCd(list.get(i).getPrdtCd());
			map.put("da"+i, pservice.prdtChart(pd));
			
		}
		model.addAttribute("data", map);
		return "jsonView";
	}
	
	@PostMapping("/ajax/insertOw.do")
	public String updateOw2(Model model, Prdt prdt,@RequestBody ModifyVO<Prdt> mvo) {
	
		 pservice.insertOw(mvo);
		
		
		return "jsonView";
	}

	//전표 조회하기!
	@GetMapping("/grid/getSlipList.do")
	public String outSlipListGrid(Model model, Prdt prdt) {
		List<?> list = pservice.findSlipList(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	//전표조회된 결과에서 출고량 클릭시
	@GetMapping("/modal/outEndList.do")
	public String outEndList(Model model, Prdt prdt) {
		
		
		return "modal/outEndList";
	}
	
	@GetMapping("/grid/outEndList.do")
	public String outEndListGrid(Model model, Prdt prdt) {
		List<?> list = pservice.findSlipLot(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	//입출고조회
	@GetMapping("/grid/prdtSearch.do")
	public String prdtSearchGrid(Model model, Prdt prdt) {
		List<?> list = pservice.prdtSearch(prdt);
		model.addAttribute("result", true);
		Map<String, Object> map = new HashMap();
		Map<String, Object> map2 = new HashMap();
		map.put("contents", list);
		map2.put("page", 1);
		map2.put("totalCount", list.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
}
