#!/bin/sh

template=$1
rotation=$2
ssdval=$3
name=$4

x=0
echo `basename ${template}` #テンプレート画像の名前を表示
ssdval=1
if [ $x = 0 ] #もし変数xが0だったら？
then
    #下記コマンドを実行．cpは，出力テキストをクリアして，結果をprint
    #オプションや閾値の変更を試してみること．
    ./matching $name "${template}" $rotation $ssdval cp
    x=1 #xに1を代入して，同じ画像ファイルではクリア命令をしないようにする
else
    #最初以外（x=1)はcオプション(clear)を使わない
    ./matching $name "${template}" $rotation $ssdval p
fi