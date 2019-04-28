# dockerized_wkhtmltox
dockerized wkhtmltox for use in dockerized rails projects

## why do you need sutch a thing?
Current `ruby` image (which is usually used for dockerized rails projects) is built debian version which does not play nicely with wkhtmltox, e.g. if you want to generate some image (*.png, *.jpg, etc.) from your Rails app, you will usually find that `gem 'imgkit'` is the tool to use, but it depends on wkhtmltox which wont be happy inside container (some incompatible jpeg libraries at time of creation) created from available ruby image.

## temporary solution - *this docker image*
the most enduring kind of solutions - temporary one...
### *1st step*
add this line to your `Dockerfile` around same time when you create your application folder:
```Dockerfile
# make direcory to mount wkhtmltox bin files
RUN mkdir /wkhtmltox
```
### *2nd step*
modify this snippet into your `docker-compose.yml`:
```yaml
version: '3'
services:
  web:
    build: .
    volumes:
      - wkhtmltox-volume:/wkhtmltox

  wkhtmltox:
    image: martinskruze/dockerized_wkhtmltox
     volumes:
       - wkhtmltox-volume:/wkhtmltox_instalation/wkhtmltox/bin

volumes:
  wkhtmltox-volume:
```
### *3rd step*
add file `config/initializers/imgkit.rb`:
```ruby
IMGKit.configure do |config|
  config.wkhtmltoimage = '/wkhtmltox/wkhtmltoimage'
end
```
### *4th step*
have a beer for my suffering
