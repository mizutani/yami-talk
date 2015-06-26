# coding: utf-8

module Converter
  class SpeechToText
    include HTTParty
    base_uri Settings.api.google.url
    attr_reader :response
# 参考 http://qiita.com/mountcedar/items/be1e5d54fcef8f3a4bda
# sox flac google acount register speechToText
# brew install sox --with-lame --with-flac --with-libvorbis
    def execute(file_path)
      @response = self.class.post(
          Settings.api.google.speech.path,
          {
            query: query,
            headers: header,
            body: read_data(file_path),
          }
        )
    end

    def get_text
      response.body.lines.map{|m| JSON.parse(m)}.select{|r| r["result"].present? }.sample
      .try(:fetch, "result").try(:first).try(:fetch, "alternative").try(:first).try(:fetch, "transcript")
    end

    private

    def read_data(file_path)
      open(file_path, 'rb').read
    end

    def header
      {
        'Content-type': 'audio/x-flac; rate=16000'
      }
    end

    def query
      {
        xjerr: 1,
        client: 'chromium',
        lang: 'ja-JP',
        maxresults: 10,
        pfilter: 0,
        key: Settings.api.google.speech.key,
      }
    end
  end
end
