#!/bin/bash

./snarkos start --nodisplay --prover --private-key $PROVER_PRIVATE_KEY
cpulimit -e snarkos --limit 85 --background
