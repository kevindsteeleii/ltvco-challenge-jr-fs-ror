# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Install/Update Gems

    docker-compose run short-app bundle install

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# Explanation of URL shortening algorithm

The algorithm used to shorten the urls was very straight forward. 
Since there are a total of 62 alphanumeric characters including capital and lowercase letters in the "CHARACTERS" array, I wanted to map these somehow using a unique attribute of ShortUrl. I used the following steps:
1. converted the unique base10 id of a given short_url into a base62 number, I used **#digits** which outputs a converted number in a given base to an arrray of each converted digit in ascending order. Example below:
```ruby
    # convert 8 (base10) to base2 array in ascending order
    base2_convert = 8.digits(2) # 8 in binary is 1000
    binary8_desc_arr = 1000.to_s.split("").map(&:to_i) # converts 1000 to string to array of strings and then maps each element back to an integer

    # doesn't raise error b/c they're equal, returns nil
    raise "array [1,0,0,0] not equal to binary8_desc_arr" unless [1,0,0,0] == binary8_desc_arr

    # doesn't raise error b/c they're equal, returns nil
    raise "base2_convert is equal to binary8_desc_arr" unless [0,0,0,1] == base2_convert

    # doesn't raise error b/c they're not equal, returns nil
    raise "base2_convert is equal to binary8_desc_arr" unless binary8_desc_arr != base2_convert
```
2. I then mapped each base62 digit to its value in CHARACTERS based off of matching the index with the base62 digit (ex: 20 -> "k")
3. because the array was in ascending order (ex: 10.digits(10) -> [0, 1] not [1, 0]), I had to reverse it before joining it into a string, I also had to reverse the shortened url to decode it back to its id as well