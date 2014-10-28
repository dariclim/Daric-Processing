// CONWAY'S GAME OF LIFE
// http://en.wikipedia.org/wiki/Conway's_Game_of_Life
//
// this processing sketch implements John Conway's Game of Life simulation
// as an image-processing system... it looks at pixels in a processing PImage
// and treats them as cells in a version of Conway's simulation.
//
// your tasks:
// (1) make this thing look more interesting... 
// hint: you don't have to display the image directly to the screen.
// another hint: the double for() loop can be used to draw other things (shapes, text, etc.)
// as a proxy for the pixels in the simulation.
// (2) the RULES in the draw() loop determine how the simulation decides to keep a pixel
// alive or generate a new one from a dead pixel.  this rule set is sometimes referred to as
// B3/S23 (a pixel is "Born" with 3 neighbors and "Stays Alive" with 2 or 3 neighbors.
// tweak these rules and see if you can find other interesting (or self-sustaining) systems.
//

//PImage img;
//img = loadImage
PImage c[] = new PImage[2]; // input image

int w, h; // width and height

int i, j; // counter variables

int center; // is the pixel alive or dead?
int sum; // how many neighbors are alive?

int which = 0; // which image are we working on

// 9 pixels for the neighborhood (p4 is center):
//  p0  p1  p2
//  p3 *p4* p5
//  p6  p7  p8
color p0, p1, p2, p3, p4, p5, p6, p7, p8; 

void setup()
{
  
  size(800, 800); // make the screen square
  noSmooth(); // turn off image and shape interpolation
  
  
  c[0] = createImage(500, 500, RGB);
  c[1] = createImage(500, 500, RGB);
  w = c[1].height; // width
  h = c[1].width; 
  

    // fill our first image with random stuff:
  fillRandom();
}

void draw()
{
  c[which].loadPixels(); 


  if (mousePressed)
  {
    int mx = constrain(int(mouseX/8.0), 0, width-1);
    int my = constrain(int(mouseY/8.0), 0, height-1);
    c[which].pixels[my*w + mx] = color(200, 255, 100);
  }

  
  for (i=0; i<h; i++) 
  {
    for (j=0; j<w; j++) 
    {

      // top row
      p0 = c[which].pixels[((i-15+h)%h)*w + (j-1+w)%w]; // left pixel
      p1 = c[which].pixels[((i-15+h)%h)*w + j]; // center pixel
      p2 = c[which].pixels[((i-15+h)%h)*w + (j+1+w)%w]; // left pixel

      // center row
      p3 = c[which].pixels[i*w + (j-1+w)%w]; // left pixel
      p4 = c[which].pixels[i*w + j]; // center pixel
      p5 = c[which].pixels[i*w + (j+1+w)%w]; // left pixel

      // bottom row
      p6 = c[which].pixels[((i+100+h)%h)*w + (j-10+w)%w]; // left pixel
      p7 = c[which].pixels[((i+10+h)%h)*w + j]; // center pixel
      p8 = c[which].pixels[((i+1+h)%h)*w + (j+1+w)%w]; // left pixel

      // compute the sum: use the green channel for simplicity
      sum = 0; // start blank
      sum+= int(green(p2)>128.) + int(green(p1)>128.) + int(green(p8)>128.); // top neighbors
      sum+= int(red(p3)>128.) + int(red(p6)>128.); // left and right neighbors
      sum+= int(green(p5)>128.) + int(red(p7)>128.) + int(green(p0)>128.); // bottom neighbors

      center = int(red(p4)>128.); 
      
      //
      // RULES: PLAY WITH THESE
      //
      if (center==1 && (sum==2 || sum==3)) 
      {
        c[1-which].pixels[i*w + j] = color(200, 255, 100);
      } else if (center==0 && sum==3) 
      {
        c[1-which].pixels[i*w + j] = color(200, 255, 200);
      } else // die (or stay dead)
      {   
        c[1-which].pixels[i*w + j] = color(0, 0, 0);
      }
    }
  }

  c[1-which].updatePixels();

  image(c[1-which], 0, 0, width, height); 

  which = 1-which;
  
}

void keyPressed()
{
  fillRandom(); 
}

void fillRandom()
{
  
  c[which].loadPixels();
  for (i=10; i<c[which].pixels.length; i++)
  {
    float rand = random(900);
    if (rand>750) // 10% alive
    {
      c[which].pixels[i] = color(169, 202, 202);
    }
  }
  c[which].updatePixels();
}

void keyReleased() 
{
   if(key==' ') background(255, 0 ,0);
}

