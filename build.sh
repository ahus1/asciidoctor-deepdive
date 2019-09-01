#!/usr/bin/env bash
set -ex
cd manual
mvn -B compile
cd ..
cd manual-de
mvn -B compile
