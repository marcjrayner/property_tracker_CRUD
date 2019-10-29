require('pry-byebug')
require_relative('./models/property_tracker.rb')

Property.delete_all()

property1 = Property.new({
  'address' => '10 Downing Street',
  'value' => 1000000,
  'number_of_bedrooms' => 10,
  'year_built' => 1863
})

property2 = Property.new({
  'address' => '10 Castle Street',
  'value' => 2000000,
  'number_of_bedrooms' => 5,
  'year_built' => 1800
})

property1.save()
property2.save()

properties = Property.all()



binding pry

nil
