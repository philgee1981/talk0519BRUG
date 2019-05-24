# Getting Data from Coingecko
* In this talk, we try to be as interactive as possible, i.e. we can evaluate R-Code within shiny
* As most APIs, you can get nicely structured json-data from coingecko
* We are interested in relevant data for the Top 3 cryptocurrencies:
`https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page`
`=3&page=1&sparkline=true&price_change_percentage`
`=24h`
* For more information about the API refer to [https://www.coingecko.com/en/api]