# Payload WS

## Setup

* **Clone the project from the repo**
	
	> SSH version: `git clone git@github.com:GenaroLegaspiJr/payload-ws.git`

	> HTTPS version: `git clone https://github.com/GenaroLegaspiJr/payload-ws.git` 

* **Go to project Directory**
	`cd payload-ws`

* **Bundle Install Gem**
	`bundle install`

* **Create Database and Run Migration**
	`bundle exec rake db:create`
	`bundle exec rake db:migrate`

* **Run the project**
	`bundle exec rails s`



## To test the API manually

* **Install Postman first or any preferred platform to test an API**
	
	> You can download Postman here https://www.postman.com/downloads/

* **See the video from the link below on how to test the API on Postman. Postman collection included on the link** *
	
	>https://drive.google.com/drive/folders/1Sw8zTsIALtqR06pkAUZXjQbDKvZIKYka?usp=sharing



## To test the API via Rspec

* **Run this command** *

	> This is called an integration `rspec spec/controllers/api/v1/reservations_controller_spec.rb`


* **To run all test(unit and integration test)** *

	`rspec`

* **To specific test** *

	`rspec spec/path/to/test/file`