Puppet Monitoring Facts module
==============================

[![Build Status](https://travis-ci.org/Yuav/puppet-monitoring_facts.svg)](https://travis-ci.org/yuav/puppet-monitoring_facts)

Custom facts for decoupling monitoring from installation

## Module Description

Enables deployment of monitoring tools to detect already installed services. This is useful
to avoid adding monitoring code into the modules themselves. This enables modules to magically
monitor everything installed on a machine without hard dependencies between the module that install
and module which monitors service

## Usage

Install the module using:

    puppet module install yuav-monitoring_facts

and use the facts it provides

    if ($::apache_present) {
      # Install Apache monitoring
    }

*Note: Puppet facts are resolved at runtime, so if apache is installed in the same Puppet run,
add an additional check to ensure idempotency. E.G:

    if defined(Package['apache2']) or $::apache_present {
      # Install Apache monitoring
    }

## Supported facts

    $::apache_present # Returns true if apache is present, false otherwise
    $::redis_present # Returns true if redis-server is present, false otherwise
