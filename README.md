# README
In this project, I used Ruby on Rails, ActiveRecord(ORM), and a PostgreSQL DB to build a JSON API which exposes the SalesEngine data schema. The SalesEngine data schema was provided in CVS files that I imported into the PostgreSQL DB.

There are also additional endpoints that are exposed that provide business intelligences, for example `/merchants/most_revenue?quantity=x` -> returns the top `x` merchants ranked by total revenue. For additional details, please see below.

### Local Deployment
(Terminal Commands)
1. Clone Repository:  
`git clone git@github.com:rallen20/rails_engine_rallen.git`
2. Install Gems:  
`bundle install`  
`bundle update`
3. Create Database and Install citext:  
`rails db:create`  
`rails db`  
`CREATE EXTENSION IF NOT EXISTS citext;`  
`\q`  
`rails db:migrate`  
`rake import` 
4. Run Test Suite:  
`rspec`
5. Local Server for API Endpoints:  
`rails s`


### API
- ALL API requests should be nested URLs beginning with `GET https://localhost:3000/api/v1`


- All `find` queries will return a single object.


- All `find_all ` queries will return all objects that match the criteria.


- Example: For all merchants, while running the server locally, input the following into your browser.
  - `https://localhost:3000/api/v1/merchants`  


- Example: All Find and Find All Queries that reference date should be formatted in timestamp.
  - `http://localhost:3000/api/v1/merchants/find?created_at=2012-03-27T14:54:05.000Z`

### Table of Contents

