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
- Revert .env to enable `REV_SERVER`.
- Use specifiy docker image version in docker-compose
- Attempt to fix ['No such file or directory'](https://stackoverflow.com/questions/29535015/error-cannot-start-container-stat-bin-sh-no-such-file-or-directory) in synology default terminal by using array of string in the entrypoint commands
    - That don't work and tried the advise in [docker entrypoint doc](https://docs.docker.com/engine/reference/builder/#entrypoint). 
    - ROOT CAUSE: [line ending needs to be LF](https://stackoverflow.com/questions/55527105/how-to-fix-exec-user-process-caused-no-such-file-or-directory)
- Change all line ending to LF from CRLF.
    - this also fixes the issue of unbound not able to start properly
