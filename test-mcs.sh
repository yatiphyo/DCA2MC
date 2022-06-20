#!/bin/bash
time maude << EOF
in debug.maude .
in specs/mcs.maude
in full-maude
in solver
(initialize[MCS-CHECK, init2, lofree, OComp, Soup{OComp}])
(layerCheck 4 4 4 4)
(lastCheck)
EOF