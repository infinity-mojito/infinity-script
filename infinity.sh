#!/bin/bash

# before clone remove
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi
rm -rf vendor/xiaomi/mojito-leicacamera
rm -rf vendor/xiaomi/miuiapps

rm -rf frameworks/native
rm -rf frameworks/av
rm -rf vendor/infinity

# Initialize ROM manifest
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 15 -g default,-mips,-darwin,-notdefault

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# after clone remove
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi
rm -rf vendor/xiaomi/mojito-leicacamera
rm -rf vendor/xiaomi/miuiapps

# remove source
rm -rf vendor/infinity
rm -rf frameworks/av

# cloning device tree
git clone https://github.com/infinity-mojito/android_device_xiaomi_mojito.git --depth 1 -b 15 device/xiaomi/mojito
git clone https://github.com/infinity-mojito/android_device_xiaomi_sm6150-common.git --depth 1 -b 15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/infinity-mojito/android_kernel_xiaomi_mojito --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/romgharti/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/ProjectEverest-Devices/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# add source
git clone https://github.com/infinity-mojito/vendor_infinity.git -b 15 vendor/infinity
git clone https://github.com/infinity-mojito/frameworks_av.git -b 15 frameworks/av

git clone https://gitlab.com/dpenra/android_vendor_xiaomi_mojito-leicacamera.git --depth 1 -b main vendor/xiaomi/mojito-leicacamera
git clone https://github.com/extra-application/vendor_xiaomi_miuiapps.git --depth 1 -b main vendor/xiaomi/miuiapps

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch infinity_mojito-user

# Build the ROM (use mka bacon for a full build)
mka bacon

# pixeldrain upload
cd out/target/product/mojito
curl -T Project_Infinity*.zip -u :2b0faa06-cdf4-45b2-bb25-34e443e133ce https://pixeldrain.com/api/file/
curl -T Project_Infinity*.zip -u :df7faee7-526a-4d50-bbee-e8e9fb041f3d https://pixeldrain.com/api/file/
