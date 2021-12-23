# unbound config
mkdir -p /opt/local/etc/unbound/local.d
mkdir -p /opt/local/etc/unbound/conf.d
touch /opt/local/etc/unbound/conf.d/root.hints
touch /opt/local/etc/unbound/conf.d/unbound.log
chown -R unbound:unbound /opt/local/etc/unbound/conf.d
ln -nfs /opt/local/etc/unbound/conf.d/unbound.log /var/log/unbound_log

wget ftp://ftp.internic.net/domain/named.cache -O /opt/local/etc/unbound/root.hints || true
chown unbound:unbound /opt/local/etc/unbound/root.hints || true

/opt/local/sbin/unbound-anchor 1>/dev/null 2>&1 || true

# setup unbound-control keys
echo "* executing unbound-control-setup"
/opt/local/sbin/unbound-control-setup 1>/dev/null 2>&1 || true

# enable unbound
/usr/sbin/svcadm enable svc:/pkgsrc/unbound:default
