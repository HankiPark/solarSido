package solar.wsk.msg.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import solar.wsk.msg.service.impl.MessageMapper;

@Component
@Primary
public class SocketHandlerController extends TextWebSocketHandler {

	@Autowired MessageMapper mapper;
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	// 로그인중인 개별유저
		Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
		
		
		// 클라이언트가 서버로 연결시
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			String senderId = getMemberId(session); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
			if(senderId!=null) {	// 로그인 값이 있는 경우만
				log(senderId + " 연결 됨");
				users.put(senderId, session);   // 로그인중 개별유저 저장
				session.sendMessage(new TextMessage("recMs: "+mapper.countMsg(senderId)));
			}
		}
		private String currentUserName(WebSocketSession session) {
			String mid = session.getPrincipal().getName();
			return mid;
		}
		// 클라이언트가 Data 전송 시
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

			// TODO Auto-generated method stub
			String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
			if(msg != null) {
				String[] msgs = msg.split(",");
				if(msgs != null && msgs.length ==2) {
					SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분ss초");
					Date time = new Date();
					String bid = msgs[0];//유저 ID
					String receiver = format2.format(time);//일자
					String count = msgs[1];//제목
					String mid = currentUserName(session);//좋아요 누른 사람
					
					WebSocketSession receiversession = userSessionsMap.get(receiver);//글 작성자가 현재 접속중인가 체크
					
					if(receiversession !=null) {
						TextMessage txtmsg = new TextMessage(mid+"님이 <br/>" + receiver + "에 <br/>"+count+" 했습니다.");
						receiversession.sendMessage(txtmsg);//작성자에게 알려줍니다
					}else {
						TextMessage txtmsg = new TextMessage(mid+"님이 <br/>" + receiver + "에 <br/>" +count+" 했습니다.");
						session.sendMessage(txtmsg);//보내지는지 체크하기
					}
				}
			}
		}
		// 연결 해제될 때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			String senderId = getMemberId(session);
			if(senderId!=null) {	// 로그인 값이 있는 경우만
				log(senderId + " 연결 종료됨");
				users.remove(senderId);
			}
		}
		// 에러 발생시
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			log(session.getId() + " 익셉션 발생: " + exception.getMessage());

		}
		// 로그 메시지
		private void log(String logmsg) {
		}
		// 웹소켓에 id 가져오기
	    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
		private String getMemberId(WebSocketSession session) {
			Map<String, Object> httpSession = session.getAttributes();
			String m_id = (String) httpSession.get("m_id"); // 세션에 저장된 m_id 기준 조회
			return m_id==null? null: m_id;
		}


}
