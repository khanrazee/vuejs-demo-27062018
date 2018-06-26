#### Welcome to Rails Demo VUEJS App

This is a sample Rails App with Vue JS. It create a request object and sends a call to a AWS-Lambda function which then sends a POST message to URL.

###### Getting Started

1. After cloning, run the following:
       <tt>rake db:create</tt> (Make sure to change your config/database.yml as per your credentials.)

2. After DB creation Run:
       <tt>rake db:migrate</tt>
3. After DB migration, go to config and use the command cp application.yml.example application.yml:
       <tt>Add AWS credentials as in the application.yml file</tt>

4. Go to http://localhost:3000/ and you'll see the basic Crud:
       "Done"

