
// MOONSCAPE 
// A ProcessingJS/Canvas code-generated landscape by Gary Smith (https://www.genartive.com)
// For educational purposes only: please do not redistribute for profit unmodified.

int calcWidth=250; // theoretical canvas width to use for calculations
int calcHeight=250; // theoretical canvas height to use for calculations

// Initialize the canvas and draw the artwork elements
void setup() {

  // clear the background
  background(0,0,0,0);
  fill(0,0,0,0); 

  // there is no animating loop, just a static image
  noLoop(); 

  size(640,640);

  smooth(); // smooth rendering

  textAlign(CENTER,CENTER); // position text to be centered on x,y coords

  strokeJoin(ROUND);

  colorMode(HSB, 360, 100, 100); // set colour mode to HSB (Hue/Saturation/Brightness)

  background(0,0,100); // white  

  int hue1 = random(1,360); // main colour hue
  int hue2 = colorSplitComplementLeft(hue1); // left split complement to main colour hue
  int hue3 = colorSplitComplementRight(hue1); // right split complement to main colour hue

  // draw sky
  drawTexture('O', calcWidth*0.02, calcHeight*0.030, calcWidth*0.963, calcHeight*0.481, hue1, random(3,12), random(40,60), random(85,95), random(75,84));

  // draw water
  fill (360,0,0,0); //white
  rect(0,scalePixelsY(calcHeight*0.504), scalePixelsX(calcWidth), scalePixelsY(calcHeight));
  drawTexture('-', calcWidth*0.02, calcHeight*0.515, calcWidth*0.963, calcHeight*0.466, hue1, random(40,60), random(3,12),  random(75,84), random(85,95));
  drawTexture('-', calcWidth*0.02, calcHeight*0.516, calcWidth*0.963, calcHeight*0.463, hue1, random(40,60), random(3,12),  random(110,125), random(100,110));

  // draw moon
  fill (0,0,100,random(90,120)); //white
  ellipseMode(CENTER);
  var moonTop=random(calcHeight*0.15,calcHeight*0.23);
  var moonLeft=random(calcWidth*0.25, calcWidth*0.75);
  var moonDiameter=random(calcWidth*0.06,calcWidth*0.13);
  ellipse(scalePixelsX(moonLeft), scalePixelsY(moonTop), scalePixelsX(moonDiameter), scalePixelsY(moonDiameter));

  // draw treelines
  var numTreelines=Math.ceil(random(1,4));
  if (numTreelines>=4) {
    drawTreeline(calcWidth*0.015,calcHeight*0.51,calcWidth*0.972,calcHeight*0.24, color(hue1,35,45,25),calcWidth*0.003);
  }
  if (numTreelines>=3) {
    drawTreeline(calcWidth*0.014,calcHeight*0.51,calcWidth*0.972,calcHeight*0.19, color(hue2,35,22,40),calcWidth*0.002);
  }
  if (numTreelines>=2) {
    drawTreeline(calcWidth*0.014,calcHeight*0.51,calcWidth*0.972,calcHeight*0.14, color(hue1,35,22,50),calcWidth*0.002);
  }

  // draw moon reflection
  fill (0,0,100,300); //white  
  ellipse(scalePixelsX(moonLeft), scalePixelsY(calcHeight-moonTop), scalePixelsX(moonDiameter*0.9), scalePixelsY(moonDiameter));
  fill (0,0,100,250); //white  
  ellipse(scalePixelsX(moonLeft), scalePixelsY(calcHeight-moonTop+calcHeight*0.03), scalePixelsX(moonDiameter*1.0), scalePixelsY(moonDiameter));
  fill (0,0,100,200); //white  
  ellipse(scalePixelsX(moonLeft), scalePixelsY(calcHeight-moonTop+calcHeight*0.05), scalePixelsX(moonDiameter*1.1), scalePixelsY(moonDiameter*0.8));

  // draw ripples
  drawRipples('-----', calcWidth*0.03, calcHeight*0.535, calcWidth*0.940, calcHeight*0.441, hue1, random(40,60), random(3,12),  random(35,55), random(50,65));
  drawRipples('----', calcWidth*0.03, calcHeight*0.535, calcWidth*0.940, calcHeight*0.441, hue1, random(40,60), random(3,12),  random(55,65), random(170,275));
  drawRipples('---', calcWidth*0.03, calcHeight*0.535, calcWidth*0.940, calcHeight*0.441, hue1, random(40,60), random(3,12),  random(55,65), random(170,275));
  drawRipples('---', calcWidth*0.032, calcHeight*0.535, calcWidth*0.940, calcHeight*0.441, hue1, random(40,60), random(3,12),  random(55,65), random(240,325));

  // draw tree trunks
  drawTrunks(calcWidth*0.016,calcHeight*0.495, calcWidth*0.982, calcHeight*0.005, hue1);
  drawTrunks(calcWidth*0.016,calcHeight*0.495, calcWidth*0.982, calcHeight*0.004, hue2);
  drawTrunks(calcWidth*0.016,calcHeight*0.495, calcWidth*0.982, calcHeight*0.004, hue1);

  // draw clean white frame across the bottom
  fill (0,0,100,360); //white  
  rect(0, scalePixelsY(calcHeight*0.985), scalePixelsX(calcWidth), scalePixelsY(calcHeight*0.900));

  // add signature
  noStroke();
  fill(0,0,100,215);
  rect(scalePixelsX(calcWidth*0.903), scalePixelsY(calcHeight*0.940), scalePixelsX(calcWidth*0.062), scalePixelsY(calcHeight*0.030));
  PFont fontA = loadFont("Courier New");
  textFont(fontA, scalePixelsX(calcWidth*0.032)); 
  fill(0,0,0,360);
  text("GES",scalePixelsX(calcWidth*0.932), scalePixelsY(calcHeight*0.955));

}

