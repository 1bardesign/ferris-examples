#!/bin/sh -e

#initial setup
rm -rf dist
rm -f ferris-examples.love
rm -f ferris-examples-win.zip

#raw love2d file
cd ..
zip pack/ferris-examples.love -r *.lua src assets lib -x "*/.*"
cd pack

#windows
mkdir dist
cat ./win/love.exe ferris-examples.love > dist/ferris-examples.exe
cp ./win/*.dll dist
#copy licensing
cp ./win/license.txt dist/license_love2d.txt
cp ../lib/batteries/license.txt dist/license_batteries.txt
cp ../lib/ferris/license.txt dist/license_ferris.txt
#copy readme
cp ../readme.md dist/readme.md
#zip everything up
cd dist
zip -r ../ferris-examples-windows.zip .
cd ..
rm -rf dist
