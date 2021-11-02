#!/bin/bash
time maude << EOF
in ../debug.maude .
in ../specs/mcs.maude
red in MCS-CHECK : modelCheck(init6, halt) .
EOF