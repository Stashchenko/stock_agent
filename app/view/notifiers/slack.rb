require 'slack-notifier'

module StockAgent
  class Slack
    extend NotifyNormalizer
    SLACK_NOTIFIER = ::Slack::Notifier.new(StockAgent::Lib::Config.slack_url)

    class << self
      def notify(text)
        SLACK_NOTIFIER.post({text: normalize_input(text), channel: nil}.compact)
      end
    end
  end
end
