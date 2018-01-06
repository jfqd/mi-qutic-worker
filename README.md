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
