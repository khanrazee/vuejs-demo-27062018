class UpworkRequest < ActiveRecord::Base
  validates :name, :email,:profile_url, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates_format_of :email, :with => /@/

  enum status: [:pending, :completed, :failed]

  after_create :invoke_lambda_function #Best to push this into the queue or better just invoke the lamdba directly from something like DynamoDB or something.

  require 'aws-sdk'


  def payload_data
    self.attributes.slice('name', 'email', 'profile_url', 'message').to_json
  end

  private
  def invoke_lambda_function
    aws = Aws::Lambda::Client.new(
        region: ENV['AWS_REGION'],
        access_key_id: ENV['AWS_ACCESS_KEY'],
        secret_access_key: ENV['AWS_SECRET_KEY']
    )
    resp = aws.invoke(function_name: 'makeUpworkRequest', payload: self.payload_data)

    #if resp is 200 then update status to completed! otherwise failed! or use callback from Lamdba to do this.
  end
end
