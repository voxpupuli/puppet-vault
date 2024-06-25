# frozen_string_literal: true

# Fact: vault_version
#
# Purpose: Retrieve vault version if installed
#
Facter.add(:vault_version) do
  confine { Facter::Util::Resolution.which('vault') }
  setcode do
    vault_server_version_output = Facter::Util::Resolution.exec('vault version')
    match = vault_server_version_output.match(%r{Vault v(\d+\.\d+\.\d+)})
    match&.captures&.first
  end
end
