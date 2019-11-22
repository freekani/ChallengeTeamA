import java.util.Arrays;
import java.util.List;
public class Tempo {
  private List<Vector> vector=new ArrayList<Vector>(); 
  private List<Float> speedList=new ArrayList<Float>();
  public Tempo() {

  }
  public Tempo(Float[] speed, Vector... v) {
    this.vector=Arrays.asList(v);
    this.speedList=Arrays.asList(speed);
  }
  public Tempo(Vector... v) {
    this.vector=Arrays.asList(v);
    this.speedList.add(0.0);
  }  
  public void add(Vector v, float speed) {
    this.vector.add(v);
    this.speedList.add(speed);
  }
  public void add(Vector v) {
    this.add(v, 0.0);
  }
  public int size() {
    return this.vector.size();
  }
  public void clear(){
    this.vector.clear();
    this.speedList.clear();
  }
  public int getSpeed() {
    int mean=0;
    if (this.speedList.size()>0) {
      float sum=0;
      for (float s : speedList) {
        sum+=s;
        println(speedList);
      }
     mean=(int)(sum/this.speedList.size());
      //println(sum);
    }
    return mean;
  }
  public Vector getVector(int index) {
    return this.vector.get(index);
  }
  
  public Float getSpeed(int index) {
    return this.speedList.get(index);
  }
  public boolean check(Tempo t) {
    if (t.size()>=this.vector.size()) {
      for (int i=0; i<t.size()-this.vector.size()+1; i++) {
        boolean[] checkTempo=new boolean[this.vector.size()]; 
        boolean check=true;
        for (int j=0; j<this.vector.size(); j++) {
          if (this.vector.get(j).equals(t.getVector(i+j))) {
            checkTempo[j]=true;
          }
        }
        for (boolean b : checkTempo) {
          if (!b)check=false;
        }
        if (check)return true;
      }
    }
    return false;
  } 
  public String toString() {
    String str="";
  //  str+="size = "+this.size()+" speed = "+this.getSpeed()+"\n";
    for (int i=0; i<this.vector.size(); i++) {
      Vector v=(Vector)this.vector.get(i);
      switch(v) {
      case CENTER:
        str+="wait…… ";
        break;
      case LU:
        str+="←↑ ";
        break;
      case UP:
        str+="↑ ";
        break;
      case RU:
        str+="→↑ ";
        break;
      case LEFT:
        str+="← ";
        break;
      case RIGHT:
        str+="→ ";
        break;
      case LD:
        str+="←↓ ";
        break;
      case DOWN:
        str+="↓ ";
        break;
      case RD:
        str+="→↓ ";
        break;
      }
    }
    return str;
  }
    public boolean equals(Tempo tempo) {
    if (this.size()!=tempo.size())return false;
    for (int i=0; i<this.size(); i++) {
      if (!this.getVector(i).equals(tempo.getVector(i)))return false;
    }
    return true;
  }
  public void copy(Tempo tempo){
    List<Vector> v=new ArrayList<Vector>(); 
    for(int i=0;i<tempo.size();i++){
      v.add(tempo.getVector(i));
    }
    this.vector=v;
  }
}
public class TempoList {
  private int num;
  private List<Tempo> list;
  public TempoList(Tempo... tempo) {
    this.num=0;
    this.list=Arrays.asList(tempo);
  }
  public void check(Tempo t) {
    Tempo tempo=this.list.get(this.num);
    if (tempo.check(t)) {
     println(++this.num);
      this.num%=this.list.size();
      
    }
  }
}
