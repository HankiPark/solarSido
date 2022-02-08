package solar.sales.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class CalendarVO {
	String title;
	String url;
	String etc;
	String etc2;
	String etc3;
	String etc4;
	String etc5;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date start;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date end;
}
