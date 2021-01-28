#!/bin/sh
# Disable the Viz display compositor; it causes stuttery scrolling
# Disable GL rendering; it causes corrupted rendering
# This file is part of pinephone_pinetab
export QTWEBENGINE_CHROMIUM_FLAGS='--disable-viz-display-compositor --disable-gpu'
