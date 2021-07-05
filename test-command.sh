#!/bin/zsh
time maude << EOF
in debug.maude .
in specs/qlock.maude
in full-maude
in solver
(initialize[QLOCK-CHECK, init5, lofree, OComp, Soup{OComp}])
(layerCheck 2 2)
(lastCheck)
EOF