function jcs
    jira issue create -tStory (jira issue ls -tEpic --plain --columns key,summary | fzf | awk '{print $1}')
end

function jct
    jira issue create -tTask (jira issue ls -tEpic --plain --columns key,summary | fzf | awk '{print $1}')
end

abbr -a jc 'jira issue create -tTask'


function j_active_sprint_id
    jira sprint list --table --plain --columns ID --no-headers --state active
end

abbr -a jsa 'jira sprint add (j_active_sprint_id) '

set -l jsel_str ' --no-truncate --plain --no-headers --columns key,summary | fzf | awk \'{print $1}\''
abbr -a jsel --position anywhere $jsel_str

set -l jls_str 'jira sprint list --current -a(jira me) \
-s~Done \
--order-by "status ASC,priority"'
abbr -a jls $jls_str
abbr -a jlss "$jls_str$jsel_str"
abbr -a je "jira issue edit ($jls_str$jsel_str)"
abbr -a jp "$jls_str -s'In Progress'"
abbr -a jtodo "$jls_str -s'To Do'"

# ref: https://github.com/ankitpokhrel/jira-cli/discussions/227
set -l jb_str 'jira issue list -s~Done -q "sprint is empty and issuetype not in (Epic, Sub-task)" --order-by rank --reverse'
abbr -a jb $jb_str
abbr -a jbs "$jb_str$jsel_str"
abbr -a jbe "jira issue edit ($jb_str$jsel_str)"

function jira_v1_post
      curl -sSf "$(yq .server < $HOME/.config/.jira/.config.yml)/rest/agile/1.0$argv[1]" \
      -u "$(yq .login < $HOME/.config/.jira/.config.yml):$JIRA_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -d $argv[2]
end

function j2b
  jira_v1_post "/backlog/issue" (jq -nc '{"issues": $ARGS.positional}' --args $argv)
end

