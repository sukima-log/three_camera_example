#bin/sh

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

#- environmentに移動
cd $CURRENT

pwd

#- 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : Under dist/ file remove!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

find ../dist/ -type f | grep -v ".gitkeep" | xargs rm
# rm ../dist/index.html \
#     ../dist/script/bundle.js \
#     ../dist/images/*.jpg \
#     ../dist/images/*.png