CC = hugo
PORT ?= 1313
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# 아래 변수는 doomscript 에서 사용하는 변수 인듯.
ORG_DIR := "$(HOME)/sync/org/roam"
ORG_FILES = $(shell find $(ORG_DIR) -type f -name '*.org')

s: serve
# e: export
o: export-orgs
d: deploy

serve:
	$(CC) serve --port $(PORT)

# doomscript 를 포팅 해야 사용할 수 있다.
# export: $(ORG_FILES)
#		for file in $^; do \
#			echo "Running doomscript for $${file}"; \
#			doomscript $(HOME)/.doom.d/bin/org2blog "$${file}"; \
#		done

# 테스트 필요. chamacs 라 이게 되려나!?
export-orgs:
	emacs \
		--batch \
		-l ~/.emacs.d/init.el \
		-l "$(ROOT_DIR)/org_to_hugo.el" \
		--eval "(benmezger/org-roam-export-all)"

deploy:
	./deploy.sh
