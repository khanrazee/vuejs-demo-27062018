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
    aws = Aws::Lambda::Client.new( #if the server EC2 belongs to same security group then this can be removed, maybe add in Rails.env.production? condition in here to handle dev and prod separately.
        region: ENV['AWS_REGION'],
        access_key_id: ENV['AWS_ACCESS_KEY'],
        secret_access_key: ENV['AWS_SECRET_KEY']
    )
    resp = aws.invoke(function_name: 'makeUpworkRequest', payload: self.payload_data)
    resp.status_code == 200 ? completed! : failed! #can use lambda callback for this all to be sure the function completed successfully there also.
  end
end
