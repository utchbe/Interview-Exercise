class ShopPage
  include PageObject

  element(:profile, data_test: 'profile-icon')
  span(:account_link, text: 'Account')
end