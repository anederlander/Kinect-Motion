import org.openkinect.processing.*; 
import processing.video.*;
import java.nio.*;
import java.util.Iterator;
 
Kinect2 kinect2;
Capture video;
ParticleEmitter particleEmitter;

PImage img;
 
float RANGE_MIN = 1000;
float RANGE_MAX = 2000;
int KINECT_WIDTH= 515;
int KINECT_HEIGHT = 424;
color BACKGROUND = color(0, 0, 0, 100);
 
void setup() {
  size(512,424);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
 
  particleEmitter = new ParticleEmitter(kinect2);
 
  video = new Capture(this, 512, 424);
  video.start();

}
 
void captureEvent(Capture video) {
  video.read();
}
 
void draw(){
  //background(BACKGROUND);
  //pushMatrix();
  image(video, 0, 0);
  //image(kinect2.getVideoImage(), 0, 0, kinect2.colorWidth*0.267, kinect2.colorHeight*0.267);
  filter(POSTERIZE, 4);
  filter(INVERT);
  //popMatrix();

  //image(kinect2.getVideoImage(), 0, 0, kinect2.colorWidth*0.267, kinect2.colorHeight*0.267);
 
  //particleEmitter.display();
  //fill(255);
  //ellipse(10, 10, 1, 1);
  particleEmitter.refresh();
  particleEmitter.emit();
}
 
 
