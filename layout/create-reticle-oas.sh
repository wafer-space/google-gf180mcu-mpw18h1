#!/bin/sh
set -Ce
cat GFMPW18H1-part-* > GFMPW18H1.oas
echo "e65f93005a41a1c997298f8b4abfc07c  GFMPW18H1.oas" | md5sum -c
