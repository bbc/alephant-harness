$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'alephant/harness'
require 'alephant/harness/aws'
require 'alephant/harness/service/dynamo_db'
require 'alephant/harness/service/s3'
require 'alephant/harness/service/sqs'
require 'aws-sdk'
require 'thor'
require 'alephant/harness/tools/helper/component'
require 'alephant/harness/tools/helper/sequence'
