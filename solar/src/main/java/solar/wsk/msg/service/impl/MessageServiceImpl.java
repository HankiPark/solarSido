package solar.wsk.msg.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import solar.wsk.msg.dao.MessageVO;
import solar.wsk.msg.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService{

	@Autowired MessageMapper mapper;
	@Override
	public String countMsg(String vo) {
		// TODO Auto-generated method stub
		return mapper.countMsg(vo);
	}

	@Override
	public int insertMsg(MessageVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertMsg(vo);
	}

	@Override
	public List<MessageVO> findMsg(MessageVO vo) {
		
		return mapper.findMsg(vo);
	}

	@Override
	public int deleteMsg(MessageVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteMsg(vo);
	}

	@Override
	public int updateMsg(MessageVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateMsg(vo);
	}

}
