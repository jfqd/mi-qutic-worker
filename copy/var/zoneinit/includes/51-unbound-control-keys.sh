# unbound config
mkdir -p /opt/local/etc/unbound/local.d
touch /opt/local/etc/unbound/root.hints
touch /opt/local/etc/unbound/unbound.log
chown unbound:unbound /opt/local/etc/unbound/
chown unbound:unbound /opt/local/etc/unbound/root.hints
chown unbound:unbound /opt/local/etc/unbound/unbound.log
ln -nfs /opt/local/etc/unbound/unbound.log /var/log/unbound.log
/opt/local/sbin/unbound-anchor

# setup unbound-control keys
/opt/local/sbin/unbound-control-setup

# enable unbound
/usr/sbin/svcadm enable svc:/pkgsrc/unbound:default
