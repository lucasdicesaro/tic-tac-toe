import processing.net.*;

Client myClient;
String incoming;
String outgoing;
String valid = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%&/()=";

void setup() {
    size(300, 300);
    textAlign(CENTER, CENTER);
    textSize(20);
    
    incoming = "";
    outgoing = "";
    
    myClient = new Client(this, "127.0.0.1", 1234);
}

void draw() {
  background(255);
  fill(0);
  text(incoming, width/2, height/2+100);
  text(outgoing, width/2, height/2-100);
  
  if (myClient.available() > 0) {
    incoming = myClient.readString();
  }
}

/*
void mousePressed() {
  myClient.write("HELLO!");
}
*/

void keyPressed() {
  if (key == ENTER) {
    myClient.write(outgoing);
    outgoing = "";
  }
  if (key == BACKSPACE) {
    if (outgoing.length() > 0) {
      outgoing = outgoing.substring(0, outgoing.length()-1);
    }  
  } else if (valid.contains((key+"").toLowerCase())) {
    outgoing = outgoing + key;
  }
}
