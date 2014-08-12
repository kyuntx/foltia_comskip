foltia_comskip
==============

foltia ANIME LOCKER CMスキップ用チャプター追加パッチ

## これは何？

[foltia ANIME LOCKER](http://foltia.com/ANILOC/) で録画した動画に [comskip](http://www.kaashoek.com/comskip/) を使用してCMスキップ用のチャプターをつけるためのパッチとシェルです。

個人的に使うために作ったレベルなので完全に無保証です、せっかく録画したファイルが飛んでしまっても後悔しない方のみご使用ください。（一応半年くらい使って飛んだことはありませんが。。。）

## 使い方

. [comskip](http://www.kaashoek.com/comskip/)のバイナリをダウンロードし、解凍したファイル一式を `/home/foltia/perl/tool/comskip/` に配置します。

    [foltia@foltia ~]$ mkdir tmp
    [foltia@foltia ~]$ cd tmp/
    [foltia@foltia tmp]$ wget http://www.kaashoek.com/files/comskip81_064.zip
    [foltia@foltia tmp]$ mkdir comskip
    [foltia@foltia tmp]$ unzip comskip81_064.zip -d comskip/
    [foltia@foltia tmp]$ mv comskip /home/foltia/perl/tool/

. `/home/foltia/perl/tool/comskip/` に `work` というディレクトリを作成します。

    [foltia@foltia ~]$ mkdir /home/foltia/perl/tool/comskip/work

. 本リポジトリに含まれるファイル一式を適当なディレクトリに置きます。(ここでは `/home/foltia/tmp/`)  

. `comskip.ini` ファイルを `/home/foltia/perl/tool/comskip/` に上書きコピーします。

    [foltia@foltia tmp]$ cp comskip.ini /home/foltia/perl/tool/comskip/

. `foltia_comskip.sh`, `foltia_comskip_byid_m2t.sh` を `/home/foltia/perl/tool/` におき、で実行権限をつけます。 

    [foltia@foltia tmp]$ cp foltia_comskip.sh foltia_comskip_byid_m2t.sh /home/foltia/perl/tool/
    [foltia@foltia tmp]$ chmod 755 /home/foltia/perl/tool/foltia_comskip*.sh

. `ipodtranscode.pl` にパッチを当てます。

    [foltia@foltia ~]$ cd /home/foltia/perl
    [foltia@foltia ~]$ cp ipodtranscode.pl ipodtranscode.pl.backup
    [foltia@foltia ~]$ patch -p0 < /home/foltia/tmp/ipodtranscode.pl.patch

### 既にエンコード済みの MP4 ファイルに手動でチャプタをつける

foltia_comskip_byid_m2t.sh を、対象の動画のファイルIDを引数にして実行します。

    /home/foltia/perl/tool/foltia_comskip_byid_m2t.sh 3424-6-20140811-0105-23

- TSファイル(.m2t)と、HDエンコード済みのファイル(MHD*.MP4)の両方が存在している必要があります。
- ファイルIDは Foltia の録画一覧の画面をみればわかると思います。MHDとかMAQとか拡張子とかをつけてはいけません。
- 30分のアニメにだいたい５分～１０分くらいかかります。

### 制限事項など

- CM検出の精度は８割といったところです。
- たまにまったくCMを検出しない番組があります。
- まれに動画ファイルの再生時刻の後ろにチャプタがつく事象がでます。
- foltia 本体のアップデートで上書きされるため、アップデートのたびにパッチ当てが必要です。
- ときどきCMスキップの解析にものすごく時間がかかる動画があります（１時間～２時間とか）

## プレイヤごとの対応状況
-×W Windows Media Player
--そもそもチャプタ情報を認識できてない
-×G GOM Player
--チャプタ情報にマトモに対応してないらしい？
-○MPC-HC
--PageDown/Up でさくさく移動
-○MPC-BE
--PageDown/UPでさくさく移動
-○VLC
--画面下のボタンで移動
-△QuickTime
--.mp4 を .m4v に拡張子を変えないとチャプタを認識しない
-△iPhone/iPad
--.mp4 を .m4v に拡張子を変えないとチャプタを認識しない、Safari経由だとそれもダメ。PodCast経由でもダメ。
-○Apple  TV(iTunesのPodCast経由)
--リモコンで　↓→　で移動可能

## ライセンス

- MITライセンス

