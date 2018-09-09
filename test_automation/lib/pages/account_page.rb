class AccountPage
  include PageObject

  button(:logout, data_test: 'AccountPageContainer-log-out-button')
end