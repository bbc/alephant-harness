$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'alephant/harness'
require 'alephant/harness/aws'
require 'alephant/harness/service/dynamo_db'
require 'aws-sdk'
