Table data;

double cameraX = 0;
double cameraY = 0;
double cameraZ = 0;

int dimension;

Double data1D;
Double[] data2D;
Double[][] data3D;
Double[][][] data4D;
Double[][][][] data5D;
Double[][][][] data6D;
Double[][][][] data7D;

//data1D: x
//data2D: [x]
//data3D: [x][y] - z vals are at data3D[x][y]
//data4D: [w][x][y] - z vals are at data3D[w][x][y]
//data5D: [w][x][y][z/u] - z vals are at data3D[w][x][y][0], u vals are at data3D[w][x][y][1]
//data6D: [w][x][y][z/u/v] - z vals are at data3D[w][x][y][0], u vals are at data3D[w][x][y][1], v vals are at data3D[w][x][y][2]
//data7D: [w][x][y][z/u/v/t] - z vals are at data3D[w][x][y][0], u vals are at data3D[w][x][y][1], v vals are at data3D[w][x][y][2], t vals are at data3D[w][x][y][3]

double maxX; 
double minX; 
double maxY; 
double minY; 
double maxZ; 
double minZ; 
double maxW; 
double minW; 
double maxU; 
double minU; 
double maxV; 
double minV; 

boolean hoverOverButton;

String viewType;

String filePath;

double maxAxisLength;

double currentWValue;

void setup() {
  size(960, 540, P3D); //this code is from the "Move Eye" example
  fill(204); //this code is from the "Move Eye" example
}

void draw() {
  update3DView();
  graph();
  drawUI(); // 2D stuff must be last
}

void drawUI() {
  hint(DISABLE_DEPTH_TEST); // draws as fixed 2D
  noLights(); // otherwise it breaks
  camera(); // center camera on origin
  updateMouse();
  
  stroke(1); // solid border
  if (hoverOverButton) // set in updateMouse()
    fill(200);
  else
    fill(255);
  rect(5, 5, 100, 30);
  
  fill(0);
  stroke(0, 255, 0);
  textSize(20);
  textAlign(CENTER, CENTER); // centered horizontally & vertically
  text("Load CSV", 5, 5, 100, 30);
  
  hint(ENABLE_DEPTH_TEST);
}

void graph3D(){
  if (viewType.equals("point")){
    noStroke(); 
    fill(0, 0, 255); //blue for now, should be changed
    
    double xcor, ycor, zcor;
    
    for (int i = 0; i < data3D.length; i++){
      for (int j = 0; j < data3D[i].length; j++){
        if (data3D[i][j] != null){
          
          xcor = (i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
          ycor = (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
          zcor = (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin));
          
          translate(-xcor, -ycor, -zcor);
          sphere(2);
          translate(xcor, ycor, zcor);
        
        }
      }
    }
  }
  else{
  
    if (viewType.equals("frame")){
      stroke(255); //white for now, should be changed
      noFill();
    }
    else if (viewType.equals("surface")){
      noStroke();
      fill(255, 0, 0); //red for now, should be changed
    }
    else{
      return;
    }
    
    for (int i = 0; i < data3D.length - 1; i++){
      for (int j = 0; j < data3D[i].length - 1; j++){
        startShape(); 
        if (data3D[i][j] != null){
          vertex((i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (data3D[i][j]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
        }
        if (data3D[i+1][j] != null){
          vertex((i+1-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (j-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (data3D[i+1][j]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
        }
        if (data3D[i+1][j+1] != null){
          vertex((i+1-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (j+1-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (data3D[i+1][j+1]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
        }
        if (data3D[i][j+1] != null){
          vertex((i-(minX+maxX)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (j+1-(minY+maxY)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)), 
                 (data3D[i][j+1]-(minZ+maxZ)/2)*(maxAxisLength/max(xMax-xMin, yMax-yMin, zMax-zMin)));
        }
        endShape(CLOSE); 
      }
    }

  }

}

void update3DView(){
  background(0); //this code is from the "Move Eye" example
  
  // Change height of the camera with mouseY 
  camera(30.0, mouseY, 220.0, // eyeX, eyeY, eyeZ //this code is from the "Move Eye" example
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  }
  
void updateMouse() {
  if (mouseOverRect(5, 5, 100, 30))
    hoverOverButton = true;
  else
    hoverOverButton = false;
}

boolean mouseOverRect(int rectX, int rectY, int rectWidth, int rectHeight) {
  return rectX <= mouseX && rectX + rectWidth >= mouseX &&
         rectY <= mouseY && rectY + rectHeight >= mouseY;
}

void mousePressed() {
  if (hoverOverButton)
    loadFile(); 
}

void loadFile() {
  selectInput("Select CSV", "fileSelected");  
}

void fileSelected(File selection) {
  if (selection != null)
    filePath = selection.getAbsolutePath();
    //if (filePath.indexOf("csv") != -1) //bad way to check
    if (filePath.substring(filePath.length()-4).equals(".csv"))//should we even be checking csv extension, what if user imports txt file w. data - maybe we should use a try and except
      loadData();  
}

void loadData() {
  data = loadTable(filePath, "header"); // "header" indicates that there's a header 
  println(data);  
}
