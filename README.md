Puppet Monitoring
=================

[![Build Status](https://travis-ci.org/Yuav/puppet-monitoring.svg)](https://travis-ci.org/yuav/puppet-monitoring)

Module to install monitoring for any detected service supported by the module

## Module Description

Deployment of monitoring tools which detect already installed services. This is useful to avoid adding monitoring code
into the modules themselves, and provides a completely decoupled monitoring module. By using custom facts, which are
updated during runtime, the module will magically install monitoring of everything installed on a machine without any
hard dependencies between the module that install the service and the monitoring module.

## Usage

Install the module using:

    puppet module install yuav-monitoring

simply include the module

    class { 'monitoring':
      collectd_network_server_hostname => 'influxdb',
    }

This will install the default metrics collector CollectD, and configure it to send metrics to hostname 'influxdb'.

Using defaults, the module will enable the following collectd plugins:

Always:
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
 * rabbitmq (if management interface enabled)
 * redis

## Custom Facts

This module relies on a set of custom facts to detect any services installed. These facts are refreshed at the end
of any ordinary Puppet run using the yuav-refacter module. This ensures that if another module installs any of these
services, the fact values will be updated to reflect this new state before installing monitoring plugins

### Apache facts

Checks if Apache is installed on the system

    $::apache_present

Checks if apache status page with metrics is available from localhost

    $::apache_statuspage_present

## RabbitMQ facts

Checks if RabbitMQ is installed on the system

    $::rabbitmq_present

Retrieves RabbitMQ management port if enabled

    $::rabbitmq_management_port

## Redis facts

Checks if Redis is installed on the system

    $::redis_present
