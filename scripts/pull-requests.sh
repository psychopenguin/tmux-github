#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/helpers.sh

icon="#[fg=colour208] #[default]"
assignee=$(hub api user|jq -r .login)
issues=$(cat <<EOF | hub api graphql -F query=@- | jq -r .data.search.issueCount
{search(first:50,
    type: ISSUE,
    query:"is:pr is:open review-requested:$assignee archived:false"){
  issueCount
}}
EOF
)

if [ $issues -gt 0 ] ; then
    echo -n $icon
else
    echo -n ''
fi
