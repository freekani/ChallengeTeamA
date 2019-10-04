
public class LEAP {
  private LeapMotion leap;
  private String msg="";                                    //送信メッセージ
  private PVector old_position=new PVector(0, 300, 0);
  private boolean change=false;
  private boolean gesture=false;

  private int t=0;


  private boolean gesture_left=false;
  private boolean gesture_right=false;
  private boolean gesture_up=false;
  private boolean gesture_down=false;
  private float movePos=0;

  private float mFrame;
  private PVector leftPosition;
  private PVector rightPosition;

  private float zoom=1;
  private float smallestV=1.45;
  private float deltaV=100;



  public LEAP(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  public void update() {
    //  this.t++;
    HandDraw();
    if (this.gesture) {
      this.t++;
      check();
    } else if(!this.gesture&&gui.getController("bar").getValue()==1){
      for (Hand hand : this.leap.getHands()) {

        this.mFrame=hand.getTimeVisible();
        //      println("Frame="+this.mFrame);
      }
      if (this.leap.getHands().size()>0) {
        if (this.leap.getHands().size()==2) {
          zoom=CalcuateDistance(this.mFrame);
        }
        if (this.leap.getHands().size()==1) {
          LRUDGestures(this.mFrame, movePos);
        }
      }
    }
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }
  }

