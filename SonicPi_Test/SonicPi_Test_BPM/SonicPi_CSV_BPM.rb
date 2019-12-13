require "csv"
csvfile='C:\Users\cccqc\OneDrive\Documents\GitHub\ChallengeTeamA\SonicPi_Test\mario.csv'
note = [ [0,:C1,:D1,:E1,:F1,:G1,:A1,:B1],
         [0,:C2,:D1,:E2,:F2,:G2,:A2,:B2],
         [0,:C3,:D3,:E3,:F3,:G3,:A3,:B3],
         [0,:C ,:D ,:E ,:F ,:G ,:A ,:B ],
         [0,:C5,:D5,:E5,:F5,:G5,:A5,:B5],
         [0,:C6,:D6,:E6,:F6,:G6,:A6,:B6],
         [0,:C7,:D7,:E7,:F7,:G7,:A7,:B7],]
step=[0,1]
octave=[0,1]
duration=[0,1]
BPM=120
#------------------------------------------------------------
#load_CSV
#------------------------------------------------------------
define :load_CSV do
  print "---------------LOAD CSV---------------"
  file = CSV.read(csvfile)
  print file
  step=[]
  octave=[]
  duration=[]
  i=0
  while (i<file.length)
    step[i]=file[i][0].to_i
    octave[i]=file[i][1].to_i
    duration[i]=file[i][2].to_i
    i=i+1
  end
  print "step",step
  print "octave",octave
  print "duration",duration
  print "-------------LOAD SUCCEED-------------"
end
#------------------------------------------------------------
#load_BPM
#------------------------------------------------------------
live_loop :load_BPM do
  use_real_time
  msg = sync "/osc/BPM"
  BPM=msg[0]
  print "LOAD_BPM",BPM
end
#------------------------------------------------------------
#play_MUSIC
#------------------------------------------------------------

define :play_MUSIC do
  n=0
  print "--------------PLAY START--------------"
  while (n<step.length)
    use_bpm BPM
    play note[octave[n]][step[n]],release: duration[n]*0.5
    sleep duration[n]*0.5
    n=n+1
  end
  print "---------------PLAY END---------------"
end


#run from here
load_CSV
loop do
  play_MUSIC
end

