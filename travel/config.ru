require './config/environment'

use Rack::MethodOverride
use CountriesController 
use DestinationsController  
use UsersController   
run ApplicationController