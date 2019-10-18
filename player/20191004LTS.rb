#20190930
require "csv"
csv_path='/home/pi/teamA/ChallengeTeamA/player/score.csv'
data_list = CSV.read(csv_path)
notes = [ [0,:C1,:D1,:E1,:F1,:G1,:A1,:B1],
          [0,:C2,:D1,:E2,:F2,:G2,:A2,:B2],
          [0,:C3,:D3,:E3,:F3,:G3,:A3,:B3],
          [0,:C ,:D ,:E ,:F ,:G ,:A ,:B ],
          [0,:C5,:D5,:E5,:F5,:G5,:A5,:B5],
          [0,:C6,:D6,:E6,:F6,:G6,:A6,:B6],
          [0,:C7,:D7,:E7,:F7,:G7,:A7,:B7],]

tune=[0,1]
rise=[0,1]
mlength=[0,1]

data4=[0,1]




flag="RESET"
t = 0
musicNum=0
vol=1
scale0=3
time=0.5


#ini
define :ini do |n|
  #tune = [ 6, 7, 1, 7, 1, 3, 7, 3, 6, 5, 6, 1, 5, 3, 4, 3, 4, 1, 3, 1, 7, 4, 4, 7, 7, 6, 7, 1, 7, 1, 3, 7, 3, 3, 6, 5, 6, 1, 5, 3, 4, 1, 7, 1, 2, 3, 1, 1, 1, 7, 6, 7, 5, 6, 1, 2, 3, 2, 3, 5, 2, 5, 1, 7, 1, 2, 3, 3, 6, 7, 1, 7, 1, 2, 1, 5, 5, 4, 3, 2, 1, 3, 3, 6, 6, 5, 5, 3, 2, 1, 1, 2, 1, 2, 5, 3, 3, 6, 6, 5, 5, 3, 2, 1, 1, 2, 1, 2, 7, 6, 0].ring
  #rise = [ 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1 ].ring
  #mlength =[ 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 0.5, 1.0, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 0.5, 1.5, 3.0, 1.0, 1.5, 0.5, 0.5, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.0, 0.5, 1.5, 1.0, 1.0, 0.5, 0.5, 2.0, 0.5, 0.5, 1.0, 1.0, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.0, 0.5, 0.5, 4.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0, 1.5, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.5, 0.5, 0.5, 0.5, 1.0, 2.0, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.5, 0.5, 0.5, 0.5, 1.0, 2.0, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0].ring
  print "initialize start"
  t = 0
  vol=1
  scale0=3
  time=0.5
  
  case n
  when 0
    print "test"
    tune=[0,1]
    rise=[0,1]
    mlength=[0,1]
    
    data4=[0,1]
    tune.clear
    rise.clear
    mlength.clear
    
    data4.clear
    
    
    for data in data_list do#csv
        tune.push(data[0].to_i(10))
        rise.push(data[1].to_i(10))
        mlength.push(data[2].to_i(10))
        data4.push(data[3].to_i(10))
      end
      
      tune = tune.ring
      rise = rise.ring
      mlength = mlength.ring
      data4 = data4.ring
      
      
      #tune.to_i(10)
      #rise.to_i
      #mlength.to_i
      #i=0
      print tune
      print rise
      print mlength
      #      tune = [ 6, 7, 1, 7, 1, 3, 7, 3, 6, 5, 6, 1, 5, 3, 4, 3, 4, 1, 3, 1, 7, 4, 4, 7, 7, 6, 7, 1, 7, 1, 3, 7, 3, 3, 6, 5, 6, 1, 5, 3, 4, 1, 7, 1, 2, 3, 1, 1, 1, 7, 6, 7, 5, 6, 1, 2, 3, 2, 3, 5, 2, 5, 1, 7, 1, 2, 3, 3, 6, 7, 1, 7, 1, 2, 1, 5, 5, 4, 3, 2, 1, 3, 3, 6, 6, 5, 5, 3, 2, 1, 1, 2, 1, 2, 5, 3, 3, 6, 6, 5, 5, 3, 2, 1, 1, 2, 1, 2, 7, 6, 0].ring
      #      rise = [ 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1 ].ring
      #      mlength =[ 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 0.5, 1.0, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 0.5, 1.5, 3.0, 1.0, 1.5, 0.5, 0.5, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.0, 0.5, 1.5, 1.0, 1.0, 0.5, 0.5, 2.0, 0.5, 0.5, 1.0, 1.0, 1.0, 3.0, 0.5, 0.5, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.0, 0.5, 0.5, 4.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0, 1.5, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.5, 0.5, 0.5, 0.5, 1.0, 2.0, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0, 1.5, 0.5, 1.5, 0.5, 0.5, 0.5, 1.0, 2.0, 1.5, 0.5, 1.0, 1.0, 3.0, 1.0].ring
      when 1
      print "�ǌ���"
      tune =[ 6, 7, 1, 7, 3, 3, 5, 5, 1, 2, 1, 2, 2, 5, 3, 6, 7, 1, 7, 3, 3, 5, 1, 5, 1, 2, 3, 1, 7, 6, 7, 1, 1, 3, 2, 7, 6, 5, 6, 7, 7, 2, 1, 0, 1, 7, 1, 0, 6, 6, 7, 1, 7, 6, 5, 0].ring
      rise =[ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0].ring
      mlength =[ 0.250, 0.250, 0.500, 0.250, 0.250, 0.500, 0.500, 1.000, 1.000, 0.500, 0.250, 0.250, 0.500, 0.500, 1.000, 0.500, 0.500, 0.500, 0.250, 0.250, 0.500, 0.500, 1.000, 3.000, 0.500, 0.500, 1.000, 0.500, 0.500, 0.500, 0.250, 0.250, 0.500, 0.500, 1.000, 0.500, 0.500, 0.500, 0.250, 0.250, 0.500, 0.500, 1.000, 0.500, 0.250, 0.250, 1.000, 0.250, 0.250, 0.250, 0.250, 0.500, 0.500, 0.500, 0.500, 1.000].ring
      
      when 2
      print "Brother John"
      tune = [ 1, 2, 3, 1,  1, 2, 3, 1, 3, 4, 5, 3, 4, 5, 5, 6, 5, 4, 3, 1, 5, 6, 5, 4, 3, 1, 2, 5, 1,  2, 5, 1].ring
      rise =[ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,-1,0].ring
      mlength =[ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 0.75,0.25,0.75,0.25,1,1, 0.75,0.25,0.75,0.25,1,1,1, 1 ,2, 1, 1 ,2].ring
      
      
    end
    
    print "initialize finished"
  end
  
  #set MusicNum [0,2]
  live_loop :setMusicNum do
    use_real_time
    msg = sync "/osc/MUSICNUM"
    musicNum=[[musicNum+msg[0],0].max,2].min
    flag="CHANGE"
  end
  
  #set flag (RESET,CHANGE,START,STOP)
  live_loop :setFlag do
    use_real_time
    msg = sync "/osc/FLAG"
    flag=msg[0]
    print flag
  end
  
  #set vol [0,5]
  live_loop :setVol do
    use_real_time
    msg = sync "/osc/VOLUME"
    vol=[[vol+msg[0],0].max,5].min
    print "set vol",vol
  end
  
  #set time [0,5]
  live_loop :setTime do
    use_real_time
    msg = sync "/osc/TIME"
    time=[[time+msg[0],0.25].max,1].min
    print "set time",time
  end
  
  #set scale [0,6]
  live_loop :setScale do
    use_real_time
    msg = sync "/osc/SCALE"
    scale0=[[scale0+msg[0],0].max,6].min
    
    # octave=[[octave+msg[0],0].max,6].min
    print "scale=",scale0
  end
  
  
  
  #music
  define :musicplay do
    t=(inc t)
    playing t,vol
  end
  define :playing do |n,v|
    o=[[scale0+rise[n],0].max,6].min
    play notes[o][tune[n]],release: mlength[n]*time,amp: vol
    sleep mlength[n]*time
  end
  
  
  #main
  live_loop :main do
    if flag=="RESET"
      flag="STOP"
      ini musicNum
    end
    
    if flag=="CHANGE"
      flag="START"
      ini musicNum
    end
    if flag=="START"
      
      musicplay
    else
      print "Waiting for operation"
      sleep 1
    end
    
  end
  
  
  
  