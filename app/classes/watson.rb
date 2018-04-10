require 'watson-api-client'

class Watson
  def query(text)
    service = WatsonAPIClient::NaturalLanguageUnderstanding.new(:user=>ENV['IBM_USERNAME'],
       :password=>ENV['IBM_PASSWORD'],
       :verify_ssl=>OpenSSL::SSL::VERIFY_NONE
      )
    begin
      result = service.analyzeGet(
        version: '2017-02-27',
        features: 'sentiment,emotion',
        text: text
      )
    rescue RestClient::BadGateway, RestClient::UnprocessableEntity => err
    else
      JSON.parse(result)
    end
  end

  def get_emotion(text)
    if text.length < 6000
      res = query(text)
      if res
        res["sentiment"]["document"]["label"]
      end
    end
  end
end
