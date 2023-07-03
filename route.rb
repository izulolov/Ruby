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
    if !@route_stations.include?(station)
      puts "Такой станции #{station.station_name} в списке нет!"
    elsif (station == @first_station || station == @last_station)
      puts 'Первую и последнюю станцию нельзя удалять!'
    else
      @route_stations.delete(station)
    end
  end

  # Может выводить список всех станций по-порядку от начальной до конечной
  def route_stations_list
    @route_stations.each_with_index { |st, i| puts "#{i + 1} - #{st.station_name}" }
  end
end
