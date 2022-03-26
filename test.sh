#!/bin/bash
echo $1 | $(command -v md5 || command -v md5sum) | grep -qif /dev/stdin /home/ewan/becode/clmystery/encoded && echo CORRECT\! GREAT WORK, GUMSHOE. || echo SORRY, TRY AGAIN.
