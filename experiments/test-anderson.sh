#!/bin/bash
time maude << EOF
in ../debug.maude .
in ../specs/anderson.maude
red in ANDERSON-CHECK : modelCheck(init9, halt) .
EOF