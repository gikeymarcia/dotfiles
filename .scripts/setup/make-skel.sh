#!/bin/bash

local_skel=~/.config/skel
tarball=skel.tar.gz
tar czf "$tarball" -C "$local_skel" .

echo "view contents:"
echo "tar tvf $tarball"

echo ""
echo "extract:"
echo "tar xf $tarball"
