# coding: utf-8
require 'open_jtalk'

module Converter
  class TextToSpeech
    def execute(text, file_name)
      OpenJtalk.load(OpenJtalk::Config::Mei::NORMAL) do |openjtalk|
        header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

        OpenJtalk::Mp3FileWriter.save(file_name, header, data)
      end
    end
  end
end
