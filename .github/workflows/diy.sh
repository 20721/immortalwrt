#!/bin/bash
# 自定义插件添加脚本

# 1. 添加OpenClash插件
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash
# 编译OpenClash依赖的po2lmo工具
cd package/luci-app-openclash/tools/po2lmo
make && sudo make install
cd ../../../../

# 2. 添加AdGuard Home插件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome

# 3. 添加frp相关插件(immortalwrt官方feeds已包含，此处无需额外添加，仅需在config中选择)

# 4. 修改默认配置(可选)
# 修改默认IP为192.168.2.1
sed -i 's/192.168.1.1/192.168.10.4/g' package/base-files/files/bin/config_generate
