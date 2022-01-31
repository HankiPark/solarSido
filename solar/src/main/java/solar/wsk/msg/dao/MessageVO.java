package solar.wsk.msg.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class MessageVO {

	String userId;
	String msTitle;
	String readYn;
	String msContent;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd",timezone="Asia/Seoul")
	Date msDt;
}
