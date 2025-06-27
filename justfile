# generate documentation
doc:
	pandoc ./README.md -so ./doc/nacre.html -d ./doc/html.yaml --embed-resources
	pandoc ./README.md -so ./doc/nacre.1 -d ./doc/man.yaml -t man
