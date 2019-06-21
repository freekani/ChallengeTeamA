# LeapMotion
　:shipit:Leap Motionを用いたジェスチャ操作による、拍数情報をraspberry piに送る。
## 目次
1. Rasberry pi(Ubuntu)でLeap motionが動くかの検証
2. ~~Unity~~
3. [Processing](#3processing)
## 1.Rasberry pi(Ubuntu)でLeap motionが動くかの検証  
- [x] [Ubuntu OSのダウンロード](https://wiki.ubuntu.com/ARM/RaspberryPi)（ubuntu-18.04.2-preinstalled-server-arm64+raspi3.img）  
- [x] Ubuntu Desktopのインストール (ubuntu-mate-desktop)
- [x] Ubuntuの言語設定
- [x] [Leap Motion SDK for linux](https://www.leapmotion.com/setup/desktop/linux/)(Leap_Motion_Setup_Linux_2.3.1.tgz)
- [ ] LeapMotionの環境構築  
### 構築失敗原因
        パッケージアーキテクチャ(amd64)がシステム(arm64)と一致しない
![installError](https://github.com/freekani/ChallengeTeamA/blob/input/image/ubuntu_error.jpg)
## ~~2.Unity~~
- [x] [~~Unityのダウンロード~~](https://store.unity.com/ja?_ga=2.109239045.1635307830.1561082608-1793881246.1537953195&currency=JPY)
- [x] [~~Unity Assets for Leap Motion Orion Betaのダウンロード（Leap_Motion_Core_Assets_ 4.4.0.unitypackage）~~]
- [x] ~~LeapMotionの環境構築~~  
- [ ] ~~開発~~
## 3.Processing
- [x] [Processingのダウンロード](https://processing.org/download/)
- [x] LeapMotionの環境構築
- [x] [UDP通信の実装](https://memorandums.hatenablog.com/entry/2016/11/08/203610)
- [ ] ジャスチャーの設計
- [ ] 拍数に検出
- [ ] 指揮棒の検出
- [ ] プログラムの完成
### 開発
　[leap-motion-processing](https://github.com/nok/leap-motion-processing)のコードで、Processingでleapmotionの実行を確認した
#### LeapOrchestra（開発中）
　[LeapOrchestraへ移動](https://github.com/SkyoKen/LeapOrchestra)
#### LeapDraw（手の座標で線を描く）
　[LeapDrawへ移動 (update 2019.06.21)](https://github.com/SkyoKen/LeapDraw)
#### ~~Processing で通信するプログラム~~  
　[~~NetTermianlへ移動 (update 2019.06.18)~~](https://github.com/SkyoKen/NetTerminal/tree/master/Net)
#### ~~バイナリファイルからデータの書き込みと読み込み~~
　[~~binaryへ移動 (update 2019.06.20)~~](https://github.com/SkyoKen/LeapOrchestra/tree/master/binary) 
#### Processing用のUDP通信プログラム
　[UDP通信プログラムへ移動](https://github.com/SkyoKen/NetTerminal/tree/master/UDP/Processing)
#### LeapPiano（Leap Motionを用いたジェスチャ操作によるピアノを弾くプログラム）
　[LeapPianoへ移動(update 2019.06.21)](https://github.com/SkyoKen/LeapPiano)


[↑TOP](#目次)
