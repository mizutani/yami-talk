# coding: utf-8
require 'rails_helper'

describe Converter::SpeechToText do
  describe "#self.execute" do
    let(:file_path) { Rails.root.join("spec/fixtures/voice/sample.flac") }
    let(:body) do
      "{\"result\":[]}\n{\"result\":[{\"alternative\":[{\"transcript\":\"サンプル\",\"confidence\":0.77291328},{\"transcript\":\"sample\"},{\"transcript\":\"さんぷる\"}],\"final\":true}],\"result_index\":0}\n"
    end

    it "音声ファイルがテキスト解析されること" do
      stub_request(:post, /.*google.com.*/).to_return(headers: {"Content-Type": "application/json"}, body: body)
      response = Converter::SpeechToText.new
      response.execute(file_path)
      expect(response.get_text).to eq "サンプル"
    end
  end
end
