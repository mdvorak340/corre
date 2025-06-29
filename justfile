# generate documentation
doc:
	[ ! -d ./dist/www/ ] && mkdir ./dist/www/ || true
	[ ! -d ./dist/www/changelog/ ] && mkdir ./dist/www/changelog/ || true
	pandoc ./README.md -so ./dist/www/index.html -d ./dist/html.yaml --embed-resources
	pandoc ./CHANGELOG.md -so ./dist/www/changelog/index.html -d ./dist/html.yaml --embed-resources
	pandoc ./README.md -so ./dist/manpage/corre.1 -d ./dist/man.yaml -t man
