# frozen_string_literal: true

# Managed by modulesync - DO NOT EDIT
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

require 'voxpupuli/acceptance/spec_helper_acceptance'

ENV['BEAKER_FACTER_VAULT_VERSION'] = '1.12.0'
configure_beaker(modules: :metadata)

Dir['./spec/support/acceptance/**/*.rb'].sort.each { |f| require f }
