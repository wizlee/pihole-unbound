## Overview

Using `one-container` docker from [chriscrowe/docker-pihole-unbound](https://github.com/chriscrowe/docker-pihole-unbound)
- Copy the pihole-unbound folder to the root of workspace for any custom modification
- The whole repo is added as a submodule here for tracking

## Getting Started

In progress... To be added after all configs are working!

## Modification
- Use locally build docker image
- Override port 443 to avoid potential conflict
- Disable DNSSEC
- Add pihole-FTL.conf to include custom rate limit setting in pihole
- Enable custom unbound log and increase verbosity to 4 for debugging
- Add [anudeepND whitelist](https://github.com/anudeepND/whitelist#for-whitelisttxt) into dockerfile
- [PENDING] revert REV_SERVER changes.

