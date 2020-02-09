#!/bin/bash
# author: iyzyi
# use:  aria2文件下载完成后将文件移动至某处。
#
# 修改本脚本中的MoveTO为目标文件夹，AriaDownload为aria2下载文件路径，注意末尾不要有"/".
# 最后给本脚本添加执行权限：chmod +x ***.sh
# 在aria2的配置文件aria2.conf中，将on-download-complete设置为本脚本的绝对路径，并重启aria2.

MoveTo="/www/wwwroot/file/done";
AriaDownload="/www/wwwroot/file/doing";

if [ ! -e "$MoveTo" ]; then
    `mkdir "$MoveTo"`;
fi

if [ ! $# -eq 3 ]; then
    echo "参数应为3个！"
    exit 0;
fi

GID="$1";
FileNum="$2";
FilePath="$3";
# FileName: Aria2传递给脚本的文件路径。BT下载有多个文件时该值为文件夹内第一个文件，如/www/wwwroot/file/doing/a/b/1.mp4

if [ $FileNum -le 0 ]; then
    echo "文件数量应大于0!（当然通过磁力链接下载的种子文件，显示的数量为0）"
    exit 0;
fi

# FilePath删除AriaDownload和紧跟其后的"/"，提取没有根目录的相对位置
RelativePath=${FilePath#${AriaDownload}/} 
# 从右边开始的最后一个"/"以右的字符串全部删除，提取相对位置中的最顶层的文件夹名称（如果下载的是单文件的话，提取的是文件名）
TopRelative=${RelativePath%%/*}
# 拼接下载的根目录和相对位置中的最顶层的文件夹名称（如果下载的是单文件的话，拼接的是下载的根目录和下载文件名），总之，得到了原文件（夹）的路径
MoveFrom=${AriaDownload}/${TopRelative}

echo `data`
echo -e "\nFileNum: ${FileNum}\nFilePath: ${FilePath}\nMoveFrom: ${MoveFrom}\n\n\n" >> "/root/sh/aria2_mv.log";
`mv "$MoveFrom" "$MoveTo"`