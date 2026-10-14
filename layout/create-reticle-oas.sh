#!/bin/sh
set -Ce
cat GFMPW18H1-part-* > GFMPW18H1.oas
echo "9656625041036d94d27bf52af8eb2a8d  GFMPW18H1.oas" | md5sum -c