// Draw a textured rectangle composed of overlapping characters
//  char - character(s) to draw
//  xLeft - left x position of rectangle
//  yTop - top y position of rectangle
//  w - width of rectangle
//  h - height of rectangle
//  hue - base hue for color
//  startSat - starting saturation range for color
//  endSat - ending saturation range for color
//  startBri - staring brightness range for color
//  endBri - ending brightness range for color
void drawTexture(string char, float xLeft, float yTop, float w, float h, int hue, int startSat, int endSat, int startBri, int endBri) {
 
  int dw=calcWidth*0.006;
  int dh=calcHeight*0.008;

  float numRows=h/dh;
  float dSat = (endSat-startSat)/numRows;
  float dBri = (startBri-endBri)/numRows;

  textSize(scalePixelsX(calcWidth*0.0225));

  noStroke();
  for (int x=xLeft; x<xLeft+w; x+=dw){
    float sat=startSat;
    float bri=startBri;
    for (int y=yTop; y<yTop+h; y+=dh) {      
      fill(color(hue,sat,bri));
      sat+=dSat;
      bri-=dBri;
      for (int i=0; i<6; i++) {
        text(char,scalePixelsX(x+calcWidth*random(-0.006,0.006)),scalePixelsY(y+calcWidth*random(-0.006,0.006)));
      }
    }
 }

}

// Draw a line of ripples in the water
//  char - character(s) to draw
//  xLeft - left x position of ripple
//  y1 - top y position of ripple
//  w - width of ripple
//  h - height of ripple
//  hue - base hue for color
//  startSat - starting saturation range for color
//  endSat - ending saturation range for color
//  startBri - staring brightness range for color
//  endBri - ending brightness range for color
void drawRipples(string char, float xLeft, float y1, float w, float h, int hue, int startSat, int endSat, int startBri, int endBri) {
 
  int dw;
  int dh;

  float numRows=h/dh;
  float dSat = (endSat-startSat)/numRows;
  float dBri = (startBri-endBri)/numRows;

  var textProp;

  noStroke();
  for (int x=xLeft; x<xLeft+w; x+=dw){
    textProp=0.0035;
    dw=calcWidth*0.020;
    dh=calcHeight*0.022;    
    textSize(scalePixelsX(calcWidth*textProp));    
    float sat=startSat;
    float bri=startBri;
    for (int y=y1; y<y1+h; y+=dh) {      
      textProp+=0.0005;
      dw+=0.003;
      dh+=0.0010;
      textSize(scalePixelsX(calcWidth*textProp));
      fill(color(hue,sat,Math.round(random(30,80))));
      sat+=dSat;
      bri-=dBri;
      for (int i=0; i<6; i++) {
        text(char,scalePixelsX(x+calcWidth*random(-0.016,0.016)),scalePixelsY(y+calcWidth*random(-0.016,0.016)));
      }
    }
 }

}

// Draw a line of trees
//  xLeft - left x position of treeline
//  yBot - bottom y position of treeline
//  w - width of treeline
//  maxcalcHeight - maximum high treeline can reach
//  ORA - color of treeline
//  blobSize - size of characters used to draw treeline elements
void drawTreeline(float xLeft, float yBot, float w, float maxcalcHeight, color col, void blobSize) {
  stroke(col);
  fill(col);
  textSize(scalePixelsX(calcWidth*0.0235));
  float treelinecalcHeight=round(maxcalcHeight*random(0.5,1));
  float treelineDelta=-7;
  for (x=xLeft; x<xLeft+w; x+=blobSize*0.85) {
    for (y=yBot; y>yBot-treelinecalcHeight; y-=blobSize*0.8) {
      yPos=y+calcWidth*random(-0.005,0.005);
      text("^",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(yPos));
      text("=",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(calcHeight-yPos));
    }
    if (random(1,10)>6) {
      treelinecalcHeight+=treelineDelta;
    }
    if (treelinecalcHeight>maxcalcHeight) {
      treelinecalcHeight-=abs(treelineDelta);
      treelineDelta-=random(blobSize*10, blobSize*20);
    }
    if (treelinecalcHeight<(maxcalcHeight/2)) {
      treelinecalcHeight+=abs(treelineDelta);
      treelineDelta+=random(4,8);
    }
    if (random(1,10)>9) {
      treelineDelta+=random(-5,5);
    }
  }
}

// Draw a line of scattered trunks across the center of the treeline, to differentiate land and water
//  xLeft - start x position of the trunk line
//  yTop - start y position of the trunk line
//  w - width of the trunk line
//  h - height of the trunk line
//  hue - hue of trunk line color
void drawTrunks(float xLeft, float yTop, float w, float h, int hue) {
  stroke (hue, 65, 80,80);
  textSize(scalePixelsX(calcWidth*0.0040));
  var weight=calcWidth*0.0014;
  var offsetY=yTop;
  var maxTrunkcalcHeight=calcHeight*0.011;
  for (y=yTop; y<yTop+h; y=y*1.0025) {
    if (offsetY<calcHeight*0.977) {
      for (x=xLeft+calcWidth*random(0, 0.01); x<xLeft+w-10; x+=calcWidth*random(0.01, 0.2)) {
        text("|",scalePixelsX(x), scalePixelsY(y));
        text(".",scalePixelsX(x), scalePixelsY(y+calcHeight*0.03));
      }
      maxTrunkcalcHeight*=1.25;
      offsetY*=1.023;
      weight*=1.04;
    }
  }
}

// Return the left split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementLeft(int hue) {
  hue+=150;
  hue=hue%360;
  return hue;
}

// Return the right split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementRight(int hue) {
  hue+=210;
  hue=hue%360;
  return hue;
}

// Scale a horizontal (x) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  px - The horizontal x position to scale
float scalePixelsX(px) {
  return int(px*(width/calcWidth));
}

// Scale a vertical (y) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  py - The vertical y position to scale
float scalePixelsY(py) {
  return int(py*(height/calcHeight));
}
