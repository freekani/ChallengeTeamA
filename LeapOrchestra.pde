//OSC
import oscP5.*;                   // Please install OscP5 and ControlP5 libraries from
import netP5.*;                   // the menu Sketch / Import Library / Add Library..
OSC osc;

//ControlP5
import controlP5.*;
ControlP5 cp5;
GUI gui;

//LeapMotion
import de.voidplus.leapmotion.*;
LEAP lp;


void setup() {
  size(960, 540);
  //fullScreen();

  //OSC
//  osc=new OSC(new OscP5(this, 8000) , new NetAddress("192.168.0.3", 4559));
  osc=new OSC(new OscP5(this, 8000) , new NetAddress("192.168.0.12", 4559));

  //GUI
  gui=new GUI(new ControlP5(this));
  //LeapMotion
  lp=new LEAP(new LeapMotion(this));
}
void draw() {
  background(0, 50, 0);
  gui.update();
}


void writeMsg(String s) {
  //year/month/day hour:minute:second
  String time=String.format("%d/%02d/%02d %02d:%02d:%02d\t", year(), month(), day(), hour(), minute(), second());
  println(time+s);
}
