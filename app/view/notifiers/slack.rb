require 'slack-notifier'

module StockAgent
  class Slack
    extend NotifyNormalizer

    class << self
      def notify(text)
        new.send(:notify, normalize_input(text))
      end
    end

    private

    attr_reader :slack_notifier

    def initialize
      @slack_notifier = ::Slack::Notifier.new(StockAgent::Lib::Config.slack_url)
    end

    def notify(text)
      @slack_notifier.post({ text: text, channel: nil }.compact)
    end
  end
end
