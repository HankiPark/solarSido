package solar.wsk.msg.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import solar.wsk.msg.dao.MessageVO;
import solar.wsk.msg.service.MessageService;

@Controller
public class MessageController {

	@Autowired MessageService mservice;
	
	@RequestMapping("/ajax/webinsert")
	public String webInsert(Model model,MessageVO mes) {
		mservice.insertMsg(mes);
		model.addAttribute("count", mservice.countMsg(mes.getUserId()));
		return "jsonView";
	}
	
	@RequestMapping("/ajax/webcount")
	public String webCount(Model model,MessageVO mes) {
		model.addAttribute("count",mservice.countMsg(mes.getUserId()));
		return "jsonView";
	}
	@RequestMapping("/ajax/webcontent")
	public String webContent(Model model,MessageVO mes) {
		model.addAttribute("main",mservice.findMsg(mes));
		mservice.updateMsg(mes);
		return "jsonView";
	}
}
