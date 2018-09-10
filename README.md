# Shipt Interview Exercise

## Manual Testing

* Explored around the website https://www.shipt.com below are some details of what I learned.
* Seems to be built on Wordpress
* Noticed approximately 12 3rd party services that connect to my session. Segment, multiple from Google, Facebookevents, and impactradius. I could see where this is important to capture visitors data.
* Found a few different URLS with potentially different back ends within scope
    * https://app.shipt.com
    * https://api.shipt.com
    * https://shop.shipt.com
    * https://www.shipt.com

Note: http://app.shipt.com doesn't re-direct to https it just times out

Note: https://app.shipt.com/password_resets/new uses a csrf-token for reseting a users password yay! go security!.

Tools used in testing: mobile phone, chrome w/ dev tools, firefox, zap proxy

## Writing Test Case/Description
##### Testing Reset Password Functionality
1. Browse to https://www.shipt.com
2. Click 'LOG IN' button in top menu
3. Click 'Forgot password?' link
4. Enter {valid_test_email_address} in the Email text box
5. Click 'Reset my password!' button

* Expect the appropriate confirmation message is shown to the user on the website (Originally Failed) - **This was resolved sometime on Saturday 9/9**
* Expect that the email is delivered to {valid_test_email_address} with a valid reset password link (passed)
* Expect that the email follows style guide and has appropriate messaging to the user (passed)
* Expect that the link in the email leads to a page that allows you to reset your password


## Locating A Bug:
1.  On https://app.shipt.com/password_resets/new
    * When visiting via webpage there is a `js error: ReferenceError: Can't find variable: google on line 6,759:32 'center: new google.maps.LatLng (33.457946, -86.81383)`
    * **Priority = 5**  This doesn't appear to be affecting any functionality. I am assuming this page is used in the hybrid mobile app where it has access to a google variable.

1. On https://app.shipt.com/password_resets/new
    * Enter the email address: asdf1@asdf.com - note that the the web page will basically spin until it times out (the email was sent). It appears this is only happening with valid accounts in the system.  When I tested with 1@1.com I get a notification saying 'Check your email for password reset instructions' But I am confident 1@1.com doesn't exist as I attempted multiple attempts to login via the https://shop.shipt.com/login url and was never prompted with an account is locked message which I did get for asdf1@asdf.com.
    * **Priority = 3**. This doesn't prevent any users from accessing any of the features in the app, but it may cause confusion for those who have forgotten their password. Having a webpage just spin and eventually time out is no way to treat users who are already having a bad day because they've forgotten their Shipt password.

> Note: if you go to a new window and try and re-enter the email address - asdf1@asdf.com again (within 5 minutes) you will receive a message stating - 'You cannot request to reset your password again so soon. Please wait 5 minutes'

**Update**: Sometime Saturday 9/9 Issue 2 was resolved. Now when a valid users password is reset, you are now re-directed to https://app.shipt.com/ with a message indicating 'Check your email for password reset instructions'
While this is good that the user is getting feedback. It does open up the system to allow users to learn what email addresses have valid shipt accounts with the respons from the website.
* Visit reset password page - input valid email address - Get re-directed to https://app.shipt.com/ with a different success message
* Visit reset password page - input valid email address within 5min - No re-direct but error message 'You cannot request to reset your password again so soon. Please wait 5 minutes'
* Visit reset password page - input invalid email address - No re-direct with message 'Check your email for password reset instructions'
> With these different interactions someone could easily write a script to gather what emails exist as valid shipt accounts to potentially comprimize customer accounts.


## Possible Reasons For The Defect:.
* Database table(s) are built poorly.
* Asynchronous transaction errors ()
* Network could have dropped when attempting to try to re-enter the first phone number
* Browser autocomplete could be automatically changing your results when saving first number
* There could be a javascript error on the page preventing the original number from being saved
* The number really be saved in the database but is cached on the front end page
* It's possible that the add / edit inputs have different validation, maybe the first number is 10 digits, the 2nd number is 7 digits, but 'editing' the phone number only allows for 7 digits even though 10 digits may look available.
* I could come up with more....

##### Debugging And Information Gathering
> I would first check for javascript errors on the page, then onto check the actual values in the database. If I didn't find what I was looking for I would check for any web application logs or any api error queues (especially if asynchronous). If I didn't find what I am looking for there, I would attempt to profile the database that is being used to see if anything is attempting to be written there. If all that fails, I would go loop a developer into the issue, with clear steps to reproduce for more ideas or debugging in a developer environment. My suggestion would be to have the same message and page displayed for all three scenarios while keeping the current server side rules in place (not sending more than 1 pw reset email within 5 minutes)

## UI & API Automation
I've combined the UI and API Automation frameworks into 1 repo. These could easily be split up but I decided to re-use the framework for this exercise.
[UI & API Automation Repo](https://github.com/utchbe/THREE-LITTLE-PIGS/tree/master/test_automation)

## SQL

I used mysql database for all the solutions

1. Stores allowed to sell alcohol

    Answer: Gettar
    ```sql
    select * from stores where allowed_alcohol = 1`
    ```
1. Product name of the 2 most expensive items based on their price at store id 1

    Answers: Golden Banana & Banana
    ```sql
    select products.name from store_prices
    inner join products on store_prices.product_id = products.id
    where store_id = 1 order by price desc limit 2`
    ```

1. List the products that are not sold in the store id 2

    Answers: Grapes, Banana, Golden Banana, Bouquet Flowers
    ```sql
    select products.name from products
    left join store_prices on store_prices.product_id = products.id
    where store_id <> 2 or store_id is null
    ```

1. What is the most popular item sold?  (assuming order_lines.qty is the sold amount)

    Answer: Banana with 51 purchased
    ```sql
    select name, sum(qty) total_purchased from products
    inner join order_lines on products.id = order_lines.product_id
    group by products.id order by total_purchased desc limit 1
    ```
1. Write a SQL statement to update the line_total field

    Answers: id_1=4.68 | id_2 = 166.00 | id_3 = 3.32 | id_4 = 9.36
    ```sql
    update order_lines
    inner join products on products.id = order_lines.product_id
    inner join stores on order_lines.store_id = stores.id
    left join store_prices on order_lines.product_id = store_prices.product_id and order_lines.store_id =store_prices.store_id
    set line_total = (order_lines.qty * store_prices.price)
<<<<<<< Updated upstream
    ```
=======
    ```

## Extra Credit

###### Checkout beta branch

`git checkout beta` or see branch on [github](https://github.com/utchbe/Interview-Exercise/tree/beta)

###### Build docker container from dockerfile

    `docker build -t test-homework .`

###### Run docker container and headless automated tests
`docker run -e SCREEN="1280x1024x16" -t -i --rm test-homework:latest bash`
>>>>>>> Stashed changes
