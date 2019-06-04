#!/bin/bash 

mergerBranch="buildTest"

currentBranch=`git symbolic-ref --short -q HEAD`
echo "当前分支"
echo ${currentBranch}

function parseGitDirty(){
    local git_status=$(git status 2> /dev/null | tail -n1) || $(git status 2> /dev/null | head -n 2 | tail -n1);
    # echo ${git_status}
    if [[ "$git_status" != "" ]]; then
        local git_now; # 标示
        if [[ "$git_status" =~ nothing\ to\ commit || "$git_status" =~  Your\ branch\ is\ up\-to\-date\ with ]]; then
            git_now="=";
        elif [[ "$git_status" =~ nothing\ added\ to\ commit || "$git_status" =~  Your\ branch\ is\ up\-to\-date\ with ]]; then
            git_now='-';
        elif [[ "$git_status" =~ Changes\ not\ staged || "$git_status" =~ no\ changes\ added ]]; then
            git_now='~';
        elif [[ "$git_status" =~ Changes\ to\ be\ committed ]]; then #Changes to be committed
            git_now='*';
        elif [[ "$git_status" =~ Untracked\ files ]]; then
            git_now="+";
        elif [[ "$git_status" =~ Your\ branch\ is\ ahead ]]; then
            git_now="#";
        fi
        echo "${git_now}";
    fi
}
# currentStatus=$(parseGitDirty)
# if [ "$currentStatus" = "~" ] 
# then
#     echo "hellow"
# fi
# echo $(parseGitDirty)

git checkout ${mergerBranch}
git pull origin ${mergerBranch} 
git pull origin ${currentBranch}
git push origin ${mergerBranch}
git checkout ${currentBranch}

echo "完成"

