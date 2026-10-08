malicious_dir:
	mkdir -p malicious_dir

run-antivirusd: malicious_dir
	./antivirusd.sh ./dir ./malicious_dir 5

restore: malicious_dir
	./restore.sh ./dir ./malicious_dir