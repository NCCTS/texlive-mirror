#!/bin/bash

script_path () {
    local scr_path=""
    local dir_path=""
    local sym_path=""
    # get (in a portable manner) the absolute path of the current script
    scr_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P) && scr_path=$scr_path/$(basename -- "$0")
    # if the path is a symlink resolve it recursively
    while [ -h $scr_path ]; do
        # 1) cd to directory of the symlink
        # 2) cd to the directory of where the symlink points
        # 3) get the pwd
        # 4) append the basename
        dir_path=$(dirname -- "$scr_path")
        sym_path=$(readlink $scr_path)
        scr_path=$(cd $dir_path && cd $(dirname -- "$sym_path") && pwd)/$(basename -- "$sym_path")
    done
    echo $scr_path
}

script_dir=$(dirname -- "$(script_path)")

cd $script_dir
mkdir -p texlive-mirror
cd texlive-mirror
# Can substitute in mirror.txt with preferred CTAN mirror
mirr=$(cat ../mirror.txt)
wget --mirror --no-parent ftp://$mirr/
mv $mirr/* ./
top_level_mirr_dir=($(echo $mirr | tr "/" "\n"))
rm -rf ${top_level_mirr_dir[0]}
cd ..
chmod -R 777 texlive-mirror
