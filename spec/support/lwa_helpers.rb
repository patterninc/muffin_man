module Support
  module LwaHelpers
    def stub_request_refresh_token
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: "grant_type=authorization_code&code=#{auth_code}&client_id=#{client_id}&client_secret=#{client_secret}",
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 200,
                   body: '{"access_token":"good_access_token","refresh_token":"good_refresh_token","token_type": "bearer","expires_in":3600}',
                   headers: {})
    end

    def stub_request_bad_refresh_token
      stub_request(:post, "https://api.amazon.com/auth/o2/token")
        .with(body: "grant_type=authorization_code&code=#{bad_auth_code}&client_id=#{client_id}&client_secret=#{client_secret}",
              headers: { "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8", "Expect" => "",
                         "User-Agent" => "" })
        .to_return(status: 400,
                   body: '{"error_description":"The request has an invalid grant parameter : code","error": "invalid_grant"}',
                   headers: {})
    end
  end
end
