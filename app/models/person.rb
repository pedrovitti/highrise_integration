class Person < ActiveRecord::Base
  belongs_to :user
   validates :name, :presence => true
   validates :email, :allow_blank => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    
  def send_to_highrise
    setup_highrise
    person = Highrise::Person.new(highrise_hash)
    person.save!
  end

  def setup_highrise
    Highrise::Base.site = self.user.highrise_url
    Highrise::Base.user = self.user.highrise_token
    Highrise::Base.format = :xml
  end 

  def highrise_hash
    return {
        :first_name => self.name, 
        :last_name => self.last_name,
        :title => self.job_title,
        :company_name => self.company, 
        :contact_data => {
           :email_addresses => [
            :email_address => { :address => self.email }
          ],
          :phone_numbers => [
            :phone_number => { :number => self.phone, :location => 'Other' }
          ],
          :web_addresses => [
            :web_address => { :url => self.website, :location => 'Other' }
          ]
        }
    }
  end   
end