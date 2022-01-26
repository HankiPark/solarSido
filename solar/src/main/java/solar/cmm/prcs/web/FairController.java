package solar.cmm.prcs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Data;
import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.cmm.prcs.service.impl.FairMapper;
import solar.sales.order.dao.ModifyVO;

@Data
class fairGridData {
	private List<FairVO> createRows;
	private List<FairVO> updateRows;
	private List<FairVO> deleteRows;	
}

@Controller
public class FairController {
	
	@Autowired FairService fairService;
	@Autowired FairMapper fairMapper;

	
	@RequestMapping("common/mng/fair")
	public String fairList() {
		return "common/mng/fair";
	}
	
	@GetMapping("/grid/fairList.do")
	public String fairList(Model model, FairVO fairVO) throws Exception {
		List<?> fairList = fairService.fairList(fairVO);		
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> map = new HashMap<>();
		data.put("contents", fairList);		
		model.addAttribute("result", true);
		model.addAttribute("data", data);
		return "jsonView";
	}
	
	
	@RequestMapping("/grid/fairUpdateIn.do")
	public String fairUpdateIn(Model model, FairVO fairVO, @RequestBody ModifyVO<FairVO> mvo) throws Exception
	{
		fairService.modifyData(mvo);
		model.addAttribute("mode","upd");
		return "jsonView";
	}
	
	@GetMapping("/grid/prcsdataFind")
	public String cmmnfind(Model model, FairVO fairVO) throws Exception{
		
		List<?> prcsList = fairService.prcsdataFind(fairVO);
		model.addAttribute("result", true);
		Map<String, Object>map = new HashMap();
		Map<String, Object>map2 = new HashMap();
		map.put("contents", prcsList);
		map2.put("page", 1);
		map2.put("totalCount", prcsList.size());
		model.addAttribute("data", map);
		
		return "jsonView";
	}
	
	
}
