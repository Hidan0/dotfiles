#!/bin/sh

noteFilename="$HOME/notes/cornell/$(date +%Y%m%d).md"

if [ ! -f $noteFilename ]; then
  echo "# Notes for $(date +%Y-%m-%d)" > $noteFilename
fi

nvim -c "norm Go" -c "norm Go## $(date +%H:%M)  " -c "norm Go## Key points" -c "norm Go## Summary" -c "norm Go---" -c "norm G3k$" -c "startinsert" $noteFilename
