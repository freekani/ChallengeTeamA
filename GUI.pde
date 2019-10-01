public class GUI {
  private ControlP5 cp5;
  private Toggle PLAY;
  private Textarea messageBox;
  private Println console;
  private Chart chart;
  public GUI(ControlP5 cp5) {
    this.cp5=cp5;
    this.ini();
  }
  private void ini() {
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
    this.console=this.cp5.addConsole(messageBox);

this.cp5.addTextarea("IPPORT")
      .setPosition(50,height-24*1.5)
      .setSize(width,24)
      .setFont(fontMsg)
      .setLineHeight(20)
      .setText(osc.getAddressPort())
      ;
    String[] cp5MSG={"MUSICNUM", "VOLUME", "SCALE", "TIME"};
    int btnSize=100;

    //MUSICNUM,VOLUME,SCALE,TIME Buton
    for (int y=0; y<cp5MSG.length; y++) {
      PVector pos=new PVector(100+btnSize*3*(y%2), 100+btnSize*(y/2));
      this.cp5.addTextlabel(cp5MSG[y])
        .setText(cp5MSG[y])
        .setPosition(pos.x+btnSize*1.5/2, pos.y-25)
        .setColorValue(255)
        .setFont(fontMsg)
        ;
      for (int x=0; x<2; x++) {
        pos=new PVector(100+btnSize*3*(y%2), 100+btnSize*(y/2));
        this.cp5.addBang(cp5MSG[y]+(x==0?"-":"+"))
          .setLabel(x==0?"←":"→")
          .setPosition(pos.x+btnSize*x*1.25, pos.y)
          .setSize(btnSize, btnSize/2)
          .setFont(font)
          .align(CENTER, CENTER, CENTER, CENTER);
      }
    }
    //PlayButon
    this.PLAY=this.cp5.addToggle("PLAY")
      .setPosition(width-250+25, 100)
      .setLabel("PLAY")
      .setSize(100, 100)
      .setFont(font)
      .align(CENTER, CENTER, CENTER, CENTER);
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
      .setSize(width, 30)

      .addItems(split("SHOW HIDE GESTURE", " "))
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
  public void update() {
    pointer();
    if (this.PLAY.getValue()==1)chart.push("incoming", (sin(frameCount*0.1)*5));
    else chart.push("incoming", random(-0.1, 0.1));
  }
  void pointer() {
    if (!lp.isExist())return;
    PVector pos=lp.getPos();
    this.cp5.getPointer().set((int)pos.x, (int)pos.y);
    // background(0, 50, 0);

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
  public Println getConsole() {
    return this.console;
  }
  public Controller getController(String name) {
    return  this.cp5.getController(name);
  }
  public void show() {
    this.cp5.getController("PLAY").show();
    this.cp5.getController("RESET").show();
    String[] msg={"MUSICNUM", "VOLUME", "SCALE", "TIME"};

    for (int y=0; y<msg.length; y++) {
      this.cp5.getController(msg[y]).show();
      for (int x=0; x<2; x++) {
        this.cp5.getController(msg[y]+(x==0?"-":"+")).show();
      }
    }
    writeMsg("SHOW");
  }
  public void hide() {
    this.cp5.getController("PLAY").hide();
    this.cp5.getController("RESET").hide();
    String[] msg={"MUSICNUM", "VOLUME", "SCALE", "TIME"};

    for (int y=0; y<msg.length; y++) {
      this.cp5.getController(msg[y]).hide();
      for (int x=0; x<2; x++) {
        this.cp5.getController(msg[y]+(x==0?"-":"+")).hide();
      }
    }
    writeMsg("HIDE");
  }
  public boolean getFlag() {
    return gui.getController("PLAY").getValue()==1;
  }
}
public void CLEAR() {
  gui.getConsole().clear();
}
public void PLAY(boolean state) {
  osc.sendMessage("FLAG", state?"START":"STOP");
}
public void RESET() {
  gui.getController("PLAY").setValue(0);
  osc.sendMessage("FLAG", "RESET");
}

public void controlEvent(ControlEvent theEvent) {
  String[] cp5MSG={"MUSICNUM", "VOLUME", "SCALE", "TIME"};
  if (theEvent.isAssignableFrom(Bang.class)) {
    for (int i=0; i<cp5MSG.length; i++) {
      String m=theEvent.getName();
      float n=0;
      if (cp5MSG[i].equals(m.substring(0, m.length()-1))) {
        n=("-".equals(m.substring(m.length()-1)))?-1:1;
        n=("TIME".equals(cp5MSG[i]))?n/4:n;
        osc.sendMessage(cp5MSG[i].toString(), n);
      }
    }
  }
}

public void bar(int n) {
  switch(n) {
  case 0:
    gui.show();
    break;
  case 1:
    gui.hide();
    break;
  case 2:
    lp.setGesture(true);
  default:
    break;
  }
}