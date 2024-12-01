docker-compose up

docker-compose run web bin/rails db:migrate

docker-compose run web bin/rails db:fixtures:load

docker-compose up
