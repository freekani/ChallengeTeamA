# LeapMotion
　:shipit:Leap Motionを用いたジェスチャ操作による、拍数情報をraspberry piに送る。
## 目次
1. [環境構築](#環境構築)  
    1. [Leap Motion](#leapmotion)
    2. [Processing](#processing)
2. [指揮ジェスチャーの設計](#ジェスチャーの設計)
    1. [各拍子の図形例](#各拍子の図形例)
    2. [設計](#設計)
3. [BPM](#BPM)
## 環境構築

| Item  | Version |
|  ----  | ----  |
| OS  | Windows 10  |
| Leap Motion Software  | 3.2.1+45911 |
| Processing  | processing-3.5.3 |

### LeapMotion
* [Leap_Motion_Developer_Kitのダウンロード（Leap_Motion_Setup.exe）](https://developer.leapmotion.com/get-started)
* [Leap Motion SDKのダウンロード（Leap_Motion_Developer_Kit.zip）](https://developer.leapmotion.com/get-started)

### Processing
* [Processingのダウンロード](https://processing.org/download/)
* [LeapJavaライブラリのインポート(com.leapmotion.leap)](https://developer-archive.leapmotion.com/documentation/java/devguide/Leap_Processing.html)
* Leap Motion for processingライブラリのインポート
* ControlP5ライブラリのインポート

## ジェスチャーの設計
### 各拍子の図形例
[Wikipediaより](https://ja.wikipedia.org/wiki/%E6%8C%87%E6%8F%AE_(%E9%9F%B3%E6%A5%BD))

| Tempo2 | Tempo3 | Tempo4 |
|----|----|----| 
| <img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo2.png" height=200 alt="Tempo2" align=center> | <img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo3.png" height=200 alt="Tempo3" align=center> | <img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo4.png" height=200 alt="Tempo4" align=center> |
| 2/4拍子、2/2拍子、テンポの速い6/8拍子及び速い4/4拍子 | 3/4拍子、3/8拍子及び9/8拍子 | 4/4拍子、12/8拍子及びテンポの遅い2/4（2/2）拍子 |

### 設計

||拍子|①|②|③|④|
|----|----|----|----|----|----| 
|Tempo2|<img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo2__.png" height=200 alt="Tempo2_" align=center>|→|←|||
|Tempo3|<img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo3__.png" height=200 alt="Tempo3_" align=center>|<div align="center">↓</div>|→|↑||
|Tempo4|<img src="https://github.com/SkyoKen/LeapOrchestra/blob/master/image/Tempo4__.png" height=200 alt="Tempo4_" align=center>|<div align="center">↓</div>|<div align="center">←</div>|→|↑|

## BPM
テンポの単位 - 一分間の拍数のこと。(60 bpm =>60拍/分)

・ BPM=60/1拍かかった秒数


[↑TOP](#目次)
