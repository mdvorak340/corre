# generate documentation
doc:
	pandoc ./README.md -so ./doc/www/README.html -d ./doc/html.yaml --embed-resources
	pandoc ./CHANGELOG.md -so ./doc/www/CHANGELOG.html -d ./doc/html.yaml --embed-resources
	pandoc ./README.md -so ./doc/manpage/corre.1 -d ./doc/man.yaml -t man
