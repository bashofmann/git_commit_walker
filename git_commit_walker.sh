clean_and_checkout() {
  git reset --hard
  git clean -d -f
  git checkout $1
}
checkout_and_wait() {
  if [ -n "$1" ]; then
    clean_and_checkout "$1"
    clear
    git log -1
    read -p "Continue..." <&2
  fi
}
cd $1
clean_and_checkout $2
git log --pretty=format:"%h %n" --reverse | while read i; do checkout_and_wait "$i"; done
clean_and_checkout $2
cd ~