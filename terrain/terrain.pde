import processing.sound.*;

SoundFile sample;
FFT fft;
Amplitude amp;
AudioIn in;

int cols,rows;
int scl = 20;                                //scaling parameter (pixel between triangle vertex)
int bands = 64;
int w = bands*scl;                             //every band becomes a vertex 
int h = 9000;
int scale = 5000;

//float flying = 0;                           //used in the perlin terrain to create the moving terrain effect
float[][] terrain; 
float smoothingFactor = 0.3;                  //change here for different amplitude scaling
float[][] sum;
float barWidth;
float[] spectrum = new float[bands];





public void setup() {
  //size(1200,600,P3D);
  fullScreen(P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];                      //(x,y) mesh where the triangles are drawn
  sum = new float[cols][rows];                          //used in the fft example script, no idea why 
  barWidth = width/float(bands);
  fft= new FFT(this, bands);
  amp = new Amplitude(this);
  
  ////////////AUDIO INPUT 

  //++using an audio file++
  //use lossless files like .wav (decoding .mp3 makes the program go slow)                   
  sample = new SoundFile (this, "your-file.wav");  
  sample.loop();                                                      
  fft.input(sample);
  amp.input(sample);
  
  
  //++microphone++
  //uncomment the block below to use audio input from microphone
  /*in = new AudioIn(this, 0);
  fft.input(in);
  amp.input(in);*/
  
  frameRate(45);                                                      //in fps;    
}
  

public void draw() {
  // The perlin noise terrain is commented inside this loop 
  //flying -= 0.1;
  //float yoff = flying;
  for (int y = 0; y < rows; y++) {
    //float xoff = 0;
    fft.analyze();
    for (int x = 0; x < cols;  x++) {
      sum[x][y] = (fft.spectrum[x] - sum[x][y]) * smoothingFactor;
      //terrain[x][y] = map(noise(xoff,yoff), 0, 1, -100,100);       
      //xoff += 0.1;
    }
    
    //yoff += 0.1;
  }
 //translate(width/4,height/2,-100);
  
  background(0);
  stroke(40,254,20);
  noFill();
  

  translate(width/4+(width/2)*amp.analyze(),height*(1-amp.analyze()*0.05)/2);             //amp goes between 0 and 1, creates distorsion illusion                          
  rotateX(amp.analyze()*PI/4); 
  rotateX(PI/5+PI*(1.05-amp.analyze())/4);                                                 
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols;  x++) {
      vertex(x*scl,y*scl,sum[x][y]*scale);
      vertex(x*scl,(y+1)*scl,sum[x][y+1]*scale);
    }
    endShape();
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols;  x++) {
      vertex(-x*scl,y*scl,sum[x][y]*scale);
      vertex(-x*scl,(y+1)*scl,sum[x][y+1]*scale);
    }
    endShape();
    //translate(0,-400);                  //looks cool
  }
  
}
  
