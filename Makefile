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
	@docker run -v $(CURDIR)/archive:/archive -v $(CURDIR)/etc:/etc/ietf-comms/ fiestajetsam/ietf-comms archive_mail
