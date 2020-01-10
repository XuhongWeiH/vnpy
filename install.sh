#!/usr/bin/env bash

python=$1
prefix=$2
shift 2

[[ -z $python ]] && python=python
[[ -z $prefix ]] && prefix=/usr

$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip setuptools wheel

# Get and build ta-lib
function install-ta-lib()
{
    # pushd /tmp
    # wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
    # tar -xf ta-lib-0.4.0-src.tar.gz
    cd /Users/weixuhong/Documents/vnpy/ta-lib
    ./configure --prefix=$prefix
    make -j
    make install
    popd
}
function ta-lib-exists()
{
    ta-lib-config --libs > /dev/null
}
ta-lib-exists || install-ta-lib

# old versions of ta-lib imports numpy in setup.py
$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy

# Install extra packages
$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple ta-lib
$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple https://vnpy-pip.oss-cn-shanghai.aliyuncs.com/colletion/ibapi-9.75.1-py3-none-any.whl

# Install Python Modules
$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

# Install local Chinese language environment
locale-gen zh_CN.GB18030

# Install vn.py
$python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple . $@