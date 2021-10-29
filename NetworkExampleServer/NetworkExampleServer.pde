import processing.net.*;

int[][] grid;
Server myServer;
String incoming;
String outgoing;
PImage x;
PImage o;

void setup() {
    size(300, 300);
    textAlign(CENTER, CENTER);
    textSize(20);
    
    incoming = "";
    outgoing = "";
    
    myServer = new Server(this, 1234);
    
    grid = new int[3][3];
    x = loadImage("gryffindor.jpg");
}

void draw() {
  background(0);
  stroke(255);
  text(incoming, width/2, height/2);
  text(outgoing, width/2, height/2+100);
  
  Client myClient = myServer.available();
  if (myClient != null) { 
    incoming = myClient.readString();
  }
}

/*
void mousePressed() {
  myServer.write("HELLO!");
}
*/

void keyPressed() {
  if (key == ENTER) {
    myServer.write(outgoing);
    outgoing = "";
  } else {
    outgoing = outgoing + key;
  }
}
