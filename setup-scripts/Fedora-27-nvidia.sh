#!/bin/bash

# Update system.
dnf update -y
# Install repo.
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-nvidia.repo
# Install drivers and CUDA.
dnf install -y nvidia-driver nvidia-settings kernel-devel akmod-nvidia vulkan vulkan.i686 nvidia-driver-libs nvidia-driver-libs.i686 cuda nvidia-driver-cuda cuda-devel cuda-cudart
# Autoremove any unneeded dependancies.
dnf autoremove -y
