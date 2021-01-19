require 'mock_redis'
RSpec.describe MuffinMan::SpApiClient do
  let(:credentials) {
    {
      refresh_token: 'a-refresh-token',
      client_id: 'a-client-id',
      client_secret: 'a-client-secret',
      aws_access_key_id: 'an-aws-access-key-id',
      aws_secret_access_key: 'an-aws-secret-access-key',
      region: 'us-east-1'
    }
  }
  let(:fake_lwa_access_token) { "this_will_get_you_into_drury_lane" }
  let(:sandbox) { false }
  let(:hostname) { 'sellingpartnerapi-na.amazon.com' }

  subject(:client) { described_class.new(credentials, sandbox) }

  it 'correctly initializes params' do
    expect(client.refresh_token).not_to be_nil
    expect(client.client_id).not_to be_nil
    expect(client.client_secret).not_to be_nil
    expect(client.aws_access_key_id).not_to be_nil
    expect(client.aws_secret_access_key).not_to be_nil
    expect(client.region).not_to be_nil
    expect(client.hostname).not_to be_nil
  end

  it 'sets the Typhoeus user agent to an empty string' do
    expect(Typhoeus::Config.user_agent).to eq('')
  end

  context 'when using the sandbox environment' do
    let(:sandbox) { true }
    it 'correctly builds the canonical api hostname' do
      expect("sandbox.#{client.hostname}").to eq(client.send(:sp_api_host))
    end
  end

  context 'testing auth' do
    let!(:fake_klass) do
      module MuffinMan
        class FakeKlass < SpApiClient
          attr_reader :local_var_path, :request_type, :query_params
          def make_a_request
            @local_var_path = '/some_path'
            @request_type = 'GET'
            @query_params = {}
            call_api
          end
        end
      end
    end
    before do
      stub_request_access_token
      stub_fake_request
    end

    it 'gets an access token and signs the headers' do
      expect(Typhoeus).to receive(:get).
        with("https://#{client.hostname}/some_path", headers: hash_including('x-amz-access-token' => fake_lwa_access_token,
                                                           'authorization' => a_string_including("SignedHeaders=host;x-amz-content-sha256;x-amz-date")))
      MuffinMan::FakeKlass.new(credentials).make_a_request
    end

    context 'when the config defines a lambda for token caching' do
      before do
        @@redis = MockRedis.new
        MuffinMan.configure do |config|
          config.save_access_token = -> (client_id, token) do
            @@redis.set("SP-TOKEN-#{client_id}", token['access_token'])
          end
          config.get_access_token = -> (client_id) { @@redis.get("SP-TOKEN-#{client_id}") }
        end
      end

      context 'when there is no stored token' do
        it 'uses and saves the new token' do
          expect_any_instance_of(MockRedis).to receive(:set).with("SP-TOKEN-#{credentials[:client_id]}", fake_lwa_access_token)
          expect(Typhoeus).to receive(:get).
            with("https://#{client.hostname}/some_path", headers: hash_including('x-amz-access-token' => fake_lwa_access_token))
          MuffinMan::FakeKlass.new(credentials).make_a_request
        end
      end

      context 'when there is a stored token' do
        let(:another_fake_lwa_access_token) { "i-know-the-muffin-man" }
        before do
          MockRedis.new.set("SP-TOKEN-#{credentials[:client_id]}", another_fake_lwa_access_token)
        end

        it 'uses the stored token' do
          expect_any_instance_of(MockRedis).to receive(:get).with("SP-TOKEN-#{credentials[:client_id]}").and_return(another_fake_lwa_access_token)
          expect(Typhoeus).to receive(:get).
            with("https://#{client.hostname}/some_path", headers: hash_including('x-amz-access-token' => another_fake_lwa_access_token))
          MuffinMan::FakeKlass.new(credentials).make_a_request
        end
      end
    end
  end
end
