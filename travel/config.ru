require './config/environment'

use Rack::MethodOverride
use DestinationsController  
use UsersController   
run ApplicationController