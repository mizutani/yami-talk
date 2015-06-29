# coding: utf-8

module Talk::Docomo
  class ApiReqester
    include HTTParty
    base_uri Settings.api.docomo.url
    attr_reader :response
    format :json

    def first_talk(post_param = {})
      talk(post_param.merge({context: nil}))
    end

    def talk(post_param = {})
      @response = self.class.post(
          Settings.api.docomo.talk.path,
          {
            query: query,
            headers: header,
            body: body.merge(post_param).to_json,
          }
        )
    end

    # レスポンス例
    #  "utt"=>"うん",
    #  "yomi"=>"うん",
    #  "mode"=>"dialog",
    #  "da"=>"20",
    #  "context"=>"AAAA"
    def get_text
      @response['utt']
    end

    def get_context
      @response['context'] if @response.present?
    end

    private


    # 設定例
    # "utt": "こんにちは",
    # "context": "",
    # "nickname": "光",
    # "nickname_y": "ヒカリ",
    # "sex": "女",
    # "bloodtype": "B",
    # "birthdateY": "1997",
    # "birthdateM": "5",
    # "birthdateD": "30",
    # "age": "16",
    # "constellations": "双子座",
    # "place": "東京",
    # "mode": "dialog"
    def body
      {
        "utt": "",
        "context": get_context,
      }
    end

    def header
      {
        'Content-type': 'application/json'
      }
    end

    def query
      {
        APIKEY: Settings.api.docomo.talk.key,
      }
    end
  end
end
