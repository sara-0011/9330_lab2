# 9330_lab2
1. This code contains a simplified antivirus daemon with a shell script that checks a directory for changes every certain period of time specified in a Makefile, and when a change is detected, scans the directory for files it considers malicious. Malicious files are quarantined into a separate directory, and removed from the original location. The code also includes a restore tool that lets a user pick quarantined files from a list, one at a time, and decide whether each was falsely flagged or genuinely malicious. In addition, code also whitelists falsely flagged files to make sure it is not flagged again on the next run.
Folder Hierarchy :
antivirusd.sh # Daemon that scans main_dir and flags malicious files.
restore.sh    # Menu script to retore and permenantly delete files.
Makefile      # Automation script to run files

2. On Ubuntu, first we use cat command to create antivirusd.sh , restore.sh and Makefile. Then, we use commad chmod +x to make antivirusd.sh and restore.sh executable.

3. To run the tools, we create main_dir, add files to it that will be scanned and then we use two commands make run-antivirus or make run-restore. malicious_dir is automatically created by Makefile if it doesn't already exist.

4. In antivirusd.sh inside check_file method flagged-extensions and flagged-keywords are defined inside if conditions that return 0 if found, which is caught by if condition in scan_dir method where files get moved to malicious_dir.

5. when we run restore.sh, if the user choose option one which is to restore a file. The file basename is then appended to whitelist.txt file. After that inside antivirusd.sh, inside check_file method we check first if whitelist exists and if the file name is present in it. If condition is true then check_file returns 1 which prevents the if condition in the scan_dir method from moving that file to the malicious_dir.