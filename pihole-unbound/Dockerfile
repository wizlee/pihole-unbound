ARG PIHOLE_VERSION
FROM pihole/pihole:${PIHOLE_VERSION:-latest}
RUN apt update && apt install -y unbound

COPY pihole-FTL.conf /etc/pihole/pihole-FTL.conf
COPY lighttpd-external.conf /etc/lighttpd/external.conf
COPY unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY 99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY unbound-run /etc/services.d/unbound/run

RUN mkdir -p /var/log/unbound
RUN touch /var/log/unbound/unbound.log && chmod 777 /var/log/unbound/unbound.log

# https://superuser.com/questions/1658235/unbound-with-pihole-where-is-root-hints
# specifying /usr/share/dns/ to contain root.keys and root.hints don't work. Copying here instead
RUN cp /usr/share/dns/root.key /var/lib/unbound/root.key && cp /usr/share/dns/root.hints /var/lib/unbound/root.hints

# whitelist not working
# RUN apt install -y python3
# RUN git clone https://github.com/anudeepND/whitelist.git
# RUN python3 whitelist/scripts/whitelist.py

ENTRYPOINT ["./s6-init"]
# CMD ["/bin/bash", "-c", "./s6-init"]
