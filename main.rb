# Класс Station (Станция):
class Station
  attr_reader :station_name, :trains
  def initialize(station_name)
    @station_name = station_name
    @trains = []
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
    @trains.select { |train| puts "#{train.train_number} - #{train.train_type} - #{train.number_wagons}" if train.train_type == type}
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    @trains.delete(train)
  end
end

# Класс Station (Станция):
class Route
  attr_reader :route_stations
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route_stations = [@first_station, @last_station] # Массив с всеми станциями
  end

  # Может добавлять промежуточную станцию в список
  def add_station(station)
    @route_stations.insert(1, station)
  end

  # Может удалять промежуточную станцию из списка
  def delete_station(station)
    @route_stations.delete(station)
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def route_stations_list
    @route_stations.each_with_index { |st, i| puts "#{i + 1} - #{st.station_name}" }
  end
end

# Класс Train (Поезд):
class Train
  attr_reader :train_number, :train_type, :number_wagons
  def initialize(train_number, train_type, number_wagons)
    @train_number = train_number
    @train_type = train_type
    @number_wagons = number_wagons
    @speed = 0
    @route = nil
    @station_index = nil
  end

  # Может набирать скорость
  def up_speed(speed)
    @speed += speed
  end

  # Может возвращать текущую скорость
  def current_speed
    @speed
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  # Может возвращать количество вагонов
  def return_number_wagons
    @number_wagons
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon
    if current_speed.zero?
      @number_wagons += 1
    else
      puts 'Находу прицелять вагоны нельзя'
    end
  end

  def remove_wagon
    if current_speed.zero?
      @number_wagons -= 1
    else
      puts 'Находу отцеплять вагоны нельзя'
    end
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def take_route(route)
    @route = route
    @station_index = 0
    #@route.route_stations[0].take_train(self)
    current_station.take_train(self)
  end

  # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  # Текущая станция
  def current_station
    @route.route_stations[@station_index]
  end
  # Следующая станция
  def next_station
    @route.route_stations[@station_index + 1]
  end
  # Предедущая станция
  def previos_station
    @route.route_stations[@station_index - 1]
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  # Вперед
  def forward_train
    current_station.send_train(self)
    @station_index += 1
    current_station.take_train(self)
  end
  # Назад
  def backward_train
    current_station.send_train(self)
    @station_index -= 1
    current_station.take_train(self)
  end
end

st1 = Station.new('Kal')
st2 = Station.new('Din')
st3 = Station.new('Lat')

rt1 = Route.new(st1, st2)

tr1 = Train.new(2520, 'Passenger', 15)
tr2 = Train.new(3770, 'Cargo', 18)

tr1.take_route(rt1)
tr1.forward_train

puts tr1.current_station.station_name

tr1.backward_train

puts tr1.current_station.station_name
