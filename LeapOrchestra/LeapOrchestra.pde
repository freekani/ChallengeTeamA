//OSC通信
import oscP5.*;                   
import netP5.*;                   
OSC osc;

//GUI
import controlP5.*;
ControlP5 cp5;
GUI gui;

//LeapMotion
import de.voidplus.leapmotion.*;
import com.leapmotion.leap.*;
Leap lp;


void setup() {
  size(960, 540);

  //OSC
  osc=new OSC(new OscP5(this, 8000) , new NetAddress("192.168.0.255", 4559));
  //GUI
  gui=new GUI(new ControlP5(this));
  //LeapMotion
  //  comleap=new ComLeap();
  lp=new Leap(new LeapMotion(this));
}

void draw() {
  background(0, 50, 0);
  gui.update();

  
}
//メッセージの表示
void writeMsg(String s) {
  //year/month/day hour:minute:second
  String time=String.format("%d/%02d/%02d %02d:%02d:%02d\t", year(), month(), day(), hour(), minute(), second());
  println(time+s);
}
