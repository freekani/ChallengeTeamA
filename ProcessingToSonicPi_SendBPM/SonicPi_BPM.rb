BPM=120
SLEEPTIME=0.5
#load_BPM
live_loop :load_BPM do
  use_real_time
  msg = sync "/osc/BPM"
  BPM=msg[0]
  SLEEPTIME=60/BPM
  print "load_BPM",BPM
  print "load_SLEEPTIME",SLEEPTIME
end


use_bpm BPM
loop do
  print "BPM = ",BPM
  print "sleep time = ",SLEEPTIME
  use_synth :prophet
  play :C4,release: SLEEPTIME*2
  sleep SLEEPTIME
  play :E4,release: SLEEPTIME*2
  sleep SLEEPTIME
  play :G4,release: SLEEPTIME*2
  sleep SLEEPTIME
  play :B4,release: SLEEPTIME*2
  sleep SLEEPTIME
end