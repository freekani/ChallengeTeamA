public class OSC {
  private OscP5 oscP5;
  private NetAddress sonicPi;
  public OSC(OscP5 oscP5, NetAddress sonicPi) {
    this.oscP5=oscP5;
    this.sonicPi=sonicPi;
  }
  public void sendMessage(String... s) {
    OscMessage msg = new OscMessage(s[0]);
    for (String str : s) {
      if (!str.equals(s[0])) {
        msg.add(str);
      }
    }
    this.oscP5.send(msg, sonicPi);
    writeMsg("/osc/"+s[0]+" "+s[1]);
  }
  public void sendMessage(String s, float i) {
    OscMessage msg = new OscMessage(s);
    msg.add(i);
    this.oscP5.send(msg, sonicPi);
    writeMsg("/osc/"+s+" "+i);
  }
  public String getAddressPort(){
    return String.format("IP: %-16s PORT: %s",sonicPi.address(),sonicPi.port());
  }
}
