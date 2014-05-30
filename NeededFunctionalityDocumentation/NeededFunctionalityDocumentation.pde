//============================================================================
//============================================================================
//                WARNING: THIS FILE PRODUCES A VERY UGLY RESULT            //
//     THE PURPOSE OF THIS FILE IS TO DOCUMENT ALL NEEDED FUNCTIONALITY     //
//============================================================================
//============================================================================

//MORE:
//http://www.processing.org/reference/mouseWheel_.html - will use scrolling as the zoom mechanism
//https://www.processing.org/reference/keyPressed_.html - will use shift + mouse movement for pan (standard in CAD)
//                                                                 & w + mouse movement to cycle through 4th variable

float rotx = PI/4;
float roty = PI/4;

boolean circleOver;

void setup() {
  size(640, 360, P3D);
  fill(3);
}

void draw() {
  
  // Change height of the camera with mouseY
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  graph();
 

  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  if ( overCircle(10, 10, 200) ) {
    circleOver = true;
    fill(100, 0, 0);

  } else {
    circleOver = false;
        fill(0, 0, 0);

  }
  ellipse(10, 10, 200, 200);
  hint(ENABLE_DEPTH_TEST);

}

void graph(){
  //lights();
  background(0);
  //box(90);
  textSize(30); 
    fill(0, 0, 255); 
    text("TEXT TEST", 20, 60, -10); 
  
  stroke(255);
fill(127, 40, 20);
beginShape();
vertex(-100, -100, 0);
vertex( 100, -100, 0);
vertex( 100,  100, 0);
vertex(-100,  100, 0);
endShape(CLOSE);


  stroke(255);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
  fill(100, 100, 100);
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex(   0,    0,  100);
  
  vertex( 100, -100, -100);
  vertex( 100,  100, -100);
  vertex(   0,    0,  100);
  
  
    vertex(-100,  100, -100);
  vertex(-100, -100, -100);
  vertex(   0,    0,  100);
  
  vertex( 100, 100, 100);
  vertex(-100, 100, -100);
  vertex(   0,   0,  100);
 
  endShape();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}




boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}


void mousePressed() {
  if (circleOver) {
    whenButtonClicked(); 
  }
}

void whenButtonClicked(){
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}

