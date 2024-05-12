#!/bin/bash
cd bdk-dart || exit 1
bash linux.sh "$VERSION"
exec "$@"