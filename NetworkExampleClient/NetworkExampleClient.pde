import processing.net.*;

int[][] grid;
Client myClient;
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
    
    myClient = new Client(this, "LA64", 1234);
    
    grid = new int[3][3];
    x = loadImage("circle.png");
    o = loadImage("cross.png");
}

void draw() {
  background(255);
  stroke(0);
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

  fill(0);
  text(incoming, width/2, height/2+100);
  text(outgoing, width/2, height/2-100);
  
  if (myClient.available() > 0) {
    incoming = myClient.readString();
  }
}


void mousePressed() {
  int row = mouseY/100;
  int col = mouseX/100;
  grid[row][col] = 1;
  outgoing = row + "," + col;
  myClient.write(outgoing);
}


/*
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
*/
