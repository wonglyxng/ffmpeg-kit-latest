#!/bin/bash

# 检查aclocal版本
function check_aclocal_version() {
    # 获取aclocal版本输出
    if command -v aclocal >/dev/null 2>&1; then
        local version_output=$(aclocal --version)
        
        # 使用正则表达式提取版本号
        if [[ $version_output =~ ([0-9]+\.[0-9]+\.[0-9]+) ]]; then
            local version_number="${BASH_REMATCH[1]}"
            echo "$version_number"
            return 0
        else
            echo "无法提取版本号"
            return 1
        fi
    else
        echo "未找到aclocal命令"
        return 2
    fi
}

function install_automake() {
    [ $# -eq 0 ] && { run_error "Usage: install_automake <version>"; exit; }
    local VERSION=${1}
    wget ftp://ftp.gnu.org/gnu/automake/automake-${VERSION}.tar.gz &> /dev/null
    if [ -f "automake-${VERSION}.tar.gz" ]; then
            tar -xzf automake-${VERSION}.tar.gz
            cd automake-${VERSION}/
            ./configure
            make && make install
            echo -e "\e[1;39m[   \e[1;32mOK\e[39m   ] automake-${VERSION} installed\e[0;39m"

        else
            echo -e "\e[1;39m[   \e[31mError\e[39m   ] cannot fetch file from ftp://ftp.gnu.org/gnu/automake/ \e[0;39m"
            exit 1
    fi
}

# 主要逻辑
REQUIRED_VERSION="1.17"
CURRENT_VERSION=$(check_aclocal_version)

echo "当前aclocal版本: $CURRENT_VERSION"
echo "需要的aclocal版本: $REQUIRED_VERSION"

# 检查是否需要安装
need_install=0
if [[ "$CURRENT_VERSION" == "$REQUIRED_VERSION"* ]]; then
    echo "当前aclocal版本已满足要求"
else
    echo "当前aclocal版本不是$REQUIRED_VERSION，需要安装"
    need_install=1
fi

# 如果还需要安装，则执行安装
if [ $need_install -eq 1 ]; then
    install_automake $REQUIRED_VERSION
fi

echo "aclocal.sh 脚本执行完成"