# coding: utf-8

module Converter
  class textToSpeech
    MODEL = OpenJtalk::Config::Mei::NORMAL

    def execute(text, file_name)
      OpenJtalk.load(MODEL) do |openjtalk|
        header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

        OpenJtalk::WaveFileWriter.save(file_name, header, data)
      end
    end
  end
end
