# Класс Station (Станция):
class Station
  attr_reader :station_name, :trains
  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  # Может принимать поезда (по одному за раз)
  def take_train(train)
    take_train!(train)
  end

  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  def return_train_on_station
    if exists_train_on_station?
      @trains.each { |train| puts "#{train.train_number} - #{train.train_type} - #{train.wagon_count}" }
    else
      puts "Поездов на станции #{self.station_name} нет! "
    end
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def return_train_by_type(type)
    if exists_train_on_station?
      @trains.select { |train| puts "#{train.train_number} - #{train.train_type} - #{train.number_wagons}" if train.train_type == type}
    else
      puts "Поездов типа #{type} на станции #{self.station_name} нет! "
    end
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def send_train(train)
    send_train!(train)
  end

  # Есть ли поезд на станции
  def exists_train_on_station?
    @trains.count.positive? ? true : false
  end

  private

  def take_train!(train)
    @trains << train
  end

  def send_train!(train)
    if !exists_train_on_station?
      puts "Поездов на станции #{self.station_name} нет, поэтому нечего отпралять!"
    elsif @trains.include?(train)
      @trains.delete(train)
    else
      puts "Такого поезда (№ #{train.train_number}) на станции #{self.station_name} нет!"
    end
  end
end
