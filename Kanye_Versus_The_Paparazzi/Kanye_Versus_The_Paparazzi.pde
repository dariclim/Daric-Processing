
//This is from class 2
// GLOBAL variables
int Paparazzi = 68;
float[] x1 = new float[Paparazzi];
float[] y1 = new float[Paparazzi]; 
float[] x2 = new float[Paparazzi];
float[] y2 = new float[Paparazzi]; 
float[] rad = new float[Paparazzi];
float[] r = new float[Paparazzi];
float[] g = new float[Paparazzi]; 
float[] b = new float[Paparazzi];


float p1x = 0;
float p1y = -10;
float p2x = -10;
float p2y = 10;
float p3x = 10;
float p3y = 10;

PImage img1;
PImage img2;
PImage img3;
PImage bg;

//I got this from Processing Examples/Simulate/Chain
Spring2D s1, s2;

float gravity = 9.0;
float mass = 2.0;


void setup()
{
  img1 = loadImage("Kanyewest.png");
  
  img2 = loadImage("PaparazziCamera1.png");
  
  img3 = loadImage("redsuit.png");
  
  frameRate(30); 

  size(1000, 833);
  bg = loadImage("redcarpet.jpg");
  background(bg);

//I got this from Processing Examples/Simulate/Chain
  s1 = new Spring2D(0.0, width/2, mass, gravity);
  s2 = new Spring2D(0.0, width/2, mass, gravity);

//This is to Kanye-ize my cursor
  cursor(img1);
  
  
//This is from class 2
  for (int i=0; i<Paparazzi; i++)
  {
    x1[i] = random(0, width-1);
    y1[i] = random(0, height-1);
    rad[i] = random(5, 30);
    r[i] = random(128, width-1);  
    g[i] = random(128, 255);  
    b[i] = random(128, 255);  
  }
}


void draw()
{
  
//I got this from Processing Examples/Simulate/Chain
  background(bg);
  s1.update(mouseX, mouseY);
  s1.display(mouseX, mouseY);
  //s2.update(s1.x, s1.y);
  //s2.display(s1.x, s1.y);
  
  
  noStroke();
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);

//This is from class 2
  float weight = sqrt((mouseX-pmouseX)*(mouseX-pmouseX)+(mouseY-pmouseY)*(mouseY-pmouseY));
  float aa = max(0.01, min(weight/50., 1.0));
  float bb = 1.0-aa;


  for (int i = 0; i<Paparazzi; i++)
  {
  
    float dx = (mouseX-x1[i])/9.;
    float dy = (mouseY-y1[i])/9.;
    float drunkx = myDrunkenCurve(-50, 50, 3);
    float drunky = myDrunkenCurve(-50, 50, 3);
    ;
   
    float shiftx = x1[i]+random(min(0, dx), max(0, dx))+drunkx;
    float shifty = y1[i]+random(min(0, dy), max(0, dy))+drunky;
    x2[i] = aa*shiftx + bb*x1[i];
    y2[i] = aa*shifty + bb*y1[i];


  
    noFill(); 
    stroke(255, 255, 192, 0); 
    line(x1[i], y1[i], x2[i], y2[i]); 


    image(img2, x2[i], y2[i]);

    
   
    x1[i] = x2[i];
    y1[i] = y2[i];



    if (x1[i]>width) x1[i] = 0;
    if (x1[i]<0) x1[i] = width;
    if (y1[i]>height) y1[i] = 0;
    if (y1[i]<0) y1[i] = height;
  }
}


//I got this from Processing Examples/Simulate/Chain
class Spring2D {
  float vx, vy; // The x- and y-axis velocities
  float x, y; // The x- and y-coordinates
  float gravity;
  float mass;
  float radius = 30;
  float stiffness = 0.6;
  float damping = 0.5;
  
  Spring2D(float xpos, float ypos, float m, float g) {
    x = xpos;
    y = ypos;
    mass = m;
    gravity = g;
  }
  
  void update(float targetX, float targetY) {
    float forceX = (targetX - x) * stiffness;
    float ax = forceX / mass;
    vx = damping * (vx + ax);
    x += vx;
    float forceY = (targetY - y) * stiffness;
    forceY += gravity;
    float ay = forceY / mass;
    vy = damping * (vy + ay);
    y += vy;
  }
  
  void display(float nx, float ny) {
    image(img3, x-95, y+60);
    stroke(255);
    line(x, y, nx, ny);
  }
}



void keyPressed()
{
  if (key==' ') background(bg);
}

//This is to Kanye-ize my cursor
float myDrunkenCurve(float min, float max, int Q)
{

  float value = 0.;

  for (int i = 0; i < Q; i++) // i = i + 1
  {
    value+=random(min, max);
  }

  value = value / float(Q);

  return(value);
}

