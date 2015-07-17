#!/bin/bash

FONT=$1
FONTNAME=${1%%.otf}
RELEASE_URL="https://github.com/${TRAVIS_REPO_SLUG}/releases/download/${TRAVIS_TAG}"
mkdir -p build/

fontforge -script convert_fonts.pe $FONT

mkeot $FONT > build/$FONTNAME.eot

cat <<EOF > build/$FONTNAME.css
@font-face {
  font-family: '$FONTNAME';
  src: url('${RELEASE_URL}/${FONTNAME}.eot'); /* IE 9 Compatibility Mode */
  src: url('${RELEASE_URL}/${FONTNAME}.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
       url('${RELEASE_URL}/${FONTNAME}.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
       url('${RELEASE_URL}/${FONTNAME}.ttf') format('truetype'), /* Safari, Android, iOS */
       url('${RELEASE_URL}/${FONTNAME}.svg#${FONTNAME}') format('svg'); /* Chrome < 4, Legacy iOS */
  font-weight: normal;
  font-style: normal;
}
EOF

zip -r build/"${FONTNAME}_${TRAVIS_TAG}.zip" build/${FONTNAME}*
