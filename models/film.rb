require_relative('../db/sql_runner')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = 'INSERT into films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id'
    values = [@title, @price]
    film = SqlRunner.run( sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (
    title,
    price
    ) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_hashes = SqlRunner.run(sql, values)
    customers = customer_hashes.map { |customer_hash| Customer.new(customer_hash)}
    return customers
  end

  #class methods

  def self.all()
    sql = 'SELECT * FROM films'
    film_hashes = SqlRunner.run(sql)
    return Film.map_items(film_hashes)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(film_hashes)
    result = film_hashes.map {|film_hash| Film.new(film_hash)}
    return result
  end

end
