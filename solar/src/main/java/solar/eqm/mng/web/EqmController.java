package solar.eqm.mng.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import solar.eqm.mng.service.EqmService;
import solar.eqm.mng.service.EqmVO;
import solar.eqm.unop.service.impl.UnopMapper;
import solar.sales.order.dao.ModifyVO;

@Controller
public class EqmController {
	
	@Autowired EqmService eqmService;
	@Autowired UnopMapper unopMapper;
	
	//설비관리페이지 이동
	@RequestMapping("/eqm/mng/eqmMng")
	public String eqmList(Model model, EqmVO vo) {
		return "eqm/mng/eqmMng";
	}
	
	//설비목록
	@GetMapping("/grid/eqmList.do")
	public String eqmListGrid(Model model,@RequestParam Map map) throws Exception {
		List<?> eqmList = eqmService.eqmList(map);
    	
    	Map<String,Object> data = new HashMap<>();
		data.put("contents", eqmList);
		
		model.addAttribute("result", true);
		
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	//설비 추가
	@PutMapping("/eqm/grid/eqmPut")
	public String rscOrdrData(@RequestBody ModifyVO<EqmVO> mvo, Model model) {
		String queryResult = eqmService.modifyData(mvo);
		if(!queryResult.equals("true")) {
			model.addAttribute("queryResult",queryResult);
		} else {
			model.addAttribute("queryResult","true");
		}
		return "jsonView";
	}
	
	//비가동관리 페이지
	@GetMapping("/eqm/mng/unop")
	public String unop() {
		return "eqm/mng/unop";
	}
	
	//비가동코드 전체 ajax
	@GetMapping("/ajax/unopcd")
	public String unopCdsAll(Model model){
		model.addAttribute("unopCds", unopMapper.selectUnopCdAll());
		return "jsonView";
	}
	
	//비가동YN
	@GetMapping("/ajax/eqmtoggle")
	public String eqmtoggle(@RequestParam Map map, Model model) {
		unopMapper.updateEqmYn(map);
		
		if(map.get("uoprCd")!=null) {
			unopMapper.eqmuoInsert(map);
		} else {
			unopMapper.updateToTm(map);
		}
		
		return "jsonView";
	}
	
	//비가동목록 data
	@GetMapping("/grid/eqm/uoList")
	public String uoList(@RequestParam Map map, Model model) {
		System.out.println(map);
		List<?> uoList = unopMapper.selectUnopList(map);
    	
    	Map<String,Object> data = new HashMap<>();
		data.put("contents", uoList);
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		
		return "jsonView";
	}
	
	//비가동 그리드 더블클릭 단건
	@GetMapping("/ajax/eqm/uoselect")
	public String uoselect(@RequestParam Map map, Model model) {
		model.addAttribute("unop", unopMapper.selectUnop(map));
		return "jsonView";
	}
	
	//비가동 조회 페이지
	@GetMapping("/eqm/ref/unopref")
	public String unopRef() {
		return "eqm/ref/unopref";
	}
}
