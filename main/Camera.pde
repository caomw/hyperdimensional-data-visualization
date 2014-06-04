class Camera {
  Camera() {
    transX = width / 2.;
    transY = height / 2.;
  }

  void prepareCanvas() {
    background(0);
    lights();
    translate(transX, transY, -100);
    rotateX(rotX);
    rotateY(rotY);
  }

  void rotate(double x, double y) {
    rotX += x;
    rotY += y;
  }

  void pan(double x, double y) {
    transX += x;
    transY += y;
  }
}

