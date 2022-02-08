package solar.prcs.prcs;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Service;

@Service
public class SchedulerService {
	
	private Map<String, ScheduledFuture<?>> scheduledTasks = new ConcurrentHashMap<>();
	
	@Autowired
	private TaskScheduler taskScheduler;
	
	public void register(String scheduledId) {
		ScheduledFuture<?> task = taskScheduler.scheduleAtFixedRate(() ->
		Log.info("Hello test Working = {}"
				
				),2000);
		
		scheduledTasks.put(scheduledId, task);
	}
	
	public void remove(String scheduledId) {
		Log.info(scheduledId+"를 종료합니다");
		scheduledTasks.get(scheduledId).cancel(true);
	}
	
	
	
}
