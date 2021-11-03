#!/bin/bash
time maude << EOF
in ../debug.maude .
in ../specs/qlock.maude
red in QLOCK-CHECK : modelCheck(init9, halt) .
EOF