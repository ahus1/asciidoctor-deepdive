#!/usr/bin/env bash
set -ex
cd manual
mvn compile
cd ..
cd manual-de
mvn compile
cd manual-ruby
