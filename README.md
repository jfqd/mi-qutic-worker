# mi-qutic-worker

use [joyent/mibe](https://github.com/joyent/mibe) to create a provisionable image

- `nginx_ssl`: ssl certificate for nginx web interface
- `munin_admin`: admin password for munin admin interface

## installation

The following sample can be used to create a zone running a copy of the the worker image.

```
IMAGE_UUID=$(imgadm list | grep 'qutic-worker' | tail -1 | awk '{ print $1 }')
vmadm create << EOF
{
  "brand":      "joyent",
  "image_uuid": "$IMAGE_UUID",
  "alias":      "worker-server",
  "hostname":   "worker.example.com",
  "dns_domain": "example.com",
  "resolvers": [
    "80.80.80.80",
    "80.80.81.81"
  ],
  "nics": [
    {
      "interface": "net0",
      "nic_tag":   "admin",
      "ip":        "10.10.10.10",
      "gateway":   "10.10.10.1",
      "netmask":   "255.255.255.0"
    }
  ],
  "max_physical_memory": 512,
  "max_swap":            512,
  "quota":                10,
  "cpu_cap":             100,
  "customer_metadata": {
    "admin_authorized_keys": "your-long-key",
    "root_authorized_keys":  "your-long-key",
    "mail_smarthost":        "mail.example.com",
    "mail_auth_user":        "you@example.com",
    "mail_auth_pass":        "smtp-account-password",
    "mail_adminaddr":        "report@example.com",
    "munin_master_allow":    "munin-master-ip"
  }
}
EOF
```

## dns-blocklist

To use the dns-blocklist add this crontab entry:

```
30 23 * * * /opt/local/bin/dns_blocklist.sh -u -s 1,2,3,4,5,6,7,8,9,10,11,12,13,14,'https://easylist.to/easylistgermany/easylistgermany.txt','https://easylist.to/easylist/easyprivacy.txt','https://easylist.to/easylist/fanboy-social.txt','https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/win7/extra.txt','https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/win7/spy.txt','https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt','https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt','https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/MobileFilter/sections/adservers.txt','https://raw.githubusercontent.com/AdguardTeam/AdguardFilters/master/MobileFilter/sections/spyware.txt' -b /opt/local/etc/unbound/local.d/blocklist.conf -r 0.0.0.0
```

