describe 'Web Login' do
    context 'with a random user that does not exist' do
      before(:all) do
        @email = Faker::Internet.safe_email
        @password = Faker::Internet.password

        visit HomePage do |page|
          page.web_login
        end

        on LoginPage do |page|
          page.login_with(
              email: @email,
              password: @password
          )
          puts "For debugging, the username: #{@email} and password: #{@password}"
        end
      end

      it 'should provide error message' do
        on LoginPage do |page|
          page.error_element.element.wait_until_present
          expect(page.error).to include("Invalid Username or Password")
        end
      end
    end

    context 'with an existing user' do
      before(:all) do
        @email = 'asdf@asdf.com'
        @password = 'asdf'

        visit HomePage do |page|
          page.web_login
        end

        on LoginPage do |page|
          page.login_with(
              email: @email,
              password: @password
          )
          puts "For debugging, the username: #{@email} and password: #{@password}"
        end
      end

      after(:all) do
        on ShopPage do |page|
          page.account_link_element.click
        end

        on AccountPage do |page|
          page.logout
        end
      end

      it 'should show is logged in message' do
        on ShopPage do |page|
          page.profile_element.element.wait_until_present
          expect(page.current_url).to eq('https://shop.shipt.com/#/app/home')
          expect(page.account_link).to eq('Account')
        end
      end
    end
end
