describe 'Web Reset Password' do
  context 'with a user that does not exist' do
    before(:all) do
      @email = Faker::Internet.safe_email

      visit HomePage do |page|
        page.web_login
      end

      on LoginPage do |page|
        page.login_form_element.when_present
        page.forgot_password
      end

    on ResetPasswordPage do |page|
      page.email= @email
      page.reset_my_password
      end
    end

    it 'should provide error message' do
      on ResetPasswordPage do |page|
        page.alert_element.element.wait_until_present
        expect(page.current_url).to eq('https://app.shipt.com/password_resets')
        expect(page.alert).to include('Check your email for password reset instructions')
      end
    end
  end

  context 'with a user that does exist' do
    before(:all) do
      @email = 'asdf@asdf.com'

      visit HomePage do |page|
        page.web_login
      end

      on LoginPage do |page|
        page.login_form_element.when_present
        page.forgot_password
      end

      on ResetPasswordPage do |page|
        page.email= @email
        page.reset_my_password
      end
    end

    puts "------------------------------------------------------------------".yellow
    puts "This is a flaky test, the current page logic only lets a user reset their password every 5 minutes. Two decent options to make this test better would be:".red
    puts "1. Create a bank of 100 valid test users that could be randomly picked from to test against".red
    puts "2. (My preference) Create a database or api method that would modify the datastore to remove or reset the data that prevents the password from being reset within 5 minutes".red
    puts "------------------------------------------------------------------".yellow
    it 'should provide a success message' do
      on ResetPasswordPage do |page|
        page.alert_element.element.wait_until_present
        expect(page.alert).to include('Check your email for password reset instructions')
        expect(page.current_url).to eq('https://app.shipt.com/')

      end
    end
  end
end
