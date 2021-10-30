import processing.net.*;

int[][] grid;
Server myServer;
String incoming;
String outgoing;
String valid = "abcdefghijklmnopqrstuvwxyz1234567890 !@#$%&/()=?¿¡";
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
    x = loadImage("circle.png");
    o = loadImage("cross.png");
}

void draw() {
  background(0);
  stroke(255);
  line (0, 100, 300, 100);
  line (0, 200, 300, 200);
  line (100, 0, 100, 300);
  line (200, 0, 200, 300);
  
  int row = 0;
  int col = 0;
  
  while (row < 3) {
    if (grid[row][col] == 1) image(x, col*100, row*100, 100, 100);
    if (grid[row][col] == 2) image(o, col*100, row*100, 100, 100);
    col++;
    if (col == 3) {
      col = 0;
      row++;
    }
  }
  
  fill(255);
  text(incoming, width/2, height/2);
  text(outgoing, width/2, height/2+100);
  
  Client myClient = myServer.available();
  if (myClient != null) { 
    incoming = myClient.readString();
    // row,col ex: 2,1
    String rowString = incoming.substring(0,1);
    String colString = incoming.substring(2,3);
    int r = int(rowString);
    int c = int(colString);
    grid[r][c] = 2;
  }
}


void mousePressed() {
  int row = mouseY/100;
  int col = mouseX/100;
  grid[row][col] = 1;
  outgoing = row + "," + col;
  myServer.write(outgoing);
}

/*
void keyPressed() {
  if (key == ENTER) {
    myServer.write(outgoing);
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
*/
