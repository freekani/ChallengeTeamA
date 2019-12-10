BPM=120
#load_BPM
live_loop :load_BPM do
  use_real_time
  msg = sync "/osc/BPM"
  BPM=msg[0]
  print "load_BPM",BPM
end



loop do
  use_bpm BPM
  print "BPM = ",BPM
  use_synth :prophet
  play :C4 release: 0.5
  sleep 0.5
  play :E4 release: 0.5
  sleep 0.5
  play :G4 release: 0.5
  sleep 0.5
  play :B4 release: 0.5
  sleep 0.5
end