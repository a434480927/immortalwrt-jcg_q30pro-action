#!/bin/bash
#
# Netcore N60 Pro (MT7986A, 512MB DDR4, 128MB SPI-NAND, AX6000)
#
# 固件配置固定在仓库根目录：mt7986-ax6000-n60pro.config
# （chasey-dev 的 mt7986-ax6000 档裁剪为单设备，并补 LuCI / ksmbd / honk 依赖）
# workflow 会把该文件移到 openwrt/.config，本脚本只做 defconfig 与断言。
#
set -e

[ -f .config ] || { echo "ERROR: .config not found (repo config not moved)"; exit 1; }

echo "=== config lines before defconfig: $(grep -c '' .config) ==="

make defconfig

grep -q '^CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_netcore_n60-pro=y$' .config || {
	echo "ERROR: netcore_n60-pro device was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_KERNEL_DEBUG_INFO_BTF=y$' .config || {
	echo "ERROR: KERNEL_DEBUG_INFO_BTF was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_PACKAGE_ip-full=y$' .config || {
	echo "ERROR: ip-full was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_PACKAGE_kmod-fs-ksmbd=y$' .config || {
	echo "ERROR: ksmbd kernel module was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_PACKAGE_ksmbd-server=y$' .config || {
	echo "ERROR: ksmbd-server was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_PACKAGE_kmod-nft-fib=y$' .config || {
	echo "ERROR: kmod-nft-fib was dropped by Kconfig"; exit 1; }
grep -q '^CONFIG_PACKAGE_tc-bpf=y$' .config || {
	echo "ERROR: tc-bpf was dropped by Kconfig"; exit 1; }

echo "=== target ==="
grep -E '^CONFIG_TARGET_(mediatek|mediatek_filogic|MULTI_PROFILE|PER_DEVICE_ROOTFS)' .config || true
echo "=== device ==="
grep '^CONFIG_TARGET_DEVICE_' .config
echo "=== wifi ==="
grep -E '^CONFIG_MTK_(WIFI_SKU_TYPE|CHIP_MT7986|MT_WIFI_FIRMWARE_PATH_MT7986|WIFI_ADIE_TYPE)' .config || true
echo "=== honk / BTF ==="
grep -E '^CONFIG_(KERNEL_DEBUG_INFO|PACKAGE_tc-bpf|PACKAGE_ip-full|PACKAGE_kmod-(nfnetlink-queue|nft-queue|sched-bpf|veth))' .config || true