ARG PIHOLE_VERSION
FROM pihole/pihole:${PIHOLE_VERSION:-latest}
RUN apt update && apt install -y unbound

COPY pihole-FTL.conf /etc/pihole/pihole-FTL.conf
COPY lighttpd-external.conf /etc/lighttpd/external.conf
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run

RUN apt install -y python3
RUN git clone https://github.com/anudeepND/whitelist.git
RUN python3 whitelist/scripts/whitelist.py

ENTRYPOINT [./s6-init]
