# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'vault class' do
  context 'default parameters' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        if $facts['os']['name'] == 'Archlinux' {
          class { 'file_capability':
            package_name => 'libcap',
          }
        } else {
          include file_capability
        }
        package { 'unzip': ensure => present }
        -> class { 'vault':
          storage => {
            file => {
              path => '/tmp',
            }
          },
          bin_dir => '/usr/local/bin',
          install_method => 'archive',
          require => Class['file_capability'],
        }
        PUPPET
      end
    end
    # rubocop:disable RSpec/RepeatedExampleGroupBody
    describe user('vault') do
      it { is_expected.to exist }
    end

    describe group('vault') do
      it { is_expected.to exist }
    end
    # rubocop:enable RSpec/RepeatedExampleGroupBody

    describe command('getcap /usr/local/bin/vault') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{/usr/local/bin/vault.*cap_ipc_lock.*ep} }
    end

    describe file('/usr/local/bin/vault') do
      it { is_expected.to exist }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end

    describe file('/etc/systemd/system/vault.service') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 444 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      its(:content) { is_expected.to include 'User=vault' }
      its(:content) { is_expected.to include 'Group=vault' }
      its(:content) { is_expected.to include 'ExecStart=/usr/local/bin/vault server -config=/etc/vault/vault.json ' }
      its(:content) { is_expected.to match %r{Environment=GOMAXPROCS=\d+} }
    end

    describe command('systemctl list-units') do
      its(:stdout) { is_expected.to include 'vault.service' }
    end

    describe file('/etc/vault') do
      it { is_expected.to be_directory }
    end

    describe file('/etc/vault/vault.json') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to include('"address": "127.0.0.1:8200"') }
    end

    describe service('vault') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8200) do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
    end
  end

  context 'with package based setup' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        if $facts['os']['name'] == 'Archlinux' {
          class { 'file_capability':
            package_name => 'libcap',
          }
        } else {
          include file_capability
        }
        class { 'vault':
          storage => {
            file => {
              path => '/tmp',
            }
          },
          install_method => 'repo',
          require => Class['file_capability'],
        }
        PUPPET
      end
    end
    describe service('vault') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8200) do
      it { is_expected.to be_listening.on('127.0.0.1').with('tcp') }
    end
  end
end
