package solar.wsk.msg.web;

import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

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

@Controller
public class SocketHandlerController extends TextWebSocketHandler implements InitializingBean {
	Logger logger = LoggerFactory.getLogger(SocketHandlerController.class);
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	@Autowired
	//private BoardService boardService;

	public SocketHandlerController (){ 
		super();
		this.logger.info("create SocketHandler instance!");
	}

	@Override
//onClose
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
			sessionSet.remove(session);
		}
	}

	@Override
	//onOpen 
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			log(senderId + " 연결 됨");
			users.put(senderId, session);   // 로그인중 개별유저 저장
		}
} 
	@Override
	//onMessage 
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception { 
		String senderId = getMemberId(session);
	// 특정 유저에게 보내기
	String msg = (String)message.getPayload();
	if(msg != null) {
		String[] strs = msg.split(",");
		log(strs.toString());
		if(strs != null && strs.length == 4) {
			String type = strs[0];
			String target = strs[1]; // m_id 저장
			String content = strs[2];
			String url = strs[3];
			WebSocketSession targetSession = users.get(target);  // 메시지를 받을 세션 조회
			
			// 실시간 접속시
			if(targetSession!=null) {
				// ex: [&분의일] 신청이 들어왔습니다.
				TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + type + "</b>] " + content + "</a>" );
				targetSession.sendMessage(tmpMsg);
			}
		}
	}
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
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	// 웹소켓에 id 가져오기
    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_id = (String) httpSession.get("m_id"); // 세션에 저장된 m_id 기준 조회
		return m_id==null? null: m_id;
	}
}
