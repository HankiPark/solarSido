package solar.prcs2.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Service;

import solar.prcs2.web.Prcs2Scheduler;

@Service
public class SchedulerService {
	private Map<String, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();
	
	@Autowired
	private TaskScheduler taskScheduler;
	@Autowired
	Prcs2Scheduler prcs;
	public void register() {
		ScheduledFuture<?> task = taskScheduler.scheduleAtFixedRate(()->{try {
			prcs.sch2();
		} catch (Exception e) {
			e.printStackTrace();
		}}, 2000);
		scheduledTasks.put("mySchedulerId", task);
	}
	
	public void remove() {
		scheduledTasks.get("mySchedulerId").cancel(true);
	}
	

}
