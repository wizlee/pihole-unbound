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
- Leave [Apple's Private Relay block so that apple devices won't bypass pihole](https://discourse.pi-hole.net/t/new-to-pi-hole-why-is-mask-icloud-com-blocked-as-standard/59707/17)
    - When outside of home network, the private relay will be used.
- Disable the use of conditional forwarding as it seems to generate a lot of traffic from `^.*p\.(([0-9]{1,3}\.){4})in-addr\.arpa$`
    - There are solutions from [this reddit post](https://www.reddit.com/r/pihole/comments/i9s0jx/how_to_deal_with_lb_dnssd_udp01168192inaddrarpa/), however need time to digest the info thus the quickest way is to disable conditional forwarding
    - The conditional forwarding also don't seem to archive its intended purpose of showing individual endpoint clients in pihole instead of always from the router.

## Pending (Top most is the highest priority)
- Configure PiHole so that endpoint devices are shown individually in PiHole dashboard
    - Description to Bing AI
        ```
        That is good information. I am interested in keeping my router as the DHCP server. My network topology is as below, listed for your reference so that you can provide a more accurate answer.

        My PiHole is hosted in a NAS connected to my LAN router. Another device connected to my LAN router is the Wifi access point router which my house mesh wifi router is connected to. All my devices that I wished to show on the dashboard is connected to this mesh wifi router. 
        ```
    - Next to test
        - Change deco to [operate in Access Point mode](https://www.tp-link.com/us/support/faq/1842/) intead of the current Router mode. More info in this [Router VS AP mode article](https://www.tp-link.com/my/support/faq/2399/).
        - Enable DHCP server of PiHole
    - {source}
        - https://www.reddit.com/r/pihole/comments/9sty76/pihole_only_sees_router_as_client/
        - https://discourse.pi-hole.net/t/why-do-i-only-see-my-routers-ip-address-instead-of-individual-devices-in-the-top-clients-section-and-query-log/3653/1
        - https://www.tp-link.com/us/support/faq/3230/
        - [this last one](https://discourse.pi-hole.net/t/pi-hole-not-working-when-i-use-tp-link-deco-x20-dhcp-issues/60064/4) seems promising but need to prepare for no internet access