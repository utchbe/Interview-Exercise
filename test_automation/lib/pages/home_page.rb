class HomePage
  include PageObject

  page_url "https://www.shipt.com"

  link(:promo_link, class: 'announcement')
  link(:web_login, class: 'button-secondary', text: 'Log In')
  link(:web_sign_up, class: 'button-primary', text: 'Sign up')
end