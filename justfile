# generate documentation
doc:
	[ ! -d ./doc/www/ ] && mkdir ./doc/www/ || true
	[ ! -d ./doc/www/changelog/ ] && mkdir ./doc/www/changelog/ || true
	pandoc ./README.md -so ./doc/www/index.html -d ./doc/html.yaml --embed-resources
	pandoc ./CHANGELOG.md -so ./doc/www/changelog/index.html -d ./doc/html.yaml --embed-resources
	pandoc ./README.md -so ./doc/manpage/corre.1 -d ./doc/man.yaml -t man
