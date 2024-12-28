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

cd frameworks/native
curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/cbb6dd194451857e18211a9e3db0e57d5b8da71f.patch | git am
curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/aa575c1d3c5a7d36e0003124a22030cccb93fdae.patch | git am
curl -s https://github.com/ProjectInfinity-X/frameworks_native/commit/8af605927f53105ce62f7b14ee47b6ca50122364.patch | git am
cd ../..
cd vendor/infinity
git fetch https://github.com/Pissel7Series/vendor_infinity.git p15 && git cherry-pick e7a4485
cd ../..

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch infinity_mojito-user

# Build the ROM (use mka bacon for a full build)
mka bacon

cd out/target/product/mojito
curl -T *.zip -u :2b0faa06-cdf4-45b2-bb25-34e443e133ce https://pixeldrain.com/api/file/
