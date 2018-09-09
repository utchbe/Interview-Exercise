describe 'API Login' do
  context 'with a user that does not exist' do
    before(:all) do
      @email = Faker::Internet.safe_email
      @password = Faker::Internet.password
    end

    it 'should provide error message' do
      response = HTTParty.post("https://api.shipt.com/auth/v2/oauth/token",
                               headers: { 'X-User-Type' =>'Customer'},
                               body: {
                                   username: @email,
                                   password: @password,
                                   grant_type: 'password'
                               } )

      expect(response.body).to include('Invalid Username or Password')
      expect(response.code).to eq(401)
    end
  end

  context 'with an existing user' do
    before(:all) do
      @email = 'asdf@asdf.com'
      @password = 'asdf'
    end

    it 'should show is logged in message' do
      response = HTTParty.post("https://api.shipt.com/auth/v2/oauth/token",
                               headers: { 'X-User-Type' =>'Customer'},
                               body: {
                                   username: @email,
                                   password: @password,
                                   grant_type: 'password'
                               } )

      expect(response.body).to include('access_token')
      expect(response.code).to eq(200)
    end
  end
end

