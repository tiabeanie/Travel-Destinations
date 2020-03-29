require './config/environment'

use Rack::MethodOverride
use DestinationsController 
use CountriesController 
use UsersController   
run ApplicationController