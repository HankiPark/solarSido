package solar.wsk.msg.service;

import java.util.List;

import solar.wsk.msg.dao.MessageVO;

public interface MessageService {
	List<MessageVO> findMsg(MessageVO vo);
	String countMsg(String vo);
	int insertMsg(MessageVO vo);
	int updateMsg(MessageVO vo);
	int deleteMsg(MessageVO vo);
}
