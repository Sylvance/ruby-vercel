# frozen_string_literal: true

RSpec.describe Vercellus::Utils::Request do
  let(:response) { double(body: "{}") }
  let(:headers) { { "Content-Type": "application/json", "Authorization": "Bearer #{Vercellus.configuration.token}" } }
  let(:params) { { limit: 10 } }

  context "#get" do
    it "does a http get request with Faraday gem" do
      expect(Faraday).to receive(:get).with("https://api.vercel.com/url", headers: headers,
                                                                          params: params).and_return(response)
      Vercellus::Utils::Request.get(url, nil, params)
    end
  end

  context "#post" do
    let(:body) { { name: "my-instant-deployment" } }

    it "does a http post request with Faraday gem" do
      expect(Faraday).to receive(:post).with("https://api.vercel.com/url", headers: headers, params: params,
                                                                           body: body.to_json).and_return(response)
      Vercellus::Utils::Request.post(url, params, body)
    end
  end

  context "#delete" do
    it "does a http delete request with Faraday gem" do
      expect(Faraday).to receive(:delete).with("https://api.vercel.com/url", headers: headers,
                                                                             params: params).and_return(response)
      Vercellus::Utils::Request.delete(url, nil, params)
    end
  end
end
