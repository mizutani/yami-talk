# coding: utf-8
require 'rails_helper'

describe Talk::Docomo::ApiReqester do
  describe "#request" do
    let(:first_response_body) do
      {"utt"=>"私も大好き",
       "yomi"=>"私も大好き",
       "mode"=>"dialog",
       "da"=>"0",
       "context"=>"X-8dmG3lBchSKpeSne5RLg"}
    end
    let(:second_response_body) do
      {"utt"=>"いいですね",
       "yomi"=>"いいですね",
       "mode"=>"dialog",
       "da"=>"0",
       "context"=>"X-8dmG3lBchSKpeSne5RLg"}
    end

    context "正常系" do
      it "値が取得できること" do
        stub_request(:post, /.*api.apigw.smt.docomo.ne.jp.*/).with{ |request|
          JSON.parse(request.body).sort == ({"utt" => "金色の闇大好き", "context" => nil}).sort
        }.to_return(headers: {"Content-Type": "application/json"}, body: first_response_body.to_json)
        api_reqester = Talk::Docomo::ApiReqester.new
        api_reqester.first_talk({utt: "金色の闇大好き"})
        expect(api_reqester.get_text).to eq "私も大好き"

        stub_request(:post, /.*api.apigw.smt.docomo.ne.jp.*/).with{ |request|
          JSON.parse(request.body).sort == ({"utt" => "いいですね", "context" => "X-8dmG3lBchSKpeSne5RLg"}).sort
        }.to_return(headers: {"Content-Type": "application/json"}, body: second_response_body.to_json)
        api_reqester.talk({utt: "いいですね"})
        expect(api_reqester.get_text).to eq "いいですね"
      end
    end
  end
end
