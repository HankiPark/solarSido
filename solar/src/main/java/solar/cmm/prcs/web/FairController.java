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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.Data;
import solar.cmm.prcs.dao.FairVO;
import solar.cmm.prcs.service.FairService;
import solar.cmm.prcs.service.impl.FairMapper;

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

	
	@RequestMapping("common/fair")
	public String fairList() {
		return "common/fair";
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
	
	@RequestMapping("/grid/modifyData.do")
	@ResponseBody
	public void fairModify(@RequestBody fairGridData fairGridData) throws Exception {
		
	}
	
}
