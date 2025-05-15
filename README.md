# 🔢 UEFN Verse PinPad

Fortnite UEFN（Unreal Editor for Fortnite）で作成した、Verseスクリプトによる暗証番号式Pin Padデバイスです。

![screenshot](https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad0.png?raw=true)

## 🎮 概要

このプロジェクトでは、UEFNでのカスタムUIとVerseスクリプトを使い、以下のようなPinPad機能を実装しています：

- 数字ボタン（0〜9）
- 1文字削除ボタン
- 全消去ボタン
- 正しい暗証番号を入力するとトリガーが起動する

## 使用方法
### Verse Explorerを開く
-  UEFNのエディタ画面で上部メニューから`Verse`を選択して`Verse Explorer`をクリックしてVerseエクスプローラーを開きます。
### 新しいVerseファイルを作成する
- Verse Explorerの一番上にあるプロジェクト名の部分を右クリックし、`新規Verseファイルをプロジェクトに追加する`をクリックします。
- Device Nameの部分に使用したいデバイスの名前を打ち込み、`空のスクリプトを作成`をクリックします。
- 新しくできたVerseファイルをダブルクリックするとVSCodeが起動します。
### コードを作成する
- [PinPad.verse](https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/PinPad.verse)の内容をコピーして新しく作ったVerseファイルにペーストします。
- UEFNの画面に戻り、上部メニューから`Verse`を選択して`Verseコードをビルド`をクリックします。
### Verseコードを使用できるようにする
- ビルド後に`コンテンツブラウザ`から作成したVerseコードのVerseクラスをドラックしてワールドに設置します。
- 設置したVerseクラスを選択します。
- 詳細画面にある`MyButton`に使用するボタンを設定します。
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad1.png" width="300">

- `Passcodes`の部分の+をクリックしてできたインデックスの右の▶をクリックします
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad5.png" width="300">

- ▶を押して出た`PIN`にパスワードを設定します
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad4.png" width="300">

- `Trigger`の部分が`Set to Value`となっているので`trigger_device`を設定します
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad3.png" width="300">

- `Trigger`の部分が`なし`になるので使用するトリガーを設定します
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad2.png" width="300">

- `Passcodes`の内容を増やすことでパスワードも増やせます。
<img src="https://github.com/gori-GORILLA-gori/UEFN-Verse-PinPad/blob/main/image/Fortnite_pinpad6.png" width="300">

## 📽️ 動画デモ

[YouTubeで見る](https://youtu.be/Vyn8OfEEVzI)

## 📁 ファイル構成
```
UEFN-Verse-PinPad
┣━LICENSE      #MITライセンス
┣━PinPad.verse #コード本体
┣━README.md    #このファイル
┣━image        #デモや説明の画像
┃ ┣━Fortnite_pinpad0.png
┃ ┣━Fortnite_pinpad1.png
┃ ┣━Fortnite_pinpad2.png
┃ ┣━Fortnite_pinpad3.png
┃ ┣━Fortnite_pinpad4.png
┃ ┣━Fortnite_pinpad5.png
┃ ┗━Fortnite_pinpad6.png
```
## 📝 ライセンス

このプロジェクトはMITライセンスの下で公開されています。
