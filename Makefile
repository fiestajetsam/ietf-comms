.PHONY: help # - Generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1 \2/' | expand -t20

.PHONY: build # - Build the Docker image (run this after cloning)
build:
	@docker build -t fiestajetsam/ietf-comms .

.PHONY: id # - Fetch all Internet Drafts
id:
	@docker run -v $(CURDIR)/id:/id fiestajetsam/ietf-comms rsync -rtz rsync.tools.ietf.org::tools.id /id

.PHONY: rfc # - Fetch all RFCs
rfc:
	@docker run -v $(CURDIR)/rfc:/rfc fiestajetsam/ietf-comms rsync -rtz ftp.rfc-editor.org::rfcs-text-only /rfc
	@docker run -v $(CURDIR)/rfc:/rfc fiestajetsam/ietf-comms rsync -rtz ftp.rfc-editor.org::refs /rfc

.PHONY: archive # - Fetch mail from the mail archives
archive:
	@docker run -v $(CURDIR)/etc:/etc/ietf-comms/ -v $(CURDIR)/archive:/archive fiestajetsam/ietf-comms archive_mail

.PHONY: mail-sync # - Fetch mail
mail-sync:
	@docker run -v $(CURDIR)/etc:/etc/ietf-comms/ -v $(CURDIR)/mail:/mail fiestajetsam/ietf-comms mbsync -a -c /etc/ietf-comms/mbsyncrc

.PHONY: mail # - Open mail client
mail: mail-sync
	@docker run -e TERM=screen-256color -it -v $(CURDIR)/etc:/etc/ietf-comms/ -v $(CURDIR)/mail:/mail fiestajetsam/ietf-comms neomutt -F /etc/ietf-comms/muttrc

.PHONY:  mail-archive # - Read email archives locally
mail-archive:
	@docker run -e TERM=screen-256color -it -v $(CURDIR)/etc:/etc/ietf-comms/ -v $(CURDIR)/archive:/archive fiestajetsam/ietf-comms slrn -f etc/ietf-comms/slrnrc
