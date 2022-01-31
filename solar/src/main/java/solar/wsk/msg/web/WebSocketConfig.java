package solar.wsk.msg.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
@ComponentScan("com.Kcompany.Kboard.socket")
public class WebSocketConfig implements WebSocketConfigurer{

	@Autowired SocketHandlerController websocketHandler;
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {

		registry.addHandler(websocketHandler, "/ajax/myHandler").setAllowedOrigins("*").withSockJS();
	}
	

}
