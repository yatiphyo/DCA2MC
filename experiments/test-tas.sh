#!/bin/bash
time maude << EOF
in ../debug.maude .
in ../specs/tas.maude
red in TAS-CHECK : modelCheck(init12, halt) .
EOF