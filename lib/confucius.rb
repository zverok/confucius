# encoding: utf-8
require 'ostruct'
require 'yaml'

module Confucius
  class Setup
    def initialize(block)
      @block = block
    end

    def then(&block)
      @then = block
    end

    def call(config)
      @block.call(config).tap{|res|
        @then.call(res) if @then
      }
    end
  end
  
  def from_yaml(path)
    from_hash(YAML.load(File.read(path)))
  end

  def from_hash(hash)
    hash.each_pair{|key, value|
      key = key.to_sym
      if (setup = setups[key])
        set :"#{key}_config", value
        set key, setup.call(value)
      else
        set key, value
      end
    }
  end

  def setups; @setups ||= {} end

  def setup(key, &block)
    setups[key] = Setup.new(block)
  end

  def self.extended(host)
    ensure_method(host, :settings){@settings ||= OpenStruct.new}
    ensure_method(host, :set){|key, value| settings.send("#{key}=", value)}
  end

  class << self
    private

    def ensure_method(host, sym, &block)
      host.respond_to?(sym) or host.define_singleton_method(sym, &block)
    end
  end
end
