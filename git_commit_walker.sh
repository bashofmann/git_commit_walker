clean_and_checkout() {
  git reset --hard
  git clean -d -f
  git checkout $1
}
checkout_and_wait() {
  if [ -n "$1" ]; then
    clean_and_checkout "$1"
    clear
    git log -1 | cat
    read -p "Continue..." F <&2
  fi
}
cd $1
clean_and_checkout $2

show=true
if [ -n "$3" ]; then
    show=false
fi

git log --pretty=format:"%h" --reverse | while read i; do
    if [ "$i" == "$3" ]; then
        show=true;
    fi
    if $show; then
        checkout_and_wait "$i";
    fi
done
clean_and_checkout $2
cd ~
