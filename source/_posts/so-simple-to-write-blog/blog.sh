#!/usr/bin/bash

# 博客地址
export blogPath=/e/workspace/blog.plcent.com
# 文章地址
export writePath=/source/_posts/
echo "开始博客之旅: $blogPath"
echo -e "(*^▽^*)\n"

# 进入指定文件夹
cd "$blogPath"


# 输出错误信息
echoError() {
  echo "  --------------------------------"
  echo "    $1"
  echo "  --------------------------------"
}

# 输入任意键退出
pauseAnyKeyExit(){
  read -p '输入任意键退出...'
}

# 打开Typora编辑器
openTypora(){
  echo "打开Typora编辑器"
  start Typora "$blogPath$writePath"
}

# 打开新git bash窗口
openNewGitBash(){
  echo "启动新git bash"
  start gitBash --cd="$blogPath"
}

# 是否当前文章已经存在
isExitPaper() {
  # 博客目录下当前博客是否存在
  return $(-e "$blogPath$writePath$1.md")
}


# ------------------------------------------------------------

# 1. 新写一篇文章
writeNewPost() {
  clear
  read -p "写篇什么> " name

  if [[ $name = '0' ]]; then
    # 返回主选择
    main
  elif [[ -n $name ]]; then
    echo "新建文章: $name.md"
    hexo new post "$name"
    #打开编辑器
    openTypora
  else
    # 错误提示
    echoError "请输入文章名称。(退出请输入0)"
    # 重新执行
    writeNewPost
  fi
}

# 2. 继续写作
continueWrite() {
  clear
  echo "正在打开编辑器Typora"
  # 打开编辑器
  openTypora
  echo "开始书写博客吧..."
}

# 3. 发布站点
displayWebsite(){
  clear
  echo "发布站点"
  echo "1. 正在清除博客信息..."
  hexo clean
  echo "2. 正在生成博客内容..."
  hexo g
  echo "3. 正在发布博客.."
  hexo d
  
  pauseAnyKeyExit
}

# 4. 推送代码到git仓库
gitPush(){
  clear
  read -p "推送日志> " commitMsg
  if [[ -n commitMsg ]]; then
    commitDate=`date "+%Y/%m/%d"`
    commitMsg="更新博客-$commitDate"
  fi
  echo "推送代码到git仓库"
  echo $commitMsg
  git add .
  git commit -m "$commitMsg"
  git push

  pauseAnyKeyExit
}

# 5. 拉取仓库
gitPull() {
echo "拉取仓库..."

cd "$blogPath"
git pull

pauseAnyKeyExit
}



# 入口
main(){
  # 选择操作类型
  echo "你想干什么:"
  echo -e "\t1. 写一篇新文章"
  echo -e "\t2. 继续写作"
  echo -e "\t3. 发布"
  echo -e "\t4. 推送git仓库"
  echo -e "\t5. 拉取git仓库"
  echo -e "\t0. 退出"
  echo -e "> 直接回车将进入博客目录"
  echo -e "\n"
  read -p "选择> " choose

  
  #开始写作
  if [[ $choose = '1' ]]; then
    writeNewPost 
  elif [[ $choose = '2' ]]; then
    continueWrite
  elif [[ $choose = '3' ]]; then
    displayWebsite
  elif [[ $choose = '4' ]]; then
    gitPush
  elif [[ $choose = '5' ]]; then
    gitPull
  elif [[ $choose = '0' ]]; then
    exit
  elif [ -n $choose ]; then
    # 打开一个新的git bash
    openNewGitBash
  else
    echoError "选择有误，请重新选择。"
    # 继续选择
    main
  fi
}

# 开始执行
main
