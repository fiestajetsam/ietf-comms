This repository creates a Docker image which contains a bunch of tools I use to:
* Participate on mailing list discussions, sending/receiving email
* Having an offline archive of mailing lists to refer to
* Having an offline archive of RFCs and Internet drafts

This tooling is not for authoring documents, my other set ([ietf-tools]()) has
the weapons necessary for writing and publishing internet drafts. Whilst this is
being made available publicly, the direction of this is determined by scratching
my own itch first and things may break or change abruptly.

The various commands you can run can be found with `make help`.

## Setting up

Images are not published to Docker Hub, so have to be built locally:

```bash
git clone https://github.com/fiestajetsam/ietf-comms.git && cd ietf-comms;
make build;
```

## Configuration
Configuration lives in `etc/` and contains: 
* `archive.conf` - A newline delineated list of mailing list names to read

## Folder/File layout

* `archive` - Mailing list archive
* `bin/` - Executables that perform various tasks
* `etc/` - Various configuration
* `id` - Internet Drafts, warning this folder gets large and usual tools like
  `ls` will reach limits and cease to work as the directly is largely flat.
* `rfc` - Published RFCs. This folder too can get pretty big.
* `mail` - Local copy of email.

# TODO
* Add support for CLI Jabber/Zulip/etc client in future
* Have a command-line app for viewing/searching offline 
* Remove rsync noise caused by symlink issues (preserving links and acls is unnecessary)
