import processing.sound.*;

SoundFile sample;
FFT fft;

int cols,rows;
int scl = 20;
int bands = 128;
int w = bands*scl;  
int h = 9000;
int scale = 5;

float flying = 0;
float[][] terrain; 
float smoothingFactor = 0.1;
float[][] sum;
float barWidth;
float[] spectrum = new float[bands];





public void setup() {
  size(1200,600,P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  sum = new float[cols][rows];
  barWidth = width/float(bands);
  sample = new SoundFile (this, "SCAM_Host.mp3");                    //use looseless files (decoding .mp3 makes the program go slowly)
  sample.loop();                                                     //TODO configure for audio input in RaspberryPi
  
  fft= new FFT(this, bands);
  fft.input(sample);
  
}
  

public void draw() {
  //flying -= 0.1;
  //float yoff = flying;
  for (int y = 0; y < rows; y++) {
    //float xoff = 0;
    fft.analyze();
    for (int x = 0; x < cols;  x++) {
      sum[x][y] = (fft.spectrum[x] - sum[x][y]) * smoothingFactor;
      //terrain[x][y] = map(noise(xoff,yoff), 0, 1, -100,100);       //perlin noise  IDEA: perlin noise 'modulated' by the audio signal? the perlin noise flying mesh looks cool
      //xoff += 0.1;
    }
    
    //yoff += 0.1;
  }
  
  background(0);
  stroke(40,254,20);
  noFill();
  
  translate(width/2,height/2);                                        //centers the plane
  rotateX(1.5*PI/3);                                                  //rotates the plane
  //frameRate(1);
  translate(-w/2+10,-h/2);                                            //TODO would be nice to center the low frequencies because there is more 'activity' there 
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols;  x++) {
      vertex(x*scl,y*scl,sum[x][y]*10000);
      vertex(x*scl,(y+1)*scl,sum[x][y+1]*10000);
    }
    endShape();
  }
  
}
  
