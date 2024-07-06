#!/bin/bash

# カレントディレクトリ配下のすべてのディレクトリを再帰的に検索
find . -type d -name ".git" | while read gitdir; do
	# .gitディレクトリの親ディレクトリを取得
	repo=$(dirname "$gitdir")
	cd "$repo"

	# フラグの初期化
	uncommitted_changes="No"
	unpushed_changes="No"
	no_remote_repo="No"

	# 未コミットの変更を確認
	if [[ -n $(git status --porcelain) ]]; then
		uncommitted_changes="Yes"
	fi

	# 未プッシュの変更を確認
	if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
		if [[ -n $(git cherry -v) ]]; then
			unpushed_changes="Yes"
		fi
	else
		no_remote_repo="Yes"
	fi

	# 条件に合う場合のみ表示
	if [[ $uncommitted_changes == "Yes" || $unpushed_changes == "Yes" || $no_remote_repo == "Yes" ]]; then
		echo "Repository: $repo"
		echo "  Uncommitted changes: $uncommitted_changes"
		echo "  Unpushed changes: $unpushed_changes"
		echo "  NoRemoteRepository: $no_remote_repo"
		echo ""
	fi

	# 元のディレクトリに戻る
	cd - >/dev/null
done
