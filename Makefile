today = $(shell date "+%Y%m%d")
product_name = update_fish_completions

.PHONY : patch
patch : clean diff-patch copy2win

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(product_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : copy2win
copy2win :
	cp *.patch $$WIN_HOME/Downloads/

.PHONY : install
install :
	sudo cp ./$(product_name).sh ~/.local/bin/$(product_name)
	sudo cp ./update_bat_fish_completion.sh ~/.local/bin/update_bat_fish_completion
	sudo cp ./update_ripgrep_fish_completion.sh ~/.local/bin/update_ripgrep_fish_completion

.PHONY : clean
clean :
	rm -f fmt-*
	rm -f *.patch

.PHONY : lint
lint :
	shellcheck ./$(product_name).sh

.PHONY : test
test : lint

.PHONY : format
format :
	bash scripts/format.sh

.PHONY : fmt
fmt : format
