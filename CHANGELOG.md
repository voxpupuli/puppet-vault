# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.1.0](https://github.com/voxpupuli/puppet-vault/tree/v4.1.0) (2023-11-19)

[Full Changelog](https://github.com/voxpupuli/puppet-vault/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- puppet/systemd: Allow 6.x [\#43](https://github.com/voxpupuli/puppet-vault/pull/43) ([bastelfreak](https://github.com/bastelfreak))
- Add Debian 12 support [\#42](https://github.com/voxpupuli/puppet-vault/pull/42) ([bastelfreak](https://github.com/bastelfreak))

## [v4.0.0](https://github.com/voxpupuli/puppet-vault/tree/v4.0.0) (2023-08-21)

[Full Changelog](https://github.com/voxpupuli/puppet-vault/compare/v3.0.0...v4.0.0)

**Breaking changes:**

- Drop Puppet 6 support [\#30](https://github.com/voxpupuli/puppet-vault/pull/30) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add EL8/9 & Rocky/AlmaLinux/OracleLinux support [\#40](https://github.com/voxpupuli/puppet-vault/pull/40) ([bastelfreak](https://github.com/bastelfreak))
- stm/file\_capability: Allow 6.x [\#39](https://github.com/voxpupuli/puppet-vault/pull/39) ([bastelfreak](https://github.com/bastelfreak))
- puppet/systemd: Allow 5.x [\#38](https://github.com/voxpupuli/puppet-vault/pull/38) ([bastelfreak](https://github.com/bastelfreak))
- puppet/hashi\_stack: Allow 3.x [\#37](https://github.com/voxpupuli/puppet-vault/pull/37) ([bastelfreak](https://github.com/bastelfreak))
- puppet/archive: Allow 7.x [\#36](https://github.com/voxpupuli/puppet-vault/pull/36) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#35](https://github.com/voxpupuli/puppet-vault/pull/35) ([bastelfreak](https://github.com/bastelfreak))
- Add Puppet 8 support [\#34](https://github.com/voxpupuli/puppet-vault/pull/34) ([bastelfreak](https://github.com/bastelfreak))

## [v3.0.0](https://github.com/voxpupuli/puppet-vault/tree/v3.0.0) (2023-02-24)

[Full Changelog](https://github.com/voxpupuli/puppet-vault/compare/v2.3.0...v3.0.0)

**Breaking changes:**

- Update version from 1.4.2-\>1.12.0 [\#14](https://github.com/voxpupuli/puppet-vault/pull/14) ([bastelfreak](https://github.com/bastelfreak))
- Default to /etc/vault.d/ for upstream packages [\#13](https://github.com/voxpupuli/puppet-vault/pull/13) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Debian 8/9 support, add 10/11 [\#6](https://github.com/voxpupuli/puppet-vault/pull/6) ([bastelfreak](https://github.com/bastelfreak))
- Drop CentOS 6 support [\#4](https://github.com/voxpupuli/puppet-vault/pull/4) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Ubuntu 14/16 support [\#3](https://github.com/voxpupuli/puppet-vault/pull/3) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Puppet 4/5 support, Add 7 [\#2](https://github.com/voxpupuli/puppet-vault/pull/2) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- bump puppet/systemd to \< 5.0.0 [\#23](https://github.com/voxpupuli/puppet-vault/pull/23) ([jhoblitt](https://github.com/jhoblitt))
- Rely on default data in acceptance tests [\#17](https://github.com/voxpupuli/puppet-vault/pull/17) ([bastelfreak](https://github.com/bastelfreak))
- Add CI job for package based installation [\#11](https://github.com/voxpupuli/puppet-vault/pull/11) ([bastelfreak](https://github.com/bastelfreak))
- Move static data from params.pp to init.pp [\#9](https://github.com/voxpupuli/puppet-vault/pull/9) ([bastelfreak](https://github.com/bastelfreak))
- Implement puppet-strings documentation [\#8](https://github.com/voxpupuli/puppet-vault/pull/8) ([bastelfreak](https://github.com/bastelfreak))
- Allow latest module versions [\#5](https://github.com/voxpupuli/puppet-vault/pull/5) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Fix Typo in $listener data [\#16](https://github.com/voxpupuli/puppet-vault/pull/16) ([bastelfreak](https://github.com/bastelfreak))
- Dont create vault config dir for package based installations [\#12](https://github.com/voxpupuli/puppet-vault/pull/12) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- README.md: fix wrong camptocamp references [\#15](https://github.com/voxpupuli/puppet-vault/pull/15) ([bastelfreak](https://github.com/bastelfreak))
- Enforce documentation for new parameters [\#10](https://github.com/voxpupuli/puppet-vault/pull/10) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 5.3.0 [\#1](https://github.com/voxpupuli/puppet-vault/pull/1) ([bastelfreak](https://github.com/bastelfreak))

## [v2.3.0](https://github.com/voxpupuli/puppet-vault/tree/v2.3.0) (2020-05-26)
- Add `manage_config_file` option
- Update stm/file_capability dependency
- Update to vault 1.4.2

## 2020-02-01 2.2.0
- Add support for `api_addr` stanza
- Update to vault 1.3.2

## 2019-08-19 2.1.0
- Add support for `seal` stanza
- Remove duplicate TimeoutStopSec in systemd unit file
- Update to vault 1.2.2

## 2019-06-01 2.0.1
- Allow puppetlabs/stdlib 6.x
- Allow stm/file_capability 2.x
- Allow puppet/archive 4.x

## 2019-03-17 2.0.0
- Drop Puppet 3 support
- Add Puppet 6 support
- Allow specifying `$listener` as an array of listener hashes
- Add `config_mode` parameter
- Update systemd unit file
- Support Ubuntu 18.04
- Support enabling Web UI
- Update to vault 1.0.3
- Use stm/file_capability to manage file capabilities
- Use camptocamp/systemd to manage systemd unit file

## 2017-10-16 1.2.8
- Update to vault 0.8.3

## 2017-08-18 1.2.7
- Update to vault 0.8.1

## 2017-08-10 1.2.6
- Update to vault 0.8.0

## 2017-07-15 1.2.5
- Added `manage_service_file` option

## 2017-07-10 1.2.4
- Fix and update beaker tests
- Update to vault 0.7.3

## 2017-05-09 1.2.3
- Update to vault 0.7.2

## 2017-05-08 1.2.2
- Update to vault 0.7.1

## 2017-04-22 1.2.1
- Update to rspec 3.5
- Ruby 2.4 Fixnum deprecation
- Correctly set config dir owner and group as vault user

## 2017-03-27 v1.2.0
- Support Debian 7 and 8
- Update to vault 0.7.0

## 2017-03-13 v1.1.9
- Make download URL configuration more fine-grained
- Support upgrading when `version` changes and installing via `archive` method

## 2017-02-13 v1.1.8
- Test with Puppet 4.9 by default
- Test with bleeding edge Puppet 4
- Allow legacy Puppet 3 builds to fail in CI
- Add `manage_service` option

## 2017-02-09 v1.1.7
- Update to vault 0.6.5

## 2017-01-21 v1.1.6
- Fix regression in vault_sorted_json

## 2017-01-10 v1.1.5
- Update to vault 0.6.4

## 2016-12-07 v1.1.4
- Update to vault 0.6.3

## 2016-11-04 v1.1.3
- Fix `cap_ipc_lock` for Debian/Ubuntu
- Bump Puppet and Ruby versions used in CI

## 2016-11-03 v1.1.2
- Better code to ensure `cap_ipc_lock` is set

## 2016-10-10 v1.1.1
- Documentation fixes

## 2016-10-07 v1.1.0
- Update to vault 0.6.2
- Add `manage_backend_dir` option

## 2016-09-29 v1.0.0
- Replaced `config_hash` parameter for more fine grained controls
- Replaced nanliu/staging for puppet/archive
- Allow for package-based install method
- Generate pretty JSON configs

## 2016-08-27 v0.4.0
- Update to vault 0.6.1
- Add Amazon OS support

## 2016-07-19 v0.3.0
- Ensure config.json has correct user/group

## 2016-06-01 v0.2.3
- Configure log file for upstart
- Update to vault 0.6.0
- Deploy to PuppetForge via TravisCI

## 2016-06-01 v0.2.2
- Update to vault 0.5.3

## 2016-03-17 v0.2.1
- Update to vault 0.5.2

## 2016-03-17 v0.2.0
- Add RedHat7/CentOS7 support (including `systemd` support)
- Add `num_procs` option to control `GOMAXPROCS` in init scripts
- RedHat6 SysV init script improvements
- Improved beaker acceptance tests

## 2016-03-15 v0.1.9
- Update to vault 0.5.1
- Add `manage_user` and `manage_group` params

## 2016-02-11 v0.1.8
- Update to vault 0.5.0

## 2016-01-14 v0.1.7
- Update to vault 0.4.1

## 2016-01-05 v0.1.6
- Update to vault 0.4.0

## 2016-01-05 v0.1.5
- Add CentOS 6 support

## 2015-10-14 v0.1.4
- Fixes syntax error in bad release v0.1.3

## 2015-10-14 v0.1.3
- Use new Fastly CDN for default `download_url` parameter

## 2015-10-14 v0.1.2
- Support specifying `service_provider`

## 2015-10-06 v0.1.1
- Fixed issue #1, containment bug

## 2015-07-28 v0.1.0
- Initial relase
- Add support exclusively for Ubuntu 14.04


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
