# About this fork

- 本fork使用[p3terx的GIthub Action脚本](https://github.com/P3TERX/Actions-OpenWrt)，编译[chasey-dev的immortalwrt-mt7981-rebase分支](https://github.com/chasey-dev/immortalwrt-mt798x-rebase)。用于jcg q30 pro，仅使用默认配置，不添加任何软件。

## 如何区分是否能直接刷该固件？
- 通过ssh连接进路由器 执行
  ```bash
  cat /proc/partitions
  ```
- 查看mtdblock4分区大小
- 如果是114688k 免更新uboot 直接刷入
- 如果是113152k或其他 必须刷入下方推荐的uboot或编译出来的uboot（仅TFTP无web） 在uboot刷写sysupgrade
- 其他其他uboot都测过起不了
- 推荐uboot(已亲测): [1715173329大佬的uboot](https://drive.wrt.moe/uboot/mediatek) 下载mt7981-jcg_q30-fip-fit.bin
- 用uboot启动 上传 sysupgrade 固件 并刷写即可

## 怎么下载编译好的？

编译完成后会**自动发布 Release**（附件含固件与可选 kmod，长期有效），同时保留 Actions Artifact。

**方式一：Release（推荐）**
- 打开 `Releases`，下载最新的 `build-<日期>-<编号>`
- 正常刷写：`immortalwrt-mediatek-filogic-jcg_q30-pro-squashfs-sysupgrade.itb`
- 救砖用：`immortalwrt-mediatek-filogic-jcg_q30-pro-initramfs-recovery.itb`
- 校验：下载 `sha256sums` 后执行 `sha256sum -c sha256sums`

**方式二：Actions Artifact（保留 90 天）**
- `Actions` → `jcg-q30 immortalwrt-mt798x Builder` → 最近一次运行 → 页面底部
- `OpenWrt_firmware<日期>`：固件目录
- `kmods<日期>`：可单独安装的 kmod（与固件同一次构建，内核版本严格匹配）

**可选 kmod 安装**
```sh
apk add --allow-untrusted ./kmod-wireguard-*.apk
```

> 注意：kmod 必须与固件来自同一次构建，否则会因内核版本不匹配而拒绝安装。

---

**English** | [中文](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

# Actions-OpenWrt

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

A template for building OpenWrt with GitHub Actions

## Usage

- Click the [Use this template](https://github.com/P3TERX/Actions-OpenWrt/generate) button to create a new repository.
- Generate `.config` files using [Lean's OpenWrt](https://github.com/coolsnowwolf/lede) source code. ( You can change it through environment variables in the workflow file. )
- Push `.config` file to the GitHub repository.
- Select `Build OpenWrt` on the Actions page.
- Click the `Run workflow` button.
- When the build is complete, click the `Artifacts` button in the upper right corner of the Actions page to download the binaries.

## Tips

- It may take a long time to create a `.config` file and build the OpenWrt firmware. Thus, before create repository to build your own firmware, you may check out if others have already built it which meet your needs by simply [search `Actions-Openwrt` in GitHub](https://github.com/search?q=Actions-openwrt).
- Add some meta info of your built firmware (such as firmware architecture and installed packages) to your repository introduction, this will save others' time.

## Credits

- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [Mattraks/delete-workflow-runs](https://github.com/Mattraks/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)

## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
