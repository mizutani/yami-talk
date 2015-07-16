module TaskLogger
  class << self
    delegate(
      :debug,
      :info,
      :warn,
      :error,
      :fatal,
      to: :logger
    )

    def logger
      @logger ||= create_logger
    end

    private

    def create_logger
      return Rails.logger if file_name.blank?

      logger = ActiveSupport::Logger.new(Rails.root.join('log', file_name), 'monthly')
      logger.formatter = Logger::Formatter.new
      logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      logger.level = Rails.logger.level
      logger
    end

    def file_name
      Rake.application.top_level_tasks.last.split(':').reduce(Settings.log) do |settings, name|
        settings.try(name)
      end
    end
  end
end
