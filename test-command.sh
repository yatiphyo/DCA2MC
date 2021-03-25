#!/bin/zsh
time maude << EOF
in debug.maude .
in specs/qlock.maude
in full-maude
in solver
(initialize[QLOCK-CHECK, init5, lofree1, lofree2, OComp, Soup{OComp}])
(layerCheck 2 2)
EOF
