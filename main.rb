# Класс Station (Станция):
class Station
  def initialize(station_name)
    @station_name = station_name
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
  def initialize(train_number, type_of_train, number_of_wagon)
    @train_number = train_number
    @type_of_train = type_of_train
    @number_of_wagon = number_of_wagon
  end
end
