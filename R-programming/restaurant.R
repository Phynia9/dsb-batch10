#create a new restaurant database

library(RSQLite)
restaurant <- dbConnect(SQLite(), "restaurant.db")

dbListTables(restaurant)

customer <- data.frame(
  id = 1:5,
  names = c("Joe", "Anne", "Smith","Rose","Una")
)

dbRemoveTable(restaurant,"customer")

dbWriteTable(restaurant, "customer",
             data.frame(id = 1:5,
                        names = c("Joe", "Anne", "Smith","Rose","Una")))
dbListTables(restaurant)

dbGetQuery(restaurant, "select names from customer")

dbWriteTable(restaurant, "orders",
             data.frame(id = 1:5,
                        customer_id = 1:5,
                        menu_names = c("sandwich", "chicken rice", "pasta", "steak", "tuna salad"),
                        total_amount = c(12, 15, 18, 20, 15)))


orders <- data.frame( id = 1:5,
                     customer_id = 1:5,
                     names = c("Joe", "Anne", "Smith","Rose","Una"),
                     menu_names = c("sandwich", "chicken rice", "pasta", "steak", "tuna salad"),
                     order_date = c("2024-05-05", "2024-05-12", "2024-05-18","2024-06-12","2024-08-08"),
                     total_amount = c(12, 15, 18, 20, 15))

dbWriteTable(restaurant, "orders", orders)

dbGetQuery(restaurant, "select * from orders")

dbRemoveTable(restaurant, "orders")

dbDisconnect(restaurant)

