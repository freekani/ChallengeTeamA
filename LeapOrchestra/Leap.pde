enum Vector {
  LU, UP, RU, 
    LEFT, CENTER, RIGHT, 
    LD, DOWN, RD
}

class Leap {

  LeapMotion leap;
  com.leapmotion.leap.Controller controller = new com.leapmotion.leap.Controller();

  boolean change=false;
  int smallestV=250;
  int biggestV=500;
  int t=0;

  Gesture[][] tempo={{}, {}, 
    //Tempo2
    {new Gesture(new Vector[]{Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Gesture(new Vector[]{Vector.DOWN, Vector.LEFT, Vector.UP})}, 
    //Tempo3
    {new Gesture( new Vector[]  {Vector.DOWN}), 
      new Gesture( new Vector[]  {Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Gesture( new Vector[]  {Vector.DOWN, Vector.LEFT, Vector.UP}), 
    }, 
    //Tempo4
    {new Gesture(new Vector[]{Vector.DOWN}), 
      new Gesture(new Vector[]{Vector.LEFT}), 
      new Gesture(new Vector[]{Vector.DOWN, Vector.RIGHT, Vector.UP}), 
      new Gesture(new Vector[]{ Vector.DOWN, Vector.LEFT, Vector.UP})}
  };
  GestureList gesturelist=new GestureList(tempo[2]);
  Gesture vec=new Gesture();

  //初期化
  Leap(LeapMotion leap) {
    this.leap=leap;
  }

  //処理
  void update() {

    //手の描画
    HandDraw();

    //ジェスチャー認識
    if (gui.getController("bar").getValue()!=0) {
      if (think())move();
    }

    //演奏の開始と終了
    if (gui.getFlag()&&CheckStop()) {
      gui.getController("PLAY").setValue(0);
    } else if (!gui.getFlag()&&CheckStart()) {
      gui.getController("PLAY").setValue(1);
    }
  }

  boolean think() {
    for (com.leapmotion.leap.Hand hand : this.controller.frame().hands()) {
      PVector v=new PVector(hand.palmVelocity().getX(), hand.palmVelocity().getY(), hand.palmVelocity().getZ());
      this.t++;
      // println(t/3*0.1);    //0.1s

      if (isNoMove(v)) {
        this.vec.clear();
        return false;
      }
      //重複要素なしで入れる
      Vector rvector=Vector.CENTER;
      Vector vector=Vector.CENTER;
      if (this.vec.size()!=0) {
        rvector=this.vec.get(this.vec.size()-1);
      }
      if (v.x<-biggestV) {
        vector=Vector.LEFT;
      } else if (v.x>biggestV) {
        vector=Vector.RIGHT;
      } else if (v.y>biggestV/2) {
        vector=Vector.UP;
      } else if (v.y<-biggestV/2) {
        vector=Vector.DOWN;
      }
      if (!rvector.equals(vector)&&!vector.equals(Vector.CENTER)) {
        this.vec.add(vector);
        //println(vec.toString());
      }
      return this.vec.size()>0;
    } 
    return false;
  }
  void move() {
    checkGesture();
  }
  //ジェスチャー認識
  void checkGesture() {
    if (gesturelist.check(this.vec, this.t/3*0.1)) {
      this.t=0;
      this.vec.clear();
    }
  }
  //Tempoの変換
  void changeTempo(int n) {
    this.gesturelist=new GestureList(this.tempo[n]);
  }
  //no move
  boolean isNoMove(PVector v) {
    return abs(v.x)<smallestV&&abs(v.y)<smallestV&&abs(v.z)<smallestV;
  }
  //手の描画
  void HandDraw() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      for (de.voidplus.leapmotion.Finger finger : hand.getFingers()) {
        strokeWeight(10);
        finger.drawBones();
        finger.drawJoints();
      }
    }
  }
  //終了の確認
  boolean CheckStop() {
    if (this.leap.getHands().size()!=2)return false;
    int n=0;
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      n+=(hand.getGrabStrength()==1)?1:0;
    }
    return n==2;
  }
  //開始の確認
  boolean CheckStart() {
    if (this.leap.getHands().size()!=2)return false;
    int n=0;
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      n+=(hand.getGrabStrength()==1)?1:0;
    }
    return n==0;
  }
  //
  boolean isExist() {
    return this.leap.getHands().size()>0;
  }
  //
  boolean isRight() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      return hand.isRight();
    }
    return false;
  }
  //座標の取得
  PVector getPos() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      return hand.isRight()?hand.getPosition():new PVector(width/2, height/2);
    }
    return null;
  }
  //
  boolean getClick() {
    for (de.voidplus.leapmotion.Hand hand : this.leap.getHands ()) {
      if (hand.isRight()) {
        String finger="";
        for (de.voidplus.leapmotion.Finger f : hand.getFingers())finger+=f.isExtended()?1:0;
        return finger.equals("00000");
      }
    }
    return false;
  }
  //
  boolean CheckChange() {
    return !change&&getClick();
  }
  //
  boolean getChange() {
    return this.change;
  }
  //
  void setChange(boolean change) {
    this.change=change;
  }
}

void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnDisconnect() {
  println("Leap Motion Disconnect");
}
void leapOnExit() {
  println("Leap Motion Exit");
}
