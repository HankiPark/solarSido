package solar.wsk.msg.web;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import solar.wsk.msg.dao.MsgVO;

@Controller
public class SocketHandlerController extends TextWebSocketHandler implements InitializingBean {
	Logger logger = LoggerFactory.getLogger(SocketHandlerController.class);
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();

	@Autowired
	//private BoardService boardService;

	public SocketHandlerController (){ 
		super();
		this.logger.info("create SocketHandler instance!");
	}

	@Override
//onClose
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		sessionSet.remove(session);
		this.logger.info("remove session!");
	}

	@Override
	//onOpen 
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		sessionSet.add(session);
		
	    Map<String, Object> map = session.getAttributes();
	    String id = (String)map.get("loginvo");
		this.logger.info("loginid:"+id); 
		
		this.logger.info("add session!"); 
} 
	@Override
	//onMessage 
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception { super.handleMessage(session, message);
	this.logger.info("receive message:"+message.toString()); //json string을 vo로 변환
		ObjectMapper mapper = new ObjectMapper();
		MsgVO msgvo = mapper.readValue((String) message.getPayload(), MsgVO.class);
		String msg = "";
		MsgVO result = new MsgVO();
		if(msgvo.getCmd().equals("msg")) {
			msg = (String) message.getPayload();
		} else if(msgvo.getCmd().equals("board")) {
			//String board = mapper.writeValueAsString(boardService.getBoardList(null)) ;
			//result.setCmd("board");
			//result.setMsg(board);
			msg = mapper.writeValueAsString(result) ;			
		}
		sendMessage(msg);
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		this.logger.error("web socket error!", exception);
	}

	@Override
	public boolean supportsPartialMessages() {
		this.logger.info("call method!"); 
		return super.supportsPartialMessages();
	}

	public void sendMessage(String message) {
		for (WebSocketSession session : this.sessionSet) {
			if (session.isOpen()) {
				try {
					session.sendMessage(new TextMessage(message));
				} catch (Exception ignored) {
					this.logger.error("fail to send message!", ignored);
				}
			}
		}
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Thread thread = new Thread() {
			int i = 0;

			@Override
			public void run() {
				while (true) {
					try {
						sendMessage("send message index " + i++);
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						e.printStackTrace();
						break;
					}
				}
			}
		};
		//thread.start();
	}
}
