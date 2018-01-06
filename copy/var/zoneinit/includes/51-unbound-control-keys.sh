# setup unbound-control keys
/opt/local/sbin/unbound-control-setup

# enable unbound
/usr/sbin/svcadm enable svc:/pkgsrc/unbound:default