- [Customer Endpoints](#customer-endpoints)
- [Invoice Item Endpoints](#invoice-item-endpoints)
- [Invoice Endpoints](#invoice-endpoints)
- [Item Endpoints](#item-endpoints)
- [Merchant Endpoints](#merchant-endpoints)
- [Transaction Endpoints](#transaction-endpoints)

#### Data Tables
<img width="760" alt="Screen Shot 2020-02-02 at 5 36 17 PM" src="https://user-images.githubusercontent.com/53151022/73618145-b7fda400-45e2-11ea-8d77-970999aedbfa.png">

##### Customer Endpoints
* `/customers` -> list of all customers.
* `/customers/:customer_id` -> single customer.
* `/customers/random` -> a random single customer.
* `/customers/:id/invoices` -> returns a collection of associated invoices.
* `/customers/:id/transactions` -> returns a collection of associated transactions.
* `/customers/:id/favorite_merchant` -> returns a merchant where the customer has conducted the most successful transactions.


* Find Endpoints
  * `/customers/find?id=`
  * `/customers/find?first_name=`
  * `/customers/find?last_name=`
  * `/customers/find?created_at=`
  * `/customers/find?updated_at=`


* Find All Endpoints
  * `/customers/find_all?id=`
  * `/customers/find_all?first_name=`
  * `/customers/find_all?last_name=`
  * `/customers/find_all?created_at=`
  * `/customers/find_all?updated_at=`

##### Invoice Item Endpoints
* `/invoice_items` -> list of all invoice items.
* `/invoice_items/:invoice_item_id` -> single invoice item.
* `/invoice_items/random` -> a random single invoice item.
* `/invoice_items/:id/invoice` -> returns the associated invoice.
* `/invoice_items/:id/item` -> returns the associated item.


* Find Endpoints
  * `/invoice_items/find?id=`
  * `/invoice_items/find?quantity=`
  * `/invoice_items/find?unit_price=`
  * `/invoice_items/find?item_id=`
  * `/invoice_items/find?invoice_id=`
  * `/invoice_items/find?created_at=`
  * `/invoice_items/find?updated_at=`


* Find All Endpoints  
  * `/invoice_items/find_all?id`
  * `/invoice_items/find_all?quantity`
  * `/invoice_items/find_all?unit_price=`
  * `/invoice_items/find_all?invoice_id`
  * `/invoice_items/find_all?item_id=`
  * `/invoice_items/find_all?created_at`
  * `/invoice_items/find_all?updated_at`

##### Invoice Endpoints
* `/invoices` -> list of all invoices.
* `/invoices/:invoice_id` -> single invoice.
* `/invoices/random` -> a random single invoice.
* `/invoices/:id/transactions` -> returns a collection of associated transactions.
* `/invoices/:id/invoice_items` -> returns a collection of associated invoice items.
* `/invoices/:id/items` -> returns a collection of associated items.
* `/invoices/:id/customer` -> returns the associated customer.
* `/invoices/:id/merchant` -> returns the associated merchant.


* Find Endpoints
  * `/invoices/find?id=`
  * `/invoices/find?status=`
  * `/invoices/find?customer_id=`
  * `/invoices/find?merchant_id=`
  * `/invoices/find?created_at=`
  * `/invoices/find?updated_at=`


* Find All Endpoints
  * `/invoices/find_all?id=`
  * `/invoices/find_all?status=`
  * `/invoices/find_all?customer_id=`
  * `/invoices/find_all?merchant_id=`
  * `/invoices/find_all?created_at=`
  * `/invoices/find_all?updated_at=`

##### Item Endpoints
* `/items` -> list of all items.
* `/items/:item_id` -> single item.
* `/items/random` -> a random single item.
* `/items/:id/invoice_items` -> returns a collection of associated invoice items.
* `/items/:id/merchant` -> returns the associated merchant.
* `/items/most_revenue?quantity=x` -> returns the top `x` items ranked by total revenue generated.
* `/items/:id/best_day` -> returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.


* Find Endpoints
  * `/items/find?id=`
  * `/items/find?name=`
  * `/items/find?description=`
  * `/items/find?unit_price=`
  * `/items/find?merchant_id=`
  * `/items/find?created_at=`
  * `/items/find?updated_at=`


* Find All Endpoints
  * `/items/find_all?id=`
  * `/items/find_all?name=`
  * `/items/find_all?description=`
  * `/items/find_all?unit_price=`
  * `/items/find_all?merchant_id=`
  * `/items/find_all?created_at=`
  * `/items/find_all?updated_at=`

##### Merchant Endpoints
* `/merchants` -> list of all merchants.
* `/merchants/:merchant_id` -> single merchant.
* `/merchants/random` -> a random single merchant.
* `/merchants/:id/items` -> returns a collection of items associated with that merchant.
* `/merchants/:id/invoices` -> returns a collection of invoices associated with that merchant from their known orders.
* `/merchants/most_revenue?quantity=x` -> returns the top `x` merchants ranked by total revenue.
* `/merchants/revenue?date=x` -> returns the total revenue for date `x` across all merchants.
  - *note*: Date should be entered as `YYYY-MM-DD`.
* `/merchants/:id/favorite_customer` -> returns the customer who has conducted the most total number of successful transactions.


* Find Endpoints
  * `/merchants/find?id=`
  * `/merchants/find?name=`
  * `/merchants/find?created_at=`
  * `/merchants/find?updated_at=`


* Find All Endpoints
  * `/merchants/find_all?id=`  
  * `/merchants/find_all?name=`  
  * `/merchants/find_all?updated_at=`
  * `/merchants/find_all?created_at=`  

##### Transaction Endpoints
* `/transactions` -> list of all transactions.
* `/transactions/:transaction_id` -> single transaction.
* `/transactions/random` -> a random single transaction.
* `/transactions/:id/invoice` -> returns the associated invoice.


* Find Endpoints
  * `/transactions/find?id=`
  * `/transactions/find?credit_card_number=`
  * `/transactions/find?result=`
  * `/transactions/find?invoice_id=`
  * `/transactions/find?created_at=`
  * `/transactions/find?updated_at=`


* Find All Endpoints
  * `/transactions/find_all?id=`  
  * `/transactions/find_all?credit_card_number=`
  * `/transactions/find_all?result=`  
  * `/transactions/find_all?invoice_id=`  
  * `/transactions/find_all?created_at=`
  * `/transactions/find_all?updated_at=`
