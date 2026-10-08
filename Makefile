SHELL := /bin/bash
DIR = ./main_dir
MALICIOUS_DIR = ./malicious_dir
INTERVAL = 10
pre-build:
	mkdir -p $(MALICIOUS_DIR)
run-antivirus: pre-build
	./antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)
run-restore: pre-build
	./restore.sh $(DIR) $(MALICIOUS_DIR)