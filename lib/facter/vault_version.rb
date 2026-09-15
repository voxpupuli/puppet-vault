# frozen_string_literal: true

# Fact: vault_version
#
# Purpose: Retrieve vault version if installed
#
Facter.add(:vault_version) do
  confine { Facter::Core::Execution.which('vault') }
  setcode do
    vault_server_version_output = Facter::Core::Execution.execute('vault version')
    match = vault_server_version_output.match(%r{Vault v(\d+\.\d+\.\d+)})
    match&.captures&.first
  end
end
