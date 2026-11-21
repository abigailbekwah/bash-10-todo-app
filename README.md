# bash-11-todo-app

Bash-10-todo-app is a simple command-line task management application built with Bash. It allows users to add, view, complete, and delete tasks directly from the terminal. Users can also assign priorities to tasks to help organize their work and manage their daily activitie

## Problem_Statement​

Managing daily tasks can become difficult without a simple way to organize and track them. This project was built to create a command-line todo application that helps users keep track of their tasks, identify completed tasks, and prioritize what needs to be done.

## 📌 Project Goals​

- Modular Architecture: Organize the Bash script into functions such as cmd_add(), list_tasks(), done_task(), and delete_task() to make the code easier to understand and maintain.

- Task Storage: Store tasks in a tasks.csv file using the format id|status|priority|title.

- Task Management: Allow users to add, list, complete, and delete tasks.

- Priority Management: Allow users to assign low, medium, or high priority to tasks.

- Task Sorting: Display high-priority tasks before medium- and low-priority tasks.

- Error Handling: Validate user input and display helpful error messages for invalid commands, missing task titles, invalid priorities, and unknown task IDs.

- Storage Initialization: Automatically create the tasks.csv file if it does not already exist.

## Tech stack

- Language: Bash (#!/usr/bin/env bash)

- File Storage: CSV-style text file (tasks.csv)

- Text Processing: awk, grep, and cut

- Sorting: sort

- File Management: touch, mv, and temporary files

- Version Control: Git and GitHub

- Shell Validation: ShellCheck

## screenshotlanguage: Bash (#!/usr/bin/env bash)

![alt text](<assets/images/Screenshot From 2026-11-21 12-17-14.png>)

## Features

- Add Tasks: Create new tasks with automatically generated IDs.

- List Tasks: Display all pending tasks in an organized format.

- Complete Tasks: Mark tasks as done using their IDs.

- Delete Tasks: Permanently remove tasks using their IDs.

- Task Priorities: Assign low, medium, or high priority using the -p option.

- Default Priority: Automatically assign medium priority when no priority is specified.

- Priority Sorting: Display high-priority tasks first, followed by medium and low priorities.

## installation and setup

clone the repository

```bash
git clone https://github.com/abigailbekwah/bash-11-currency-weather-cli.git
- chmod +x todo.sh
- ./todo.sh
- ./todo.sh help
- ./todo.sh "pratice Git"
- ./todo.sh add -p high "Learn Linux"
- ./todo.sh list, ./todo.sh done 1, ./todo.sh delete 1
```

## Challenges faces

Understanding how to organize a Bash script using functions and a case statement.

Learning how to store and retrieve task information from a file.

Understanding how to use awk to update and delete task records.

Implementing error handling for invalid inputs and unknown task IDs.

Learning how to use getopts to handle command-line options such as -p.

Sorting tasks according to their priority.

Identifying and correcting syntax errors while testing the application in the terminal.

## 📚 what i learnt

How to build a command-line application using Bash.

How to use functions to organize and reuse code.

How to use case statements to handle different commands.

How to read from and write to files using Bash.

How to use awk, grep, sort, and cut for text processing.

How to use temporary files when updating or deleting records.

How to validate user input and handle errors.

How to use getopts to accept command-line options.

How to sort tasks based on priority.

## Author​

Bekwah Abigail Becky

Junior bash developer

👨🏽‍💻 Email: <abigailbekwah@gmail.com>​

🌍 Based in Cameroon | Open to remote opportunities
Was able to understand the question at a point
