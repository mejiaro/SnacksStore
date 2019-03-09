# SnacksStore

**Instalation**

1. First execute different commands
  - ```rake db:create``` this will create the database for the project
  - ```rake db:migrate``` this will create the tables of the project
  - ```rake db:seed``` this will seed the tables with data
2. The users that can be use to enter the page are:
    ```
      --User 1--
       Email: client@applaudo.com
       Password: 123456
       --User 2--
       Email: cemg_neto@hotmail.com
       Password: 123456
     ```
**How to use it**

1. Only the users who are registered can add products to the car and like products
2. The main page is the list of all the products, if a product is out of stock then when the user tries to buy, instead of the button to buy it will a message warning that the product is out of stock
3. The user can erase a product from the car, but not the whole car, for do this, the user has to erase each product, one by one
