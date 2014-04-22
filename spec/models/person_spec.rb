require 'spec_helper'

describe HighriseIntegration do
  
  let!(:user) { User.create!(email: 'test1021@email.com', 
                             password: 'password123', 
                             highrise_url: 'https//test.highrisehq.com',
                             highrise_token: '111') }
  
  let!(:person) { Person.create!({ name: "TestName", 
                                   user_id: user.id, 
                                   last_name: "TestLastName", 
                                   job_title: "TestTitle", 
                                   company: "TestCompany",
                                   email: "TestEmail@email.com",
                                   phone: "TestPhone",
                                   website: "TestWebsite"})}

  describe Person, "#highrise_hash" do
    it "builds person hash successfully" do
      
      highrise_hash = {
        :first_name => "TestName", 
        :last_name => "TestLastName",
        :company_name => "TestCompany",
        :title => "TestTitle",
        :contact_data => {
          :email_addresses => [
            :email_address => {:address => "TestEmail@email.com"}
          ],
          :phone_numbers => [
            :phone_number => {:number => "TestPhone", :location => "Other"}
          ],
          :web_addresses => [
            :web_address => {:url => "TestWebsite", :location => "Other"}
          ]
        }
      }
      expect(person.highrise_hash).to eq(highrise_hash)
    end
  end
end