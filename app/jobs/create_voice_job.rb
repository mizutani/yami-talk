class CreateVoiceJob < ActiveJob::Base
  queue_as :default

  rescue_from(StandardError) do |e|
    logger.info e.message
    logger.info e.backtrace
  end

  def perform(text, file_name)
  　# TODO 緊急回避 あとでちゃんとした対応を行う
    text = 'テキストの生成に失敗しました。' if text.blank?
    converter = Converter::TextToSpeech.new
    converter.execute(text, create_voice_path(file_name))
  end

  private

  def create_voice_path(file_name)
    Rails.root.join("app", "assets", "voices", file_name)
  end
end
