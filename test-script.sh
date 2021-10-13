#!/bin/bash
time maude << EOF
in debug.maude .
in specs/self-stabilization/k-states.maude
red in K-STATES-CHECK : modelCheck(init15, cstable)
EOF