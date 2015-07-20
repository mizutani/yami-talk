class CreateVoiceJob < ActiveJob::Base
  queue_as :default

  rescue_from(StandardError) do |e|
    logger.info e.message
    logger.info e.backtrace
  end

  def perform(text, file_name)
    converter = Converter::TextToSpeech.new
    converter.execute(text, create_voice_path(file_name))
  end

  private

  def create_voice_path(file_name)
    Rails.root.join("app", "assets", "voices", file_name)
  end
end
