import processing.serial.*;

Serial myPort;
//int potState;
//int buttonState;
int[] inputVars = {0, 0}; //make array to be populated from serial (note number of variables) //for multiple variables
//int inputVars; //for a single variable



void setup () {
  size(200, 200);
  rectMode(CENTER);
  println(Serial.list()); //print serial devices (remember to count from 0)
  myPort = new Serial(this, Serial.list()[3], 9600); //make sure the baudrate matches arduino
  myPort.bufferUntil('\n'); // don't generate a serialEvent() unless you get a newline character
}
void draw () {
  background(0);

  //for multiple variables
  if (inputVars[1] == 1) {
    fill(color(int(random(255)), int(random(255)), int(random(255))));
  } else {
    fill(255);
  }
  ellipse(width, height/2, map(inputVars[0], 0, 1023, 0, width), map(inputVars[0], 330, 1023, 0, width));
  ellipse(width, height, map(inputVars[0], 0, 1023, 0, width), map(inputVars[0], 330, 1023, 0, width));
  ellipse(width/2, height, map(inputVars[0], 0, 1023, 0, width), map(inputVars[0], 330, 1023, 0, width));
  rect(width/2, height/2, map(inputVars[0], 0, 1023, 0, width), map(inputVars[0], 330, 1023, 0, width));
  //for a single variable

  //analog variable
  //fill(255);
  //rect(width/2, height/2, map(inputVars, 0, 1023, 0, width), map(inputVars, 0, 1023, 0, width));

  //digital variable
  //  if (inputVars == 1){
  //   fill(color(int(random(255)),int(random(255)),int(random(255))));
  // }
  //  else{
  //    fill(255);
  //  }
  //  rect(width/2, height/2, width, height);
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n'); //read until new line (Serial.println on Arduino)
  if (inString != null) {
    inString = trim(inString); // trim off whitespace
    inputVars = int(split(inString, '&')); // break string into an array and change strings to ints //for multiple variables
    //inputVars = int(inString); //for a single variable
  }
}
