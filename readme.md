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
- Disable the use of conditional forwarding (by setting REV_SERVER=false) as it seems to generate a lot of traffic from `^.*p\.(([0-9]{1,3}\.){4})in-addr\.arpa$`
    - There are solutions from [this reddit post](https://www.reddit.com/r/pihole/comments/i9s0jx/how_to_deal_with_lb_dnssd_udp01168192inaddrarpa/), however need time to digest the info thus the quickest way is to disable conditional forwarding
    - The conditional forwarding also don't seem to archive its intended purpose of showing individual endpoint clients in pihole instead of always from the router.
- Add `pihole.local` as the value pf `PIHOLE_PTR` based on [this doc](https://docs.pi-hole.net/ftldns/configfile/#pihole_ptr).
    - Add `domain=local` in `99-edns.conf`.
    - That .conf file will be copied into `/etc/dnsmasq.d/` folder of the docker container.
    - [dnsmasq](https://www.linux.com/topic/networking/advanced-dnsmasq-tips-and-tricks/) will read all the file with `.conf`, thus that domain value is added in that file.
- Modify build script to only build pihole-unbound image
    - Using this build script to build pihole-unbound image will now use a fixed pihole version instead of latest

## Pending (Top most is the highest priority)
- Configure PiHole so that endpoint devices are shown individually in PiHole dashboard
    - Description to Bing AI
        ```
        That is good information. I am interested in keeping my router as the DHCP server. My network topology is as below, listed for your reference so that you can provide a more accurate answer.

        My PiHole is hosted in a NAS connected to my LAN router. Another device connected to my LAN router is the Wifi access point router which my house mesh wifi router is connected to. All my devices that I wished to show on the dashboard is connected to this mesh wifi router. 
        ```
    - Next to test
        - ==Important== to investigate the need to enable port 67, add `NET_ADMIN` to cap_add and set `DNSMASQ_LISTENING` to `all`
            - These are needed as of researching so far in [this github issue](https://github.com/chriscrowe/docker-pihole-unbound/issues/51), [this pihole offical docker page](https://hub.docker.com/r/pihole/pihole), and [this pihole discourse forum post](https://discourse.pi-hole.net/t/dhcp-with-docker-compose-and-bridge-networking/17038)
        - Change deco to [operate in Access Point mode](https://www.tp-link.com/us/support/faq/1842/) intead of the current Router mode. More info in this [Router VS AP mode article](https://www.tp-link.com/my/support/faq/2399/).
        - Enable DHCP server of PiHole
    - {source}
        - https://www.reddit.com/r/pihole/comments/9sty76/pihole_only_sees_router_as_client/
        - https://discourse.pi-hole.net/t/why-do-i-only-see-my-routers-ip-address-instead-of-individual-devices-in-the-top-clients-section-and-query-log/3653/1
        - https://www.tp-link.com/us/support/faq/3230/
        - [this last one](https://discourse.pi-hole.net/t/pi-hole-not-working-when-i-use-tp-link-deco-x20-dhcp-issues/60064/4) seems promising but need to prepare for no internet access
- There is a thought to use AdGuard Home instead of PiHole because of its ease of use and features.
    - Unfortunately it current lacks the ability to work as a DNS recursor. [To be revisit](https://github.com/AdguardTeam/AdGuardHome/issues/5446).
