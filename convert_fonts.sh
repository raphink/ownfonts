#!/bin/bash

FONT=$1
FONTNAME=${1%%.otf}
mkdir -p build/

fontforge -script convert_fonts.pe $FONT

mkeot $FONT > build/$FONTNAME.eot

cat <<EOF > build/$FONTNAME.css
@font-face {
  font-family: '$FONTNAME';
  src: url('$FONTNAME.eot'); /* IE 9 Compatibility Mode */
  src: url('$FONTNAME.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
       url('$FONTNAME.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
       url('$FONTNAME.ttf') format('truetype'), /* Safari, Android, iOS */
       url('$FONTNAME.svg#$FONTNAME') format('svg'); /* Chrome < 4, Legacy iOS */
}
EOF
