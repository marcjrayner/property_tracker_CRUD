require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @id = options['id'].to_i if options['id']
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'DELETE FROM properties WHERE id = $1;'
    value = [@id]
    db.prepare('delete', sql)
    db.exec_prepared('delete', value)
    db.close()
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'INSERT INTO properties(
      address,
      value,
      number_of_bedrooms,
      year_built
    ) VALUES
    ($1, $2, $3, $4)
    RETURNING *;'
    values = [@address, @value, @number_of_bedrooms, @year_built]
    db.prepare('save', sql)
    result = db.exec_prepared('save', values)
    @id = result[0]['id'].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'UPDATE properties
    SET
    (
      address,
      value,
      number_of_bedrooms,
      year_built
    ) = (
      $1, $2, $3, $4
      ) WHERE id = $5;'
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def Property.delete_all
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'DELETE FROM properties;'
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all')
    db.close
  end

  def Property.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'SELECT * FROM properties;'
    db.prepare('all', sql)
    result = db.exec_prepared('all')
    db.close
    return result.map {|property| Property.new(property)}
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'SELECT * FROM properties WHERE id = $1;'
    db.prepare('find_by_id', sql)
    value = [id]
    result = db.exec_prepared('find_by_id', value)
    db.close()
    return Property.new(result.first())
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = 'SELECT * FROM properties WHERE address = $1;'
    db.prepare('find_by_address', sql)
    value = [address]
    result = db.exec_prepared('find_by_address', value)
    db.close()
    return Property.new(result.first())
  end



end
