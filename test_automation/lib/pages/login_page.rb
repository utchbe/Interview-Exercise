class LoginPage
    include PageObject
  
    page_url "https://shop.shipt.com/login"
  
    link(:create_account, class: 'announcement')
    form(:login_form, data_test: 'login-form')
    text_field(:email, name: 'username')
    text_field(:password, name: 'password')
    button(:login, data_test: 'LoginForm-log-in-button')
    link(:forgot_password, text: 'Forgot password?')
    div(:error, class: 'LoginForm-error')

    def login_with(params = {})
        self.login_form_element.when_present
        self.email = params[:email] || Faker::Internet.email
        self.password = params[:password] || Faker::Internet.password
        self.login
    end
end