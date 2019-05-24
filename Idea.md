## Automatic, sentiment-driven generation of price information
* Fetching data from API
  * in this example: coingecko
  * getting information for top 3 cryptocurrencies about
    * current price
    * maximum/minimum price and trading volume in last 24 hours
    * relative price change within last 24 hours
    * hourly prices for last week
* Analysis, image- and textgeneration via R
  * Using snippet library to get variation in price movements' description
* Uploading images and publishing Posts on Wordpress
  * NOT using RWordpress for several reasons
* Hosting the whole code on Heroku  
  * Heroku is a cloud platform for small webapps
  * Scheduling recurring executions of our code