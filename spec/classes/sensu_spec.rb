require 'spec_helper'

describe 'monitoring::monitoring::sensu', type: :class do
  let :pre_condition do
    'include ::monitoring'
  end
  on_supported_os.each do |os, facts|
    context "on #{os} " do
      context 'services present' do
        let :facts do
          facts.merge(
            centrify_present: true,
            collectd_present: true,
            elasticsearch_present: true,
            influxdb_present: true,
            mysql_present: true,
            postfix_present: true,
            rabbitmq_present: true,
            redis_present: true
          )
        end

        it { is_expected.to contain_class('monitoring::monitoring::sensu::centrify') }
        it { is_expected.to contain_sensu__check('centrify-process') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::collectd') }
        it { is_expected.to contain_sensu__check('collectd-process') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::elasticsearch') }
        it { is_expected.to contain_sensu__check('es-cluster-status') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::influxdb') }
        it { is_expected.to contain_sensu__check('influxdb') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::mysql') }
        it { is_expected.to contain_sensu__check('mysql-process') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::postfix') }
        it { is_expected.to contain_sensu__check('mailq') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::rabbitmq') }
        it { is_expected.to contain_sensu__check('rabbitmq-alive') }

        it { is_expected.to contain_class('monitoring::monitoring::sensu::redis') }
        it { is_expected.to contain_sensu__check('redis-process') }
      end

      context 'services absent' do
        let :facts do
          facts.merge(
            centrify_present: false,
            elasticsearch_present: false,
            influxdb_present: false,
            mysql_present: false,
            postfix_present: false,
            rabbitmq_present: false,
            redis_present: false
          )
        end

        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::centrify') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::elasticsearch') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::influxdb') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::mysql') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::postfix') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::rabbitmq') }
        it { is_expected.not_to contain_class('monitoring::monitoring::sensu::redis') }
        it { is_expected.not_to contain_sensu__check('rabbitmq-alive') }
      end
    end
  end
end
