class HighriseWorker
  include Sidekiq::Worker

  def perform(url, token, person_id)
  	puts "Sending user data to Highrise"  
    person = Person.find(person_id)
    person.send_to_highrise
  end
end