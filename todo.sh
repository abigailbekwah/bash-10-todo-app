#!/usr/bin/env bash
TASKS_FILE="tasks.csv"
init_storage() {
    if [[ ! -f "$TASKS_FILE" ]]; then
        touch "$TASKS_FILE"
    fi
}
get_next_id() {
    if [[ ! -s "$TASKS_FILE" ]]; then
        echo 1
    else
        awk -F'|' 'BEGIN {max=0} {if ($1 > max) max=$1} END {print max+1}' "$TASKS_FILE"
    fi
}
show_help() {
    echo "Usage: ./todo.sh <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  add TITLE    Add a new task"
    echo "  add [-p priority] TITLE    Add a new task (priority: low|medium|high | default: medium)"
    echo "  list         List all pending tasks"
    echo "  done ID      Mark a task as completed"
    echo "  delete ID    Delete a task permanently"
    echo "  help         Display this help message"

}


    # if [[ -z "$title" ]]; then
    #     echo "Error: Task title is required."
    #     echo "Usage: ./todo.sh add [-p priority] TITLE"
    #     exit 1
    # fi

    cmd_add() {
    local priority="medium" opt OPTIND=1

    while getopts ":p:" opt; do
        case "$opt" in
            p)
                priority="$OPTARG"
                ;;
            \?)
                echo "Error: Invalid option: -$OPTARG" >&2
                exit 1
                ;;
            :)
                echo "Error: -$OPTARG needs a value" >&2
                exit 1
                ;;
        esac
    done
        case "$priority" in
        low|medium|high)
            ;;
        *)
            echo "Error: Invalid priority '$priority'. Use low, medium, or high." >&2
            exit 1
            ;;
        esac

    shift $((OPTIND - 1))
   

    local title="$*"

    if [[ -z "$title" ]]; then
        echo "Error: Task title is required." >&2
        echo "Usage: ./todo.sh add [-p priority] TITLE" >&2
        exit 1
    fi

    if [[ "$title" == *"|"* ]]; then
       echo "Error: Task title cannot contain '|'" >&2
       exit 1
    fi
    local id
    id=$(get_next_id)

    echo "$id|todo|$priority|$title" >> "$TASKS_FILE"
    echo "Added task $id [$priority]"
}

list_tasks() {
    if [[ ! -s "$TASKS_FILE" ]] || ! grep -q "|todo|" "$TASKS_FILE"; then
        echo "No pending tasks found."
        exit 0
    fi

    echo "ID  STATUS  TITLE"

    awk -F'|' -v OFS='|' '$2 == "todo" {
    p = ($3 == "high") ? 1 : ($3 == "medium") ? 2 : 3
    print p, $0
    }' "$TASKS_FILE" |
    sort -t'|' -k1,1n |
    cut -d'|' -f2- |
    awk -F'|' '{ printf "%-4s%-8s%s\n", $1, $2, $4 }'
}

done_task() {
    local target_id="$1"
    if [[ -z "$target_id" ]]; then
        echo "Error: Please specify a task ID."
        echo "Usage: ./todo.sh done ID"
        exit 1
    fi

    if grep -q "^${target_id}|" "$TASKS_FILE"; then
        awk -F'|' -v id="$target_id" 'BEGIN {OFS="|"} $1 == id {$2="done"} {print}' "$TASKS_FILE" > "${TASKS_FILE}.tmp" && mv "${TASKS_FILE}.tmp" "$TASKS_FILE"
        echo "Task $target_id done."
    else
        echo "Error: Unknown ID '$target_id'." >&2
    fi
}

delete_task() {
    local target_id="$1"
    if [[ -z "$target_id" ]]; then
        echo "Error: Please specify a task ID."
        echo "Usage: ./todo.sh delete ID"
        exit 1
    fi

    if grep -q "^${target_id}|" "$TASKS_FILE"; then
        awk -F'|' -v id="$target_id" '$1 != id {print}' "$TASKS_FILE" > "${TASKS_FILE}.tmp" && mv "${TASKS_FILE}.tmp" "$TASKS_FILE"
        echo "Deleted task $target_id."
    else
        echo "Error: Unknown ID '$target_id'." >&2
    fi
}
case "$1" in
    "")
        list_tasks
        ;;
    add)
        shift
        cmd_add "$@"
        ;;
    list)
        list_tasks
        ;;
    done)
        shift
        done_task "$1"
        ;;
    delete)
        shift
        delete_task "$1"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        show_help
        exit 1
        ;;
esac