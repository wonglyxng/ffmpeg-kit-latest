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
            
            # 安装成功后，确保创建符号链接
            create_symlinks ${VERSION}
            
            return 0
        else
            echo -e "\e[1;39m[   \e[31mError\e[39m   ] cannot fetch file from ftp://ftp.gnu.org/gnu/automake/ \e[0;39m"
            exit 1
    fi
}

# 创建符号链接
function create_symlinks() {
    local VERSION=${1}
    
    # 创建aclocal和aclocal-VERSION的符号链接
    if [ -f /usr/local/bin/aclocal-${VERSION} ] && [ ! -f /usr/bin/aclocal-${VERSION} ]; then
        ln -sf /usr/local/bin/aclocal-${VERSION} /usr/bin/aclocal-${VERSION}
        echo "创建了从 /usr/bin/aclocal-${VERSION} 到 /usr/local/bin/aclocal-${VERSION} 的符号链接"
    fi
    
    # 如果安装在其他位置，也尝试创建符号链接
    if [ -f /usr/local/bin/aclocal ] && [ ! -f /usr/bin/aclocal-${VERSION} ]; then
        ln -sf /usr/local/bin/aclocal /usr/bin/aclocal-${VERSION}
        echo "创建了从 /usr/bin/aclocal-${VERSION} 到 /usr/local/bin/aclocal 的符号链接"
    fi
    
    # 如果还是找不到，使用当前的aclocal创建符号链接
    if [ ! -f /usr/bin/aclocal-${VERSION} ] && [ -f /usr/bin/aclocal ]; then
        ln -sf /usr/bin/aclocal /usr/bin/aclocal-${VERSION}
        echo "创建了从 /usr/bin/aclocal-${VERSION} 到 /usr/bin/aclocal 的符号链接"
    fi
}

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

# 如果需要安装，则执行安装
if [ $need_install -eq 1 ]; then
    install_automake $REQUIRED_VERSION
fi

echo "aclocal.sh 脚本执行完成"