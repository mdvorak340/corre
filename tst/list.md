# All files in this directory

There are !((ls -1 | wc -l))! file(s) in this directory:

!((
for FILE in $(ls -1)
do echo "- \`$FILE\`"
done
))!
