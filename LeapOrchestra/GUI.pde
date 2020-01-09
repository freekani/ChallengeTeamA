//*
 class GUI {
   ControlP5 cp5;
   Toggle PLAY;
   Textarea messageBox;
   Println console;
   Chart chart;
   GUI(ControlP5 cp5) {
    this.cp5=cp5;
    this.ini();
  }
   void ini() {
    //font
    PFont font = createFont("consolas", 32);
    PFont fontMsg=createFont("consolas", 20);

    this.cp5.setColorBackground(color(0, 102, 0, 160));
    this.cp5.setColorForeground(color(107, 142, 35));
    this.cp5.setColorActive(color(100, 255, 35, 180));

    //MessageBox
    this.messageBox=this.cp5.addTextarea("Message")
      .setPosition(50, height/2+50)
      .setSize(width-50-250, height/2-100)
      .setFont(fontMsg)
      .setLineHeight(20)
      .setColor(color(222))
      .setColorBackground(color(0, 102, 0, 160))
      .setColorForeground(color(255, 100))
      ;
    this.console=this.cp5.addConsole(this.messageBox);

    this.cp5.addTextarea("IPPORT")
      .setPosition(50, height-24*1.5)
      .setSize(width, 24)
      .setFont(fontMsg)
      .setLineHeight(20)
      .setText(osc.getAddressPort())
      ;
   
    //PlayButon
    this.PLAY=this.cp5.addToggle("PLAY")
      .setPosition(width-250+25, 100)
      .setLabel("PLAY")
      .setSize(100, 100)
      .setFont(font)
      .align(CENTER, CENTER, CENTER, CENTER);
     this.cp5.addToggle("BPM")
      .setPosition(width-250+25, 100)
      .setLabel("BPM")
      .setSize(100, 100)
      .setFont(font)
      .align(CENTER, CENTER, CENTER, CENTER)
      .hide();
    //resetButon
    this.cp5.addBang("RESET")
      .setPosition(width-250+25, 225)
      .setSize(100, 25)
      .setFont(fontMsg)
      .align(CENTER, CENTER, CENTER, CENTER);  

    //ClearButon
    this.cp5.addBang("CLEAR")
      .setPosition(width-250, height/2+150)
      .setSize(200, height/2-200)
      .setFont(font)
      .align(CENTER, CENTER, CENTER, CENTER);
    //ButtonBar
    this.cp5.addButtonBar("bar")
      .setPosition(0, 0)
      .setFont(fontMsg)
      .setSize(width, 50)

      .addItems(split("OPTION TEMPO2 TEMPO3 TEMPO4", " "))
      ;

    this.chart = this.cp5.addChart("dataflow")
      .setLabel("")
      .setPosition(width-250, height/2+50)
      .setSize(200, 100)
      .setRange(-20, 20)
      .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(40))
      ;

    this.chart.addDataSet("incoming");
    this.chart.setData("incoming", new float[100]);
  }
   void update() {
    this.console=this.cp5.addConsole(this.messageBox);

    pointer();
    if (this.PLAY.getValue()==1)chart.push("incoming", (sin(frameCount*0.1)*5));
    else chart.push("incoming", random(-0.1, 0.1));
  }
  void pointer() {
    if (!lp.isExist())return;
    PVector pos=lp.getPos();
    this.cp5.getPointer().set((int)pos.x, (int)pos.y);

    pushMatrix();
    translate(this.cp5.getPointer().getX(), this.cp5.getPointer().getY());
    stroke(255);
    strokeWeight(10);
    line(-10, 0, 10, 0);
    line(0, -10, 0, 10);
    popMatrix();
    lp.update();
    if (lp.CheckChange()) {
      this.cp5.getPointer().pressed();
      this.cp5.getPointer().released();
      lp.setChange(true);
    } else if (!lp.getClick()) {
      lp.setChange(false);
    }
  }
   Println getConsole() {
    return this.console;
  }
   controlP5.Controller getController(String name) {
    return  this.cp5.getController(name);
  }
   void show() {
    this.cp5.getController("PLAY").show();
    this.cp5.getController("RESET").show();
    this.cp5.getController("BPM").hide();
    
  
 }
   void hide() {
    this.cp5.getController("PLAY").hide();
    this.cp5.getController("RESET").hide();
    this.cp5.getController("BPM").show();
    
  }
   boolean getFlag() {
    return gui.getController("PLAY").getValue()==1;
  }
}
void BPM(boolean state){
  lp.changeBPM=state;
}
 void CLEAR() {
  gui.getConsole().clear();
}
 void PLAY(boolean state) {
  osc.sendMessage("FLAG", state?"START":"STOP");
}
 void RESET() {
  gui.getController("PLAY").setValue(0);
  osc.sendMessage("FLAG", "RESET");
}


 void bar(int n) {
  switch(n) {
  case 0:
    gui.show();
    writeMsg("OPTION");
    break;
  case 1:
    gui.hide();
    writeMsg("TEMPO2");
    lp.changeTempo(2);
    break;
  case 2:
    gui.hide();
    writeMsg("TEMPO3");
    lp.changeTempo(3);
    break;

  case 3:
    gui.hide();
    writeMsg("TEMPO4");
    lp.changeTempo(4);
    break;

  default:
    break;
  }
}
//*/
