#!/usr/local/bin/bash -e

#TODO
#  optify width, height
#  optify flipping: some tiles tile
#

if let $(($# < 1 )); then
   echo "need a base stem. use -x for help"
   exit 0
fi

width=1024
height=1024
base=$1
flip=1
shift 1


while getopts :w:h:xF opt
do
    case "$opt" in
    w)
      width=$OPTARG
      ;;
    h)
      height=$OPTARG
      ;;
    F)
      flip=0
      ;;
    x)
      cat <<EOU
Usage: flip.sh <BASE> [options]
It is assumed that <BASE>.pnm exists.
Options:
   -w    <tile width>
   -h    <tile height>
   -F                      Do not flip image
   -x                      This help
EOU
      ;;
    :) echo "Flag $OPTARG needs argument"
        exit 1;;
    ?) echo "Flag $OPTARG unknown"
        exit 1;;
   esac
done


if ! test -e $base.pnm; then
   echo "Cannot find file $base.pnm! (use -x for usage)"
   false
fi

if test "x$flip" == "x0"; then
   pnmtile $width $height $base.pnm > $base.TILE.pnm
else
   pnmflip -leftright $base.pnm | pnmcut -left 1 -right -2 > $base.LR.pnm
   pnmflip -topbottom $base.pnm | pnmcut -top 1 -bottom -2 > $base.TB.pnm
   pnmflip -leftright -topbottom $base.pnm | pnmcut -left 1 -top 1 -right -2 -bottom -2 > $base.LRTB.pnm
   pnmcat -leftright $base.pnm $base.LR.pnm > $base.TOP.pnm
   pnmcat -leftright $base.TB.pnm $base.LRTB.pnm > $base.BOT.pnm
   pnmcat -topbottom $base.TOP.pnm $base.BOT.pnm > $base.ALL.pnm
   pnmtile $width $height $base.ALL.pnm > $base.TILE.pnm
fi

pnmtops -width $width -height $height -flate -rle -psfilter $base.TILE.pnm > $base.ps
