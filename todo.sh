#!/ usr/bin/env bash
TASKS_FILE="tasks.csv"
get_next_id() {
    if [[ ! -s "$TASKS_FILE" ]]; then
        echo 1
    else
        awk -F',' 'BEGIN {max=0} {if ($1 > max) max=$1} END {print max+1}' "$TASKS_FILE"
    fi
}
show_help() {
    echo "Usage: ./todo.sh <command> [arguments]"
    echo ""
    echo "Commands:"
    echo "  add TITLE    Add a new task"
    echo "  list         List all pending tasks"
    echo "  done ID      Mark a task as completed"
    echo "  delete ID    Delete a task permanently"
    echo "  help         Display this help message"
}

add_task() {
    local title="$1"
    if [[ -z "$title" ]]; then
        echo "Error: Task title cannot be empty."
        echo "Usage: ./todo.sh add \"TITLE\""
        exit 1
    fi

    local id=$(get_next_id)
    echo "$id,todo,$title" >> "$TASKS_FILE"
    echo "Added task $id"
}

list_tasks() {
    if [[ ! -s "$TASKS_FILE" ]] || ! grep -q ",todo," "$TASKS_FILE"; then
        echo "No pending tasks found."
        exit 0
    fi

    echo "ID  STATUS  TITLE"
    awk -F',' '$2 == "todo" { printf "%-4s%-8s%s\n", $1, $2, $3 }' "$TASKS_FILE"
}

done_task() {
    local target_id="$1"
    if [[ -z "$target_id" ]]; then
        echo "Error: Please specify a task ID."
        echo "Usage: ./todo.sh done ID"
        exit 1
    fi

    if grep -q "^${target_id}," "$TASKS_FILE"; then
        awk -F',' -v id="$target_id" 'BEGIN {OFS=","} $1 == id {$2="done"} {print}' "$TASKS_FILE" > "${TASKS_FILE}.tmp" && mv "${TASKS_FILE}.tmp" "$TASKS_FILE"
        echo "Task $target_id done."
    else
        echo "Error: Task ID $target_id not found."
    fi
}

delete_task() {
    local target_id="$1"
    if [[ -z "$target_id" ]]; then
        echo "Error: Please specify a task ID."
        echo "Usage: ./todo.sh delete ID"
        exit 1
    fi

    if grep -q "^${target_id}," "$TASKS_FILE"; then
        awk -F',' -v id="$target_id" '$1 != id {print}' "$TASKS_FILE" > "${TASKS_FILE}.tmp" && mv "${TASKS_FILE}.tmp" "$TASKS_FILE"
        echo "Deleted task $target_id."
    else
        echo "Error: Task ID $target_id not found."
    fi
}
case "$1" in
    add)
        shift
        add_task "$1"
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