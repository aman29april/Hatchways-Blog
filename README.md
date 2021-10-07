## Empower Health, Hatchways Challenge - Backend Assessment - Blog Posts

This is API only Ruby on Rails based application solution to Empower Health, hatchways 's [Backend Assessment - Blog Posts](https://storage.googleapis.com/hatchways-app.appspot.com/assessments/data/instructions/b-3/Back-end%20Assessment%20-%20Blog%20Posts-TZW3TH2D4VFVDPKH4D6C.pdf) challenge.

### Live Demo
Live demo can be found at https://stormy-beyond-46831.herokuapp.com/

### Tech Stack
* Ruby (3.0.2)
* Rails (6.1.4)

### Running Locally
Make sure above requirements are fulfilled before running this application.

`git clone blog-api.bundle` **Extract bundle file**

Navigate to project directory and follow following commands

`bundle install` will install all the required gems.

`rake db:create` to create database (Though we don't need db for this app. As i didn't skip active record/db installation on new app creation, It is needed due to dependency.)

`rails server` Rails Server will start and you can visit `localhost:3000` in your web browser.

### Running Tests
Run `rails spec` command from project folder.

#Design
- `PostController` is doing param validations and return error message if params are not in correct format.
- `PostService` is responsible for calling external api, transform the results and return back.
    - The Service take `tags` and transformer as input parameters 
    - API response are `cached`, key is the tag with expiry of `1 day`
    - To merge response of multiple tags, I am using `hash` as data structure. Post id is the key used. 
      - Hash has search with constant order, hence its efficient to find if we have already included the post in output.
- `PostSortTransformer` is used to transform (`sort`) the external api response
- For `Caching`, I am using Rails cache to store the output of the external API.
  - Right now the cache store is default store. We can changed it to Redis, Memcache or any other.
- Used `Rspec` for testing the API response
  - To verify the response when parameters passed are correct, I am checking the response code and the sort order of the values.
      

##Checklist

**All points mentioned have been covered in the submission**

-[x] ~~An /api/posts route that handles the following query parameters:~~
    -[x] tags (mandatory) : any number of comma-separated strings
    -[x] sortBy (optional) : one of “id”, “reads”, “likes”, “popularity”
    -[x] direction (optional) : one of “asc”, “desc”, defaults to “asc”
-[x] ~~Error handling: Return an error message if:~~
    -[x] tags parameter is missing
    -[x] sortBy or direction has an invalid value
-[x] ~~Testing without using our solution API route~~
-[x] ~~Caching (bonus)~~