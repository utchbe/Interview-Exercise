class WelcomePage
    include PageObject
    
    text_field(:auto_complete, id: 'AddressForm-autocomplete')
    div(:page_content, class: 'min-vh-100')
end