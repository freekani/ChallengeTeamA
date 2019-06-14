//import processing.sound.*;

//SinOsc sine1, sine2;

import de.voidplus.leapmotion.*;
color a=color(255, 0, 0);
color b=color(255, 0, 0);
color c=color(255, 0, 0);
color d=color(255, 0, 0);
PVector prePos=new PVector(0, 0, 0);
PVector pos=new PVector(0, 0, 0);
// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================


LeapMotion leap;

void setup() {
  fullScreen();
  //size(800, 500);
  background(255);
  // ...
  /*
  sine1 = new SinOsc(this);
   sine1.freq(500);
   sine2 = new SinOsc(this);
   sine2.freq(600);
   */
  leap = new LeapMotion(this);
}


// ======================================================
// 1. Callbacks

void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
void leapOnExit() {
  println("Leap Motion Exit");
}

void drawRect() {

  rectMode(CENTER);
  strokeWeight(10);
  strokeJoin(BEVEL);

  textSize(128);
  textAlign(CENTER, CENTER);
  strokeWeight(10);
  pushMatrix();
  stroke(a);
  fill(255);

  translate(width/2, height/2-height/3);
  //fill(255);
  rect(0, 0, width/8, width/8);
  fill(a);
  text("1", 0, 0);

  popMatrix();

  pushMatrix();
  stroke(b);
  translate(width/2-width/3, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(b);
  text("3", 0, 0);
  popMatrix();

  pushMatrix();
  stroke(c);
  translate(width/2, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(c);
  text("2", 0, 0);
  popMatrix();

  pushMatrix();
  stroke(d);
  translate(width/2+width/3, height/2+height/4);
  fill(255);
  rect(0, 0, width/8, width/8);
  fill(d);
  text("4", 0, 0);
  popMatrix();

 
  //  text("1", width/2, height/2-height/3);
//
 // text("2", width/2-width/3, height/2+height/4);
 // text("3", width/2, height/2+height/4);
  //text("4", width/2+width/3, height/2+height/4);
}
void draw() {

  background(255);

  // ...

  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands ()) {


    // ==================================================
    // 2. Hand

    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    // --------------------------------------------------
    // Drawing
    drawRect();
    println(handTime%1);
    if (handTime==0) {
      PVector prePos=new PVector(pos.x, pos.y, pos.z);
      PVector pos=new PVector(handPosition.x, handPosition.y, handPosition.z);
    }
    textSize(32);
    hand.draw();
    /* a=(handPosition.y<height/2&&handPosition.y>0&&handPinch==1)?color(0,255,0):color(255,0,0);
     b=(handPosition.x>0&&handPosition.x<width/2&&handPosition.y<height&&handPinch==1)?color(0,255,0):color(255,0,0);
     c=(handPosition.x>width/2&&handPosition.x<width&&handPosition.y<height&&handPinch==1)?color(0,255,0):color(255,0,0);
     */
    /*
      rect(-width/3, height/4, width/6, width/6);
     popMatrix();
     pushMatrix();
     stroke(c);
     translate(width/2, height/2);
     rect(0, height/4, width/6, width/6);
     popMatrix();
     
     pushMatrix();
     stroke(d);
     translate(width/2, height/2);
     rect(width/3, height/4, width/6, width/6);
     */
    a=(handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2-height/3+width/8&&handPosition.y>height/2-height/3-width/8)?color(0, 255, 0):color(255, 0, 0);
    b=(handPosition.x>width/2-width/3-width/8&&handPosition.x<width/2-width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);
    c=(handPosition.x>width/2-width/8&&handPosition.x<width/2+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);
    d=(handPosition.x>width/2+width/3-width/8&&handPosition.x<width/2*width/3+width/8&&handPosition.y<height/2+height/4+width/8&&handPosition.y>height/2+height/4-width/8)?color(0, 255, 0):color(255, 0, 0);

    //      println(handPinch);
    //   if(handPinch==1){println(1111);}


    println(handPosition);
    // ==================================================
    // 3. Arm

    if (hand.hasArm()) {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
      arm.draw();
    }


    // ==================================================
    // 4. Finger
    Finger  fingerThumb        = hand.getThumb();
    // or                        hand.getFinger("thumb");
    // or                        hand.getFinger(0);
    /* if (!fingerThumb.isExtended()) {
     println("Thumb");
     }
     Finger  fingerIndex        = hand.getIndexFinger();
     if (!fingerIndex.isExtended()) {
     println("Index");
     }
     Finger  fingerMiddle       = hand.getMiddleFinger();
     if (!fingerMiddle.isExtended()) {
     println("Middle");
     }
     Finger  fingerRing         = hand.getRingFinger();
     if (!fingerRing.isExtended()) {
     println("Ring");
     }
     Finger  fingerPink         = hand.getPinkyFinger();
     if (!fingerPink.isExtended()) {
     println("Pink");
     }
     */    for (Finger finger : hand.getFingers()) {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();

      // ------------------------------------------------
      // Drawing

      // Drawing:
      //finger.draw();  // Executes drawBones() and drawJoints()
      //finger.drawBones();
      // finger.drawJoints();

      // ------------------------------------------------
      // Selection

      switch(finger.getType()) {
      case 0:
        // System.out.println("thumb");
        break;
      case 1:
        // System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }


      // ================================================
      // 5. Bones
      // --------
      // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + fingerId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + fingerId + ")");
        break;
      }
    }


    // ==================================================
    // 6. Tools

    for (Tool tool : hand.getTools()) {
      int     toolId           = tool.getId();
      PVector toolPosition     = tool.getPosition();
      PVector toolStabilized   = tool.getStabilizedPosition();
      PVector toolVelocity     = tool.getVelocity();
      PVector toolDirection    = tool.getDirection();
      float   toolTime         = tool.getTimeVisible();

      // ------------------------------------------------
      // Drawing:
      tool.draw();

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = tool.getTouchZone();
      float   touchDistance    = tool.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + toolId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + toolId + ")");
        break;
      }
    }
  }


  // ====================================================
  // 7. Devices

  for (Device device : leap.getDevices()) {
    float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
    float deviceVericalViewAngle = device.getVerticalViewAngle();
    float deviceRange = device.getRange();
  }
}
