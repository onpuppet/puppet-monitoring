Puppet Monitoring
=================

[![Build Status](https://travis-ci.org/onpuppet/puppet-monitoring.svg)](https://travis-ci.org/onpuppet/puppet-monitoring)

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with monitoring](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
  a) [CollectD Plugins](#collectd-plugins)
  b) [Sensu Plugins](#sensu-plugins)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

Module to install monitoring for any detected service supported

## Module Description

Detects installed services by using custom facts. This enables complete decoupling of monitoring from deployment of services.
The module provides a highly opinionated monitoring client setup, and assumes the existence of server side components being available.

With the help of [onpuppet-refacter](https://github.com/onpuppet/puppet-refacter), the services installed during the same run will cause facts refresh prior to installing monitoring tools

Decoupling monitoring module from other modules is useful in order to avoid adding monitoring code
into the modules themselves. The module will magically install monitoring of everything installed on a machine without any
hard dependencies between the module that install the service and the monitoring module.

## Setup

Install the module using:
```puppet
puppet module install onpuppet-monitoring
```

## Usage

```puppet
class { 'monitoring':
  collectd_network_server_hostname => 'influxdb',
  sensu_rabbitmq_hostname => 'sensu.server',
  sensu_rabbitmq_password => 'pass',
}
```
This will install CollectD and Sensu, and report to 'influxdb' and 'sensu.server' respectively.

 * CollectD will get installed only if collectd_network_server_hostname is set
 * Sensu will get installed only if sensu_rabbitmq_hostname is set

## Reference

### CollectD plugins

Default:
 * cpu
 * disk
 * df
 * fhcount
 * interface
 * load
 * memory
 * uptime

If present:
 * apache (if statuspage is enabled)
 * ntpd
 * rabbitmq (if management interface enabled)
 * redis

#### Apache plugin

This plugin gets metrics from the mod_status page in Apache. If using Puppetlabs-apache module, this page can be enabled like so;

```puppet
class { '::apache::mod::status':
  allow_from      => ['127.0.0.1', '::1'],
  extended_status => 'On',
}
```

#### RabbitMQ plugin

To get metrics from RabbitMQ, the management module needs to be enabled. This can be done like so;

    rabbitmq-plugins enable rabbitmq_management

CollectD will use user "guest" by default. This user is available and only available from localhost on default installations.
On a non-default installation you might get 401 permission denied errors in CollectD plugin logs. You can fix this by;

    rabbitmqctl set_user_tags guest monitoring
    rabbitmqctl -q list_vhosts | xargs -n1 rabbitmqctl set_permissions guest ".*" ".*" ".*" -p

### Sensu plugins

Default:
  * cpu
  * memory
  * disk
  * load
  * filesystem
  * process
  * network

If present:
  * centrify
  * collectd
  * elasticsearch
  * hekad
  * influxdb
  * mysql
  * postfix
  * puppet
  * rabbitmq
  * redis
  * sshd

### Custom Facts

This module relies on a set of custom facts to detect any services installed. These facts are refreshed at the end
of any ordinary Puppet run using the onpuppet-refacter module. This ensures that if another module installs any of these
services, the fact values will be updated to reflect this new state before installing monitoring plugins

#### Apache facts

Checks if Apache is installed on the system
```puppet
$::apache_present
```

Checks if apache status page with metrics is available from localhost
```puppet
$::apache_statuspage_present
```

#### Centrify facts
Checks if Centrify is installed on the system
```puppet
$::centrify_present
```

#### CollectD facts
Checks if CollectD is installed on the system
```puppet
$::collectd_present
```

#### ElasticSearch facts
Checks if ElasticSearch is installed on the system
```puppet
$::elasticsearch_present
```

#### Heka facts
Checks if Heka is installed on the system
```puppet
$::hekad_present
```

#### InfluxDB facts
Checks if InfluxDB is installed on the system
```puppet
$::influxdb_present
```

#### Mysql facts
Checks if Mysql is installed on the system
```puppet
$::mysql_present
```

#### NTPD facts

Checks if ntpd is installed on the system
```puppet
$::ntpd_present
```

#### Postfix facts
Checks if Postfix is installed on the system
```puppet
$::postfix_present
```

#### Puppet facts
Checks if Puppet is installed on the system
```puppet
$::puppet_present
```
Returns true if Puppet is running, false otherwise
```puppet
$::puppet_running
```
#### RabbitMQ facts

Checks if RabbitMQ is installed on the system
```puppet
$::rabbitmq_present
```
Retrieves RabbitMQ management port if enabled
```puppet
$::rabbitmq_management_port
```
#### Redis facts

Checks if Redis is installed on the system
```puppet
$::redis_present
```

#### SSHd facts
Checks if SSHd is installed on the system
```puppet
$::sshd_present
```
Returns true if SSHd is running, false otherwise
```puppet
$::sshd_running
```
## Limitations

If you are running through a Puppet master, and are deploying services using Puppet - monitoring will not detect this service until the next run
due to a limitation in onpuppet-refacter module. Running in a masterless setup however, will work as expected.

## Contributing

See CONTRIBUTING.md
