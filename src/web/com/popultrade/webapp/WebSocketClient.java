package com.popultrade.webapp;

import java.io.IOException;
import java.io.Serializable;
import java.net.URI;

import javax.websocket.ClientEndpoint;
import javax.websocket.CloseReason;
import javax.websocket.ContainerProvider;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

@ClientEndpoint
public class WebSocketClient implements Serializable  {
	
	
	private static final long serialVersionUID = 1564898565656498465L;
  private String userName;
  private Session session;

  
  
  
  
  
  public WebSocketClient(String urll) {
  

  try {
    WebSocketContainer webSocketContainer = ContainerProvider.getWebSocketContainer();
    webSocketContainer.connectToServer(this, new URI(urll+"prisotnost"));
  }
  catch ( Exception ex) {
    ex.printStackTrace();
  }

  }

  @OnOpen
  public void onOpen(Session session) {
    System.out.println("onOpen() invoked");
    this.session = session;
  }

  @OnClose
  public void onClose(CloseReason closeReason) {
    System.out.println("Connection closed, reason: "+
 closeReason.getReasonPhrase());
  }

  @OnError
  public void onError(Throwable throwable) {
    System.out.println("onError() invoked");
    throwable.printStackTrace();
  }

  @OnMessage
  public void onMessage(String message, Session session) {
    System.out.println("onMessage() invoked");
  }

  public void sendMessage(String message) {
    try {
      System.out.println("sendMessage() invoked, message = " + message);
      session.getBasicRemote().sendText( message);
    }
    catch (IOException ex) {
      ex.printStackTrace();
    }
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }

}
