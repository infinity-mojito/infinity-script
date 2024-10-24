#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# Initialize ROM manifest
repo init -u https://github.com/ProjectMatrixx/android.git -b 14.0 --git-lfs

# Sync the rpo with force to ensure a clean sync
/opt/crave/resync.sh

# remove 
rm -rf packages/apps/GameSpace

# cloning device tree
git clone https://github.com/matrix-mojito/device_xiaomi_mojito.git --depth 1 -b mojito-universe device/xiaomi/mojito
git clone https://github.com/matrix-mojito/android_device_xiaomi_sm6150-common.git --depth 1 -b mojito-universe device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/bliss-mojito/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/bliss-mojito/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

#cloning private keys
git clone https://github.com/sunny-keys/vendor_lineage-priv_keys-matrixOS.git --depth 1 -b master vendor/lineage-priv/keys

# add source file
git clone https://github.com/ProjectMatrixx/android_packages_apps_GameSpace.git --depth 1 -b 14.0 packages/apps/GameSpace

# Set up the build environment
. build/envsetup.sh

# Choose the target device
brunch mojito

# Build the ROM (use mka bacon for a full build)
# mka bacon
