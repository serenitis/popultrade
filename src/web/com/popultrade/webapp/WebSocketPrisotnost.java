package com.popultrade.webapp;

import java.io.IOException;
import java.io.Serializable;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;




@ServerEndpoint("/prisotnost")
public class WebSocketPrisotnost implements Serializable {

	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1564898161556498465L;




	@OnOpen
	  public void onOpen(Session session) {
	    System.out.println("Povezan na socket ");
	  //  session.setMaxIdleTimeout(arg0)
	  //  session.
	  }
	
	
	
	
    @OnMessage
    public void echoTextMessage(Session session, String msg) {
      
           // if (session.isOpen()) {
              //  session.getBasicRemote().sendText(msg, last);
                System.out.println(session.getOpenSessions().size()+ " ::: WEBSOCKET prisotnost SEND MESSAGE "+msg);
                
                if (msg.equals("keepalive")) {
                	System.out.println("WEBSOCKET KEEPALIVE");
                }
                else {
                try {
                	
                	
                	
        			for (Session s : session.getOpenSessions()) {
        				if (s.isOpen()) {
        					
        					System.out.println("SEND WEB SOCKET TO BROWSER");
        					s.getBasicRemote().sendText(msg);
        				}
        			}
        		} catch (Exception e) {
        			System.out.println( "onMessage failed" +  e.toString());
        		}
                }
            
       
    }
	
	
	
}
