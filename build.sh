#!/bin/bash 

currentBranch=`git symbolic-ref --short -q HEAD`

echo ${currentBranch}

`git checkout branch2 && git pull origin branch2 && git pull origin branch1 && git push origin branch2`

echo "完成"

# `git che`
function parseGitDirty(){
    local git_status=$(git status 2> /dev/null | tail -n1) || $(git status 2> /dev/null | head -n 2 | tail -n1);
    echo ${git_status}
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



