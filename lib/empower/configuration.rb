module Empower
  class Configuration

    attr_accessor \
      :facebook_id,
      :facebook_secret

    def initialize
      @facebook_id          = ''
      @facebook_secret      = ''
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
