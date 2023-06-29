# Класс Station (Станция):
class Station
  attr_reader :trains
  def initialize(station_name)
    @station_name = station_name
    @trains  = []
  end

  # Может принимать поезда (по одному за раз)
  def take_train(train)
    @trains << train
  end

  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  def return_train_on_station
    @trains.each { |train| puts "#{train.train_number} - #{train.train_type} - #{train.number_wagons}" }
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def return_train_by_type(type)
    @trains.each { |train| puts "#{train.train_number} - #{train.train_type} - #{train.number_wagons}" if train.train_type == type}
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    @trains.delete(train)
  end
end

# Класс Station (Станция):
class Route
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route_stations = [@first_station, @last_station] # Массив с всеми станциями
  end
end

# Класс Train (Поезд):
class Train
  attr_reader :train_number, :train_type, :number_wagons
  def initialize(train_number, train_type, number_wagons)
    @train_number = train_number
    @train_type = train_type
    @number_wagons = number_wagons
  end
end

st1 = Station.new('Kal')
st2 = Station.new('Din')
st3 = Station.new('Lat')

rt1 = Route.new(st1, st2)

tr1 = Train.new(2520, 'Passenger', 15)
tr2 = Train.new(3770, 'Cargo', 18)
st1.take_train(tr1)
st1.take_train(tr2)
puts 'Список поездов на станции:'
st1.return_train_on_station

puts 'Список поездов на станции  по типу'
st1.return_train_by_type('Passenger')

puts 'Может отправлять поезд'

puts st1.send_train(tr1).train_number

puts 'Список поездов на станции:'
st1.return_train_on_station
