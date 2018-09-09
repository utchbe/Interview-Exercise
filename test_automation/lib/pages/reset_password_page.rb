class ResetPasswordPage
  include PageObject

  page_url "https://app.shipt.com/password_resets/new"

  text_field(:email, id: 'email')
  button(:reset_my_password, name: 'commit')
  div(:alert, class: 'alert')
end