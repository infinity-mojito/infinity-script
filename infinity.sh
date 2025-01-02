#!/bin/bash

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 15 -g default,-mips,-darwin,-notdefault

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/native
rm -rf hardware/xiaomi
rm -rf vendor/infinity
rm -rf frameworks/native

# cloning device tree
git clone https://github.com/infinity-mojito/android_device_xiaomi_mojito.git --depth 1 -b 15 device/xiaomi/mojito
git clone https://github.com/infinity-mojito/android_device_xiaomi_sm6150-common.git --depth 1 -b 15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/ProjectEverest-Devices/android_kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

cd kernel/xiaomi/mojito
curl -s https://github.com/ProjectEverest-Devices/android_kernel_xiaomi_mojito/commit/8ebefd5553383f0ac09c9061448651da0e100d22.patch | git am
cd ../../..

# cloning vendor tree
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common
cd vendor/xiaomi/sm6150-common
curl -s https://gitlab.com/romgharti/android_vendor_xiaomi_sm6150-common/-/commit/1ba39c935d4d98771668a0e14a0be27d2fa09753.patch | git am
curl -s https://gitlab.com/romgharti/android_vendor_xiaomi_sm6150-common/-/commit/38268ef97a0350d97f59112bb6121c4beaa72fb6.patch | git am
cd ../../..

# cloning hardware tree
git clone https://github.com/ProjectEverest-Devices/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# clone vendor/infinity
git clone https://github.com/infinity-mojito/vendor_infinity.git -b 15 vendor/infinity
git clone https://github.com/infinity-mojito/frameworks_native.git -b 15 frameworks/native

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch infinity_mojito-user

# Build the ROM (use mka bacon for a full build)
mka bacon

cd out/target/product/mojito
curl -T Project_Infinity*.zip -u :2b0faa06-cdf4-45b2-bb25-34e443e133ce https://pixeldrain.com/api/file/
curl -T Project_Infinity*.zip -u :df7faee7-526a-4d50-bbee-e8e9fb041f3d https://pixeldrain.com/api/file/
