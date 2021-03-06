module SocialButtons
  module Vkontakte
    include SocialButtons::Assistant

    def vkontakte_like appId, *args
      clazz = SocialButtons::Vkontakte
      options = args.extract_options!
      
      clazz.default_options.each { |k,v| options[k] ||= v }

      html = "".html_safe
      html << clazz::Scripter.new(self).init_js(appId)
      html << content_tag(:div, nil, id: "vk_like_#{options[:verb]}")
      html << clazz::Scripter.new(self).script(options)
      html
    end

    class << self
      def default_options
        @default_options ||= {
          width: '350',
          type: 'vertical',
          verb: '0',
          height: '22'
        }
      end      
    end

    class Scripter < SocialButtons::Scripter
      def init_js appId
        "<script type=\"text/javascript\"> VK.init({apiId: #{appId}, onlyWidgets: true}); </script>".html_safe
      end
      def script options = {}
        [
          "<script type=\"text/javascript\">",
          "VK.Widgets.Like(\"vk_like_#{options[:verb]}\", { type: \"#{options[:type]}\", width: '#{options[:width]}', verb: '#{options[:verb] }', pageUrl: '#{options[:url]}', pageTitle: '#{options[:title]}', width: '#{options[:width]}', pageDescription: '#{options[:desc]}', pageImage: '#{options[:image]}'  });",
          "</script>"
        ].join.html_safe
      end
    end
  end
end
