class TalkController < ApplicationController
  protect_from_forgery except: :message

  def index
  end

  def message
    reqester = Talk::Docomo::ApiReqester.new
    reqester.talk({utt: params[:message]})
    text = reqester.get_text.present? ? reqester.get_text : 'テキストの生成に失敗しました。'

    file_name = "#{Time.now.strftime('%Y%m%d%H%M%S')}.mp3"
    converter = Converter::TextToSpeech.new
    converter.execute(text, create_voice_path(file_name))
    # CreateVoiceJob.perform_later reqester.get_text, file_name

    render :json => {
      talk_message: text,
      send_message: params[:message],
      file_name: file_name,
    }
  end

  def create_voice_path(file_name)
    Rails.root.join("app", "assets", "voices", file_name)
  end
end
