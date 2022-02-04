package solar.prcs2.web;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
@Component
public class Prcs2Scheduler {
	@Scheduled(fixedDelay=2000)
	public void sch() {
		
	}
	
}
