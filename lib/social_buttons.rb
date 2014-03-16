module SocialButtons
  def self.names
    %w{pinit tweet like google_plus vkontakte}
  end

  def self.helpers
    %w{assistant scripter}
  end

  def self.all
    names + helpers
  end

  def self.config name = nil, &block 
    context = name ? "SocialButtons::#{name.to_s.camelize}".constantize : self
    block_given? ? yield(context) : context
  end

  # add class method for each social button registered
  names.each do |name|
    (class << self; self; end).send :define_method, name do |&block|      
      clazz = "SocialButtons::#{name.to_s.camelize}".constantize
      block_given? ? clazz.instance_eval(&block) : clazz
    end
  end
end

require "social_buttons/view_helper"
require "social_buttons/railtie" if defined?(Rails)
