require_relative('../db/sql_runner')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = 'INSERT into customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id'
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (
    name,
    funds
    ) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    film_hashes = SqlRunner.run(sql, values)
    films = film_hashes.map { |film_hash| Film.new(film_hash)}
    return films
  end

  #class methods

  def self.all()
    sql = 'SELECT * FROM customers'
    customer_hashes = SqlRunner.run(sql)
    return Customer.map_items(customer_hashes)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(customer_hashes)
    result = customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
    return result
  end

end
