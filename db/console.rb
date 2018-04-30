require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')

require( 'pry' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Barry Hope', 'funds' => 100 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Jude Gaff', 'funds' => 150 })
customer2.save()
customer3 = Customer.new({ 'name' => 'Gerry Hill', 'funds' => 200})
customer3.save()
customer4 = Customer.new({ 'name' => 'Julie Tam', 'funds' => 70})
customer4.save()

film1 = Film.new({ 'title' => 'Shawshank Redemption', 'price' => 50 })
film1.save()
film2 = Film.new({ 'title' => 'Life', 'price' => 30 })
film2.save()
film3 = Film.new({ 'title' => 'Avengers', 'price' => 60})
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id })
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket4.save()
ticket5 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id })
ticket5.save()



binding.pry
nil