  private float CalcuateDistance(float mFrame) {
 //   gesture_zoom=true;
    gesture_left=false;
    gesture_right=false;

    float distance=0;
    for (Hand hand : this.leap.getHands()) {
      if (hand.isLeft()) {
        leftPosition=hand.getPosition();
      }
      if (hand.isRight()) {
        rightPosition=hand.getPosition();
      }
    }
    if (!leftPosition.equals(new PVector(0, 0))&&!rightPosition.equals(new PVector(0, 0))) {
      PVector leftPos= new PVector(leftPosition.x, leftPosition.y);
      PVector rightPos= new PVector(rightPosition.x, rightPosition.y);
      distance=10*PVector.dist(leftPos, rightPos);
      //println("distance" + distance);
    }
    if (distance!=0) {
      return distance;
    }

    return distance=1;
  }
  void LRUDGestures(float mFrame, float movePos) {
    for (Hand hand : this.leap.getHands()) {
      if (hand.getGrabStrength()==1) {
        println("waiting...");
        this.old_position= hand.getPosition();

     //   this.gesture_zoom=false;
        this.gesture_left=false;
        this.gesture_right=false;
        this.gesture_up=false;
        this.gesture_down=false;
      } else if (hand.getGrabStrength()==0) {
        //println("open");
        PVector v=getV(hand);
        movePos=hand.getPosition().x;
        /*
        //←↓quickly
         if (isMoveQuickLeft(hand, v)&&isMoveDown(hand, v)) {
         if (!this.gesture_left&&!this.gesture_down) {
         this.gesture_left=true;
         this.gesture_right=false;
         this.gesture_up=false;
         this.gesture_down=true;
         println("←↓quickly");
         }
         } 
         //←↑quickly
         else if (isMoveQuickLeft(hand, v)&&isMoveUp(hand, v)) {
         if (!this.gesture_left&&!this.gesture_up) {
         this.gesture_left=true;
         this.gesture_right=true;
         this.gesture_up=true;
         this.gesture_down=false;
         println("←↑quickly");
         }
         } 
         //→↓quickly
         else if (isMoveQuickRight(hand, v)&&isMoveDown(hand, v)) {
         if (!this.gesture_right&&!this.gesture_down) {
         this.gesture_left=false;
         this.gesture_right=true;
         this.gesture_up=false;
         this.gesture_down=true;
         println("→↓quickly");
         }
         } 
         //→↑quickly
         else if ((isMoveQuickRight(hand, v)&&isMoveUp(hand, v))) {
         if (!this.gesture_right&&!this.gesture_up) {
         this.gesture_left=false;
         this.gesture_right=true;
         this.gesture_up=true;
         this.gesture_down=false;
         println("→↑quickly");
         }
         } 
         */
         if(isBack(hand, v)){
        //   println("123");
           this.gesture_left=false;
            this.gesture_right=false;
            this.gesture_up=false;
            this.gesture_down=false;
         }
         //←↓
         else if (isMoveLeft(hand, v)&&isMoveDown(hand, v)) {
          if (!this.gesture_left&&!this.gesture_down) {
            this.gesture_left=true;
            this.gesture_right=false;
            this.gesture_up=false;
            this.gesture_down=true;
            println("←↓");
          }
        }
        //←↑
        else if (isMoveLeft(hand, v)&&isMoveUp(hand, v)) {
          if (!this.gesture_left&&!this.gesture_up) {
            this.gesture_left=true;
            this.gesture_right=false;
            this.gesture_up=true;
            this.gesture_down=false;
            println("←↑");
          }
        }
        //→↓
        else if (isMoveRight(hand, v)&&isMoveDown(hand, v)) {
          if (!this.gesture_right&&!this.gesture_down) {
            this.gesture_left=false;
            this.gesture_right=true;
            this.gesture_up=false;
            this.gesture_down=true;
            println("→↓");
          }
        }
        //→↑
        else if (isMoveRight(hand, v)&&isMoveUp(hand, v)) {
          if (!this.gesture_right&&!this.gesture_up) {
            this.gesture_left=false;
            this.gesture_right=true;
            this.gesture_up=true;
            this.gesture_down=false;
            println("→↑");
          }
        } 
        //←quickly
        else if (!this.gesture_left&&isMoveQuickLeft(hand, v)) {
          println("←quickly");
          this.gesture_left=true;
          this.gesture_right=false;
          this.gesture_up=false;
          this.gesture_down=false;
          osc.sendMessage("MUSICNUM", -1);
        } 
        //→quickly
        else if (!this.gesture_right&&isMoveQuickRight(hand, v)) {
          println("→quickly");
          this.gesture_left=false;
          this.gesture_right=true;
          this.gesture_up=false;
          this.gesture_down=false;
          osc.sendMessage("MUSICNUM", 1);
        } 
        //←
        else if (!this.gesture_left&&isMoveLeft(hand, v)) {
          println("←");
          this.gesture_left=true;
          this.gesture_right=false;
          this.gesture_up=false;
          this.gesture_down=false;
          osc.sendMessage("TIME", -0.25);
        } 
        //→
        else if (!this.gesture_right&&isMoveRight(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=true;
          this.gesture_up=false;
          this.gesture_down=false;
          osc.sendMessage("Time", 0.25);
          println("→");
        }
        //↑
        else if (!this.gesture_up&&isMoveUp(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=false;
          this.gesture_up=true;
          this.gesture_down=false;
          osc.sendMessage("VOLUME", 1);
          println("↑");
        }
        //↓
        else if (!this.gesture_down&&isMoveDown(hand, v)) {
          this.gesture_left=false;
          this.gesture_right=false;
          this.gesture_up=false;
          this.gesture_down=true;
          osc.sendMessage("VOLUME", -1);
          println("↓");
        }
      }
    }
  }

  //get hand v
  private PVector getV(Hand hand) {
    PVector position=hand.getPosition();
    PVector v   = new PVector(position.x-old_position.x, position.y-old_position.y, position.z-old_position.z);
    return v;
  }
  //hand move 4 direction
  private boolean isMoveRight(Hand hand, PVector v) {
    return v.x>deltaV&&!isNoMove(hand, v);
  }
  private boolean isMoveLeft(Hand hand, PVector v) {
    return v.x<-deltaV&&!isNoMove(hand, v);
  }
  private boolean isMoveDown(Hand hand, PVector v) {
    return v.y>0.5*deltaV&&!isNoMove(hand, v);
  }
  private boolean isMoveUp(Hand hand, PVector v) {
    return v.y<-0.5*deltaV&&!isNoMove(hand, v);
  }
  private boolean isMoveQuickRight(Hand hand, PVector v) {
    return v.x>1.5*deltaV&&!isNoMove(hand, v);
  }
  private boolean isMoveQuickLeft(Hand hand, PVector v) {
    return v.x<-1.5*deltaV&&!isNoMove(hand, v);
  }
  private boolean isBack(Hand hand, PVector v) {
    return v.x<0.5*deltaV&&v.x>-0.5*deltaV&&v.y<0.25*deltaV&&v.y>-0.25*deltaV;
  }
  

  //no move
  private boolean isNoMove(Hand hand, PVector v) {
 //     println("nomove");
    return v.x<smallestV&&v.y<smallestV&&v.z<smallestV;
  }

  //ジャスチャーの検出
  void check() {

    for (Hand hand : this.leap.getHands ()) {
      //ジャスチャーの検出
      if (this.t/60==1) {
        this.t=0;

        String finger="";
        String s="";
        int n=0;

        for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        switch(finger) {
        case "00000":
          msg="0\nrock";
          s="MUSICNUM";
          n=-1;

          break;
        case "01000":
          s="MUSICNUM";
          n=1;
          msg="1";
          break;

        case "01100":
          s="VOLUME";
          n=-1;
          msg="2\nscissors";
          break;

        case "00111":
          s="VOLUME";
          n=1;
          msg="3";
          break;

        case "01111":
          s="SCALE";
          n=-1;

          msg="4";
          break;

        case "11111":
          s="SCALE";
          n=1;

          msg="5\npaper";
          break;

        case "10001":
          s="TIME";
          n=-1;


          msg="6";
          break;

        case "11000":
          s="TIME";
          n=1;
          msg="7";
          break;

        default:
          msg="?";
          return;
        }
        //writeMsg(msg);
        osc.sendMessage(s, n);
      }
    }
  }
  private void HandDraw() {
    for (Hand hand : this.leap.getHands ()) {
      for (Finger finger : hand.getFingers()) {
        strokeWeight(10);
        finger.drawBones();
        finger.drawJoints();
      }
    }
  }
  public boolean CheckSlide() {
    if (this.leap.getHands().size()!=2)return false;
    String finger="";
    for (Hand hand : this.leap.getHands ()) {
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
    }
    //  println(finger, finger.substring(0, 5));
    return finger.substring(0, 5).equals("00000");
  }
  public boolean CheckStop() {
    if (this.leap.getHands().size()!=2)return false;
    String finger="";
    for (Hand hand : this.leap.getHands ()) {
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
    }
    return finger.equals("0000000000");
  }
  public boolean CheckStart() {
    if (this.leap.getHands().size()!=2)return false;
    String finger="";
    for (Hand hand : this.leap.getHands ()) {
      for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
    }
    return finger.equals("1111111111");
  }
  public  boolean isExist() {
    return this.leap.getHands().size()>0;
  }
  public boolean isRight() {
    for (Hand hand : this.leap.getHands ()) {
      return hand.isRight();
    }
    return false;
  }
  public PVector getPos() {
    for (Hand hand : this.leap.getHands ()) {
      return hand.isRight()?hand.getPosition():new PVector(width/2, height/2);
      // return hand.getPosition();
    }
    return null;
  }

  public boolean getClick() {
    for (Hand hand : this.leap.getHands ()) {
      if (hand.isRight()) {
        String finger="";
        for (Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        return finger.equals("00000");
      }
    }
    return false;
  }
  public boolean CheckChange() {
    return !change&&getClick();
  }
  public boolean getChange() {
    return this.change;
  }
  public void setChange(boolean change) {
    this.change=change;
  }
  public void setGesture(boolean gesture) {
    this.gesture=gesture;
  }
}

public  void leapOnInit() {
  println("Leap Motion Init");
}
public  void leapOnConnect() {
  println("Leap Motion Connect");
}
public  void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
public  void leapOnExit() {
  println("Leap Motion Exit");
}
