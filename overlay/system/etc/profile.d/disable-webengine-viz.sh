#!/bin/sh
# Disable the Viz display compositor; it causes stuttery scrolling
# This file is part of pinephone_pinetab
export QTWEBENGINE_CHROMIUM_FLAGS='--disable-viz-display-compositor'
