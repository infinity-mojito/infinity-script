#!/bin/bash

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi
rm -rf vendor/infinity
rm -rf frameworks/native

# Initialize ROM manifest
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 15 -g default,-mips,-darwin,-notdefault

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/native
# rm -rf frameworks/native
rm -rf vendor/infinity

# cloning device tree
git clone https://github.com/infinity-mojito/android_device_xiaomi_mojito.git --depth 1 -b 15 device/xiaomi/mojito
git clone https://github.com/infinity-mojito/android_device_xiaomi_sm6150-common.git --depth 1 -b 15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/ProjectEverest-Devices/android_kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/ProjectEverest-Devices/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi
git clone https://github.com/infinity-mojito/vendor_infinity.git --depth 1 -b 15-QPR1 vendor/infinity
# git clone https://github.com/infinity-mojito/frameworks_native.git --depth 1 -b 15-QPR1 frameworks/native
# cd frameworks/native
# curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/d6679f5d8c2fb3a84ff539ebf5e919d3f20cc120.patch | git am
# curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/2ce8829eb2cefc15ba92fb037f48aabaff2071d2.patch | git am
# curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/c537194c7995e60a1cc996147febf0bdd958dd09.patch | git am

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch infinity_mojito-user

# Build the ROM (use mka bacon for a full build)
mka bacon
cd out/target/product/mojito
curl -T *.zip -u :2b0faa06-cdf4-45b2-bb25-34e443e133ce https://pixeldrain.com/api/file/
