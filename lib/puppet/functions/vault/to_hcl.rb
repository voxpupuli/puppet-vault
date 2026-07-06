# frozen_string_literal: true

require_relative '../../vault_config/schema'

# @summary Converts a Vault configuration hash to HCL format.
Puppet::Functions.create_function(:'vault::to_hcl') do
  # Converts a Vault configuration hash to HCL format.
  #
  # @param config A hash containing the Vault configuration.
  # @return [String] The Vault configuration rendered as HCL.
  # @example Converting a config hash to HCL
  #   $hcl_content = vault::to_hcl($config_hash)
  dispatch :to_hcl do
    param 'Hash', :config
    return_type 'String'
  end

  def to_hcl(config)
    require 'puppet/hcl'
    Puppet::HCL.generate(
      transform(config),
      labeled_blocks: Puppet::VaultConfig::LABELED_BLOCKS.map(&:to_sym),
    )
  end

  private

  def transform(config)
    config.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = if Puppet::VaultConfig::LABELED_BLOCKS.include?(key)
                             Array(value).map { |item| labeled_block(item) }
                           else
                             deep_symbolize(value)
                           end
    end
  end

  def labeled_block(item)
    if item.is_a?(Hash)
      type, attrs = item.first
    else
      # item is a [type, attrs] pair produced by Array(hash).to_a
      # This happens when a labeled block param (e.g. storage) is passed as a
      # plain Hash rather than an Array of single-key hashes.
      type, attrs = item
    end
    deep_symbolize(attrs).merge(_label: type)
  end

  def deep_symbolize(value)
    case value
    when Hash
      value.each_with_object({}) do |(k, v), h|
        h[k.to_sym] = deep_symbolize(v)
      end
    when Array
      value.map { |v| deep_symbolize(v) }
    else
      value
    end
  end
end
