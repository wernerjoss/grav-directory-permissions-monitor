# Grav Directory Permissions Monitor

## please note that this Fork is no longer supported an will be archived soon, as I have given up on Grav development since my switch to [Hugo](https://gohugo.io) in 2024.

## Author
Eric Stauffer  
[Website](https://www.ericjstauffer.com)

## Table of Contents

- [Overview](#overview)
- [WARNING](#warning)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Scripts](#scripts)
- [Logging](#logging)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Grav Directory Permissions Monitor is a Python-based utility tool that helps maintain consistency in folder and file ownership and permissions for Grav CMS websites. When working locally on a Grav CMS website, it's common to encounter issues with folder/file permissions or ownership, especially when using an IDE or the Admin Plugin that might modify them.

The project consists of two main components:
1. `main.py`: The Python script that scans the designated directory at regular intervals, logging changes in permissions or ownership.
2. `perms-script.sh`: A Bash script that resets the permissions and ownership for all the files and folders within the target directory.

## WARNING

This script manipulates file/folder ownership and permissions. The default setup utilizes `sudo` in the bash script. 

**It is intended for development use only.**

## Prerequisites

- Python 3.x
- Linux environment with shell access
- docker.io, docker-compose (optional)

## Installation

1. Clone the GitHub repository to your local machine.
    ```bash
    git clone https://github.com/trezcan/grav-directory-permissions-monitor.git
    ```
2. Navigate to the directory and install any dependencies if necessary.

## Usage

1. Modify the `monitor_dir` and `excluded_dirs` variables in `main.py` to specify which directory you'd like to monitor and any subdirectories you'd like to exclude from the monitoring.
2. Customize `perms-script.sh` to set your desired web directory, file owner, file group, directory permissions, and file permissions.
3. Run `main.py`.
    ```bash
    python3 main.py
    ```

## Configuration

- `monitor_dir`: The root directory to monitor (e.g., `/var/www/DOMAIN-DIRECTORY/`).
- `excluded_dirs`: List of directory names to exclude from monitoring (e.g., `['.git', '.svn']`).
- `scan_interval`: Time interval in seconds between directory scans (default is 30).
- `print_scan_time`: Whether to print the time taken for each scan (default is True). 

**Note -** Keeping `print_scan_time` set to `True` is recommended when first setting up on a new directory. It was originally added to monitor the scanning loop, and ensure it was not getting hung up on large directories. Feel free to toggle it to `False` and restart the script.

## Scripts

- `perms-script.sh`: Customize this script to suit the permissions and ownership requirements of your web directory. The script utilizes `chmod` and `chown` to reset the permissions and ownership.

If the script will not run without your user password, you can remove the password requirement for `sudo`. **(Remember: Development Use Only):**


```bash
sudo nano /etc/sudoers
```

Add to the end of the file:

```bash
YOUR_USERNAME_HERE ALL=(ALL:ALL) NOPASSWD: ALL
```
## Docker
This Fork comes with additional Files so the permissions monitor can be run directly inside a docker-container automatically after startup.  
For this to work, do the following:
* install docker.io, docker-compose
* navigate to the clone directory
* build the docker image with ```docker build -t grav:perms .```
* start the image with ```docker-compose up -d```
* point your browser to http://localhost/admin - create admin user from there upon first login, then proceed as usual
* if unsure what is going on, log into the docker image with ```docker exec -it playground bash```, check console output, log File, processes etc.

## Logging

Logs of changes are saved in a `./logs/changes.log` file. You can use this log file to track changes over time.

## Contributing

Feel free to open an issue or submit a pull request if you find a bug or have a feature to suggest.

## License

This project is open-source and available under the MIT License.
