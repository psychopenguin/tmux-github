#!/usr/bin/env bash
#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

interporlation_string="\#{github_status}"
source $CURRENT_DIR/scripts/helpers.sh

do_interpolation() {
    local option_value="$1"
    local pr="#($CURRENT_DIR/scripts/pull-requests)"
    local interpolated="${option_value/$interporlation_string/$pr}"
    echo $interpolated
}
update_tmux_option() {
    local option="$1"
    local option_value="$(get_tmux_option "$option")"
    local new_option_value=$(do_interpolation "$option_value")
    set_tmux_option "$option" "$new_option_value"
}

update_tmux_option "status-right"
update_tmux_option "status-left"
