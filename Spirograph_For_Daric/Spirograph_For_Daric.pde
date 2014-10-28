// SPIROGRAPH
// http://en.wikipedia.org/wiki/Spirograph
// also (for inspiration):
// http://ensign.editme.com/t43dances
//
// this processing sketch uses simple OpenGL transformations to create a
// Spirograph-like effect with interlocking circles (called sines).  
// press the spacebar to switch between tracing and
// showing the underlying geometry.
//
// your tasks:
// (1) tweak the code to change the simulation so that it draws something you like.
// hint: you can change the underlying system, the way it gets traced when you hit the space bar,
// or both.  try to change *both*.  :)
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

int NUMSINES = 6; 
float[] sines = new float[NUMSINES]; 
float rad; // an initial radius value for the central sine
int i; // a counter variable

// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 10.; // what multiplier for speed is each additional sine?
int alpha = 150; // how opaque is the tracing system

boolean trace = false; // are we tracing?

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim        minim;
AudioOutput  out;
Oscil        wave;

void setup()
{
  size(800, 600, P3D);
  rad = height/4.; 
  background(70); 

  for (int i = 0; i<sines.length; i++)
  {
    sines[i] = 3*PI * PI + 1;     
  }
  
  minim = new Minim(this);
  
  out = minim.getLineOut();
  
  out.setTempo( 80 );
  
  out.pauseNotes();
  
  out.playNote( 0.0, 1.3, "G3");
  out.playNote( 2.0, 1.3, "G4" );
  out.playNote( 4.0, 1.3, "F#4");
  out.playNote( 5.0, 1.3, "D4");
  out.playNote( 5.5, 1.3, "E4");
  out.playNote( 6.0, 1.3, "F#4");
  out.playNote( 7.0, 1.3, "G4");
  out.playNote( 8.0, 1.3, "G3");
  out.playNote(10.0, 1.3, "E4");
  out.playNote(12.0, 1.3, "D4");
  
  out.resumeNotes();
}

void draw()
{
 
  
  if (!trace) background(255);      
  if (!trace) {
    stroke(0, 255); // black pen
    noFill(); // don't fill
  }  

  // MAIN ACTION
  pushMatrix();     
  translate(width/2, height/2);      

  for (i = 0; i<sines.length; i++)
  {
    float erad = 1; 
    
    if (trace) {
      stroke(0, 179, 255*(float(i)/sines.length), alpha/2);
      fill(0, 200, 255, alpha/2);
      erad = 13.0*(1.0-float(i)/sines.length); 
    }
    float radius = rad/(i+1);
    rotateZ(sines[i]); 
    if (!trace) rect(0, 0, radius*2, radius*2); 
    pushMatrix(); 
    translate(0, radius);
    if (!trace) rect(0, 0, 0, 0);
    if (trace) rect(16, 9, erad, erad);
    popMatrix();
    translate(0, radius);
    sines[i] = (sines[i]+(fund+(fund*i*ratio)))%TWO_PI; 
  }
  popMatrix(); 
  
  }
  

void keyReleased()
{
  if (key==' ') {
    trace = !trace; 
    background(255);
  }
}
