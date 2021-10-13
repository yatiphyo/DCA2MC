#!/bin/bash
time maude << EOF
in debug.maude .
in specs/self-stabilization/k-states.maude
in full-maude
in solver
(initialize[K-STATES-CHECK, init15, cstable, OComp, Soup{OComp}])
(layerCheck 2 2)
(lastCheck)
EOF