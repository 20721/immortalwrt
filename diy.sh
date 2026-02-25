#!/bin/bash
# 自定义插件添加脚本

# 切换到仓库根目录
cd "$(dirname "$0")" || exit 1

# 查看当前目录和文件结构，用于调试
echo "当前工作目录：$(pwd)"
ls -la
find ./ -name config_generate || echo "未找到config_generate文件"

# 修改当前目录权限，避免权限问题
sudo chmod -R 755 ./

# 1. 添加OpenClash插件
echo "添加OpenClash插件..."
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash || echo "克隆OpenClash失败"
# 编译OpenClash依赖的po2lmo工具
if [ -d package/luci-app-openclash/tools/po2lmo ]; then
  cd package/luci-app-openclash/tools/po2lmo
  make && sudo make install
  cd ../../../../
else
  echo "po2lmo目录不存在"
fi

# 2. 添加AdGuard Home插件
echo "添加AdGuard Home插件..."
sudo mkdir -p package/luci-app-adguardhome
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome || echo "克隆AdGuard Home失败"

# 3. 修改默认IP为192.168.10.4
CONFIG_FILE=$(find ./ -name config_generate | head -1)
if [ -n "$CONFIG_FILE" ]; then
  echo "修改默认IP为192.168.10.4，文件路径：$CONFIG_FILE"
  sudo sed -i 's/192.168.1.1/192.168.10.4/g' "$CONFIG_FILE"
else
  echo "未找到config_generate文件，无法修改默认IP"
fi
