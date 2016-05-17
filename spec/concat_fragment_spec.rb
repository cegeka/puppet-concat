require 'spec_helper_acceptance'

describe 'concat::fragment' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
      concat { '/etc/motd':
        owner => 'root',
        group => 'root',
        mode  => '0644'
      }

      concat::fragment{ 'motd_header':
        target  => '/etc/motd',
        content => "\nPuppet modules on this server:\n\n",
        order   => '01'
      }

      concat::fragment{ 'motd_local':
        target => '/etc/motd',
        content => "\nABC ABC:\n\n",
        order  => '15'
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/motd' do
      it { is_expected.to be_file }
      its(:content) { should contain /Puppet modules on this server/ }
      its(:content) { should contain /ABC ABC/ }
    end

  end
end

