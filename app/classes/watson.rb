# watson-api-client not working
# class Watson
#   def query(text)
#     service = WatsonAPIClient::NaturalLanguageUnderstanding.new(:user=>ENV['IBM_USERNAME'],
#        :password=>ENV['IBM_PASSWORD'],
#        :verify_ssl=>OpenSSL::SSL::VERIFY_NONE
#       )
#     begin
#       result = service.analyzeGet(
#         version: '2017-02-27',
#         features: 'sentiment,emotion',
#         text: text
#       )
#     rescue RestClient::BadGateway, RestClient::UnprocessableEntity, RestClient::BadRequest => err
#     else
#       JSON.parse(result)
#     end
#   end
#
#   def get_emotion(text)
#     if text.length >= 10000
#       text = text[0..9999]
#     end
#     res = query(text)
#     if res
#       res["sentiment"]["document"]["label"]
#     end
#   end
# end
