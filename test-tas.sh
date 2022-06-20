#!/bin/bash
time maude << EOF
in debug.maude .
in specs/tas.maude
in full-maude
in solver
(initialize[TAS-CHECK, init2, lofree, OComp, Soup{OComp}])
(layerCheck 3 3)
(lastCheck)
EOF