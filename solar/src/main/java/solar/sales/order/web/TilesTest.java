package solar.sales.order.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TilesTest {


	@RequestMapping(value = "/tiles/test")
	public String TilesTest2(){
		System.out.println("아아아아아아악");
		return "tiles/test";
	}
}
