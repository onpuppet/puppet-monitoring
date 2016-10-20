require 'spec_helper_acceptance'

describe 'all facts' do
  context 'run all facts' do
    it 'works with no errors' do
      pp = <<-EOS

      notice("Apache present: ${::apache_present}")
      notice("Apache statuspage present: ${::apache_statuspage_present}")
      notice("Redis present: ${::redis_present}")
      notice("Rabbitmq present: ${::rabbitmq_present}")

      EOS

      apply_manifest(pp, catch_failures: true)
    end
  end
end
