package server;

import java.net.Socket;

public class AcceptClient implements Runnable {
    Socket socket;
    
    public AcceptClient(Socket socket) {
        this.socket = socket;
    }
    
    @Override
    public void run() {
    
    }
}
