import controlP5.*;

import netP5.*;
import oscP5.*;
ControlP5 cp5;
OscP5 oscP5;
NetAddress sonicPi;

Textarea messageBox;
Println console;
void setup() {
  size(400, 200);
  cp5=new ControlP5(this);
  oscP5=new OscP5(this, 8000);
  sonicPi=new NetAddress("127.0.0.1", 4559);
 
  Init_GUI();
   println(String.format("IP: %-16s PORT: %s",sonicPi.address(),sonicPi.port()));
}
void draw() {
  background(0, 160);
}
void Init_GUI() {
  //MessageBox
  messageBox=cp5.addTextarea("Message")
    .setPosition(25, 25)
    .setSize(350, 130)
    .setFont( createFont("consolas", 16))
    .setLineHeight(20)
    .setColor(color(128))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100));
  ;
  console=cp5.addConsole(messageBox);
  //InputBox
  cp5.addTextfield("input")
    .setPosition(25, 150)
    .setSize(350, 20)
    .setLabel("")
    .setFont(createFont("consolas", 16))
    .setFocus(true)
    .setColor(color(255))
    ;
}
//
void input(String msg) {
  if (isNum(msg)) {
    int BPM=Integer.parseInt(msg);
    if (BPM<=0||BPM>300) {
      println("0<BPM<=300");
    }else{
      sendMessage("BPM",BPM);
    }
  } else {
    println("Please key in numbers");
  }
}

boolean isNum(String s) {
  try {
    Integer.parseInt(s);
    return true;
  } 
  catch (NumberFormatException e) {
    return false;
  }
}
//送信
void sendMessage(String s, float i) {
  OscMessage msg = new OscMessage(s);
  msg.add(i);
  this.oscP5.send(msg, sonicPi);
  writeMsg("/osc/"+s+" "+i);
}
//メッセージの表示
void writeMsg(String s) {
  //year/month/day hour:minute:second
  String time=String.format("%d/%02d/%02d %02d:%02d:%02d\t", year(), month(), day(), hour(), minute(), second());
  println(time+s);
}
