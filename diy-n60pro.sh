#!/bin/bash
#
# Netcore N60 Pro (MT7986A, 512MB DDR4, 128MB SPI-NAND, AX6000)
# Profile: mt7986-ax6000 (MTK closed-source wifi), single device build.
#
set -e

echo "=== apply mt7986-ax6000 profile, keep only netcore_n60-pro ==="
cp defconfig/mt7986-ax6000.config .config

# The stock profile enables every AX6000-class device at once (multi profile).
# Keep only the N60 Pro so one image is built instead of ~25 rootfs trees.
sed -i '/^CONFIG_TARGET_DEVICE_/d' .config
sed -i '/^CONFIG_TARGET_DEVICE_PACKAGES_/d' .config
cat >> .config <<'EOF'
CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_netcore_n60-pro=y
CONFIG_TARGET_DEVICE_PACKAGES_mediatek_filogic_DEVICE_netcore_n60-pro=""
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-app-package-manager=y
CONFIG_PACKAGE_luci-i18n-base-zh-cn=y
EOF

make defconfig

grep -q 'CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_netcore_n60-pro=y' .config || {
	echo "ERROR: netcore_n60-pro device was dropped by Kconfig"; exit 1; }

echo "=== target ==="
grep -E '^CONFIG_TARGET_(mediatek|mediatek_filogic|MULTI_PROFILE|PER_DEVICE_ROOTFS)' .config || true
echo "=== device ==="
grep '^CONFIG_TARGET_DEVICE_' .config
echo "=== wifi ==="
grep -E '^CONFIG_MTK_(WIFI_SKU_TYPE|CHIP_MT7986|MT_WIFI_FIRMWARE_PATH_MT7986|WIFI_ADIE_TYPE)' .config || true
