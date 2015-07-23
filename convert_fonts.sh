#!/bin/bash

FONT=$1
RELEASE_URL="https://github.com/${TRAVIS_REPO_SLUG}/releases/download/${TRAVIS_TAG}"
mkdir -p build/


convert_font() {
  local font=$1
  local fontname=${font%%.otf}

  fontforge -script convert_fonts.pe $font
  
  mkeot $font > build/$fontname.eot
  
  cat <<EOF > build/$fontname.css
  @font-face {
    font-family: '$fontname';
    src: url('${RELEASE_URL}/${fontname}.eot'); /* IE 9 Compatibility Mode */
    src: url('${RELEASE_URL}/${fontname}.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('${RELEASE_URL}/${fontname}.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('${RELEASE_URL}/${fontname}.ttf') format('truetype'), /* Safari, Android, iOS */
         url('${RELEASE_URL}/${fontname}.svg#${fontname}') format('svg'); /* Chrome < 4, Legacy iOS */
    font-weight: normal;
    font-style: normal;
  }
EOF
  
  zip -r build/"${fontname}_${TRAVIS_TAG}.zip" build/${fontname}*
}

for f in $@; do
  convert_font $f
done
