# Welcome to Sonic Pi v3.1
require "csv"
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
# 何か時間のかかることをする

data_list = CSV.read('C:\Users\yamas\OneDrive\大学資料\3年前期\挑戦型プロジェクト\data.csv')
print data_list
i=0
data1=[]
data2=[]
data3=[]
while i < data_list.length do
    data1[i] = data_list[i][0]
    data2[i] = data_list[i][1]
    data3[i] = data_list[i][2]
    i = i + 1
  end
  print data1
  print data2
  print data3
  
  #ここからかかった時間を出力するコード
  sleep 1
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  elapsed = ending - starting
  print elapsed
  
  
  # 上記のでcsvからデータの取り出しはできている、
  