## Role | duplicity-ansible

Ansible role to deploy duplicity backups using ansible.

## Variables

* `backup_destination`

Destination for backups. Currently I have only tested `file://` backend but technically other backends are supported as well.
There just isn't automated deployment for additional things that other backends might need (ssh keys for example).

```yaml
backup_destination: "file:///srv/backups/"
```

* `backup_sources`

List of paths that should be backed up.

```yaml
backup_sources:
  - '/etc/'
```

* `gpg_encrypt` (boolean)

Enable or disable encryption.

```yaml
gpg_encrypt: false
```

* `gpg_backup_homedir`

Path to GPG homedirectory. Used only when `gpg_encrypt` is enabled. The path and keyring does not need to exist beforehand


```yaml
gpg_backup_homedir: '/root/.backup_gpg'
```

* `gpg_encrypt_key_local_path`

Local path to puclic GPG key that is used to encrypt backups. Only used when `gpg_encrypt` is enabled.

```yaml
gpg_encrypt_key_local_path: 'files/enc.key.pub'
```

## TODO

* Add support for SSH keys setup with, for example, with .ssh/config 
* Test usage of some backends that use ssh connection
