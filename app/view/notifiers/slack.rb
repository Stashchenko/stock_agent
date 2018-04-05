require 'slack-notifier'

module StockAgent
  class Slack
    SLACK_NOTIFIER = ::Slack::Notifier.new(StockAgent::Lib::Config.slack_url)

    class << self
      def notify(text)
        SLACK_NOTIFIER.post({ text: text, channel: nil }.compact)
      end
    end
  end
end
