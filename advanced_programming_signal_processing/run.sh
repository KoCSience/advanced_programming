#!/bin/sh
# imagemagickで何か画像処理をして，/imgprocにかきこみ，テンプレートマッチング
# 最終テストは，直下のforループを次に変更 for image in $1/final/*.ppm; do
for image in $1/test/*.ppm; do
    bname=`basename ${image}`
    name="imgproc/"$bname
    x=0    	#変数ｘを0に
    echo $name

    #Imagemagickで処理して/imgprocに書き出し
    convert "${image}" "${name}"  # 何もしない画像処理
#   convert -blur 2x6 "${image}" "${name}"
#   convert -median 3 "${image}" "${name}" 
#   convert -auto-level "${image}" "${name}"
#   convert -equalize "${image}" "${name}"
    rotation=0 #回転の値をセット．今回は何もしないので0
    echo $bname: #ベースネームを表示

    for template in $1/*.ppm; do #第1引数のディレクトリ内すべてのppmに関してループ
        echo `basename ${template}` #テンプレート画像の名前を表示
        if [ $x = 0 ] #もし変数xが0だったら？
        then
            #下記コマンドを実行．cpは，出力テキストをクリアして，結果をprint
            #オプションや閾値の変更を試してみること．
            ./matching $name "${template}" $rotation 0.5 cp 
            x=1 #xに1を代入して，同じ画像ファイルではクリア命令をしないようにする
        else
            #最初以外（x=1)はcオプション(clear)を使わない
            ./matching $name "${template}" $rotation 0.5 p 
        fi
    done
    echo "" #空行を表示
done
wait
