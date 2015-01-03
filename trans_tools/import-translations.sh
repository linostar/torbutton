#!/bin/sh -e

# This var comes from the TBB locale list.
# XXX: Find some way to keep this, tor-launcher, and Tor Browser in sync
BUNDLE_LOCALES="ar de es fa fr it ko nl pl pt ru tr vi zh-CN"

# XXX: Basque (eu) by request in #10687.
# This is not used for official builds, but should remain 
# so Basque XPIs can be build independently. We can do
# this for other languages too, if anyone requests this
# and translations are available.
BUNDLE_LOCALES="$BUNDLE_LOCALES eu ja sv"

if [ -d translation ];
then
  cd translation
  git fetch origin
  cd ..
else
  git clone https://git.torproject.org/translation.git
fi

cd translation
for i in $BUNDLE_LOCALES
do
  UL="`echo $i|tr - _`"
  mkdir -p ../../src/chrome/locale/$i/
  git checkout abouttor-homepage
  git merge origin/abouttor-homepage
  cp $UL/aboutTor.dtd ../../src/chrome/locale/$i/

  git checkout torbutton-torbuttondtd
  git merge origin/torbutton-torbuttondtd
  cp $UL/torbutton.dtd ../../src/chrome/locale/$i/

  git checkout torbutton-branddtd
  git merge origin/torbutton-branddtd
  cp $UL/brand.dtd ../../src/chrome/locale/$i/

  git checkout torbutton-torbuttonproperties
  git merge origin/torbutton-torbuttonproperties
  cp $UL/torbutton.properties ../../src/chrome/locale/$i/

  git checkout torbutton-browserproperties
  git merge origin/torbutton-browserproperties
  cp $UL/browser.properties ../../src/chrome/locale/$i/

  git checkout torbutton-brandproperties
  git merge origin/torbutton-brandproperties
  cp $UL/brand.properties ../../src/chrome/locale/$i/
done
