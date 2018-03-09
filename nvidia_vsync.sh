#!/bin/bash

# This is specific to my multi-monitor setup.

function on {
  nvidia-settings --assign CurrentMetaMode="DVI-I-0: 1360x768_60 +0+312 { ForceCompositionPipeline = On }, DVI-D-0: 1920x1080_60 +1360+0 { ForceCompositionPipeline = On }"
  # nvidia-settings --assign CurrentMetaMode="DVI-I-0: 1024x768_60 +0+312 { ForceCompositionPipeline = On }, DVI-D-0: 1920x1080_60 +1024+0 { ForceCompositionPipeline = On }"
}

function off {
  nvidia-settings --assign CurrentMetaMode="DVI-I-0: 1360x768_60 +0+312 { ForceCompositionPipeline = Off }, DVI-D-0: 1920x1080_60 +1360+0 { ForceCompositionPipeline = Off }"
  # nvidia-settings --assign CurrentMetaMode="DVI-I-0: 1024x768_60 +0+312 { ForceCompositionPipeline = Off }, DVI-D-0: 1920x1080_60 +1024+0 { ForceCompositionPipeline = Off }"
}
