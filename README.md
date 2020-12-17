# iSeatz Zomato Phase 1

## How to run locally

#### 1. Git clone repository.

#### 2. Cd into folder.

#### 3. Run 'bundle install' to install gems.

#### 4. Run 'rails s' to start server.

#### 5. Make requests through Postman

###

## Available routes:

### /city_cuisines

#### What parameters does this route need?

    1. "api_key" that is recieved from the Zomato api.
    2. "city_name" which is any city name.

#### What does this route return?

    This route returns a JSON object with two keys.
        1. "city_info" is an object with informtion on the city you passed in as a parameter.
        2. "cuisines" which is an array of objects.containing each individual cuisine name and it's id.

### /cuisine_daily_menus

#### What parameters does this route need?

    1. "api_key" that is recieved from the Zomato api.
    2. "city_id" the city's id returned in "city_info" from the /city_cuisines route.
    3. "cuisine_id" the cuisine id that is returned from the /city_cuisines route for the cuisine that you would like daily menus for.

#### What does this route return?

    This route returns a JSON object with 1 key.
        1. "menus" is an array with up to 3 of the first daily menus found.
