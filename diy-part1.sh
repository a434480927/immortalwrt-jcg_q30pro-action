#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Enable kernel BTF (required by eBPF proxy cores such as honk/dae)
# NOTE: BTF depends on !DEBUG_INFO_REDUCED; REDUCED defaults to y for non-buildbot builds
# Enable NFQUEUE (required by honk nfqueue mode; kmod packages are missing in this repo)
cat >> target/linux/mediatek/filogic/config-6.12 <<'EOF'
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NFT_QUEUE=y
EOF
echo "diy-part1: BTF lines appended = $(grep -c DEBUG_INFO_BTF target/linux/mediatek/filogic/config-6.12)"
echo "diy-part1: NFQUEUE lines appended = $(grep -cE 'NETFILTER_NETLINK_QUEUE|NFT_QUEUE' target/linux/mediatek/filogic/config-6.12)"
