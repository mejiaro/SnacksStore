# SnacksStore

**Instalation**

1. First execute different commands
  - ```rake db:create``` this will create the database for the project
  - ```rake db:migrate``` this will create the tables of the project
  - ```rake db:seed``` this will seed the tables with data
2. The users that can be use to enter the page are:
    ```
      --Client--
       Email: client@applaudo.com
       Password: 123456
       --Admin--
       Email: cemg_neto@hotmail.com
       Password: 123456

     ```
**How to use it**

1. All the users can add products to the car and like products
2. Only the users that are registered can buy products
3. The main page is the list of all the products, if a product is out of stock then when the user tries to buy, instead of the button to buy it will a message warning that the product is out of stock
4. The user can erase a product from the car, but not the whole car, for do this, the user has to erase each product, one by one
5. Admin has the privilege to create, modify and delete a product

# API

## Log in

- **URL**

  /api/v1/sessions

- **Method**
 ```
 POST
 ```
-  **Params**

      **Required:**

      email=[string]
      password=[string]

- **Success Response:**

      - **Code:** 200    
  ```
  {
    "success": true,
    "info": "Logged in sucessfully."
  }
```
- **Error Response:**

    - **Code:** 403
    **Content:**
```
  {
    "success": false,
    "info": "Login failed."
  }
```

    OR

    - **Code:** 404
    **Content:**
```
  {
    "success": false,
    "info": "Email not found."
  }
```

## User Profile


- **URL**
  /api/v1/users
- **Method**
 ```
 POST
 ```
- **Params**

      **Required:**

      token=[string] => To be send in header


- **Success Response:**

      - **Code:** 200    
  ```
  {
    "user": {
        "id": 1,
        "email": "cemg_neto@hotmail.com",
        "created_at": "2019-03-15T20:01:33.768Z",
        "updated_at": "2019-03-15T20:01:33.768Z",
        "username": "Carlos",
        "role_id": 1
    }
}
```
- **Error Response:**

    - **Code:** 401
    **Content:**
```
  {
    "info": "token expired"
  }
```

    OR

    - **Code:** 404
    **Content:**
```
{
  "info": "user not found"
}
```
