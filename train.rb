# Класс Train (Поезд):
class Train
  attr_reader :train_number, :train_type, :wagon_count
  MAX_SPEED_TRAIN = 60.freeze
  def initialize(train_number, train_type)
    @train_number = train_number
    @train_type = train_type
    @all_wagon = []
    @wagon_count = 0
    @speed = 0
    @route = nil
    @station_index = nil
  end

  # Может набирать скорость
  def up_speed(speed)
    up_speed!(speed)
  end

  # Может возвращать текущую скорость
  def current_speed
    @speed
  end

  # Может тормозить (сбрасывать скорость до нуля)
  def stop
    stop!
  end

  # Может возвращать количество вагонов
  def return_number_wagons
    @number_wagons
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  # Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def add_wagon(wagon)
    add_wagon!(wagon)
  end

  def remove_wagon(wagon)
    remove_wagon!(wagon)
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def take_route(route)
    take_route!(route)
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
    forward_train!
  end

  # Назад
  def backward_train
    backward_train!
  end

  private

  def up_speed!(speed)
    @speed + speed <= MAX_SPEED_TRAIN ? @speed += speed : "В текущий момент можно увеличить скорость на #{MAX_SPEED_TRAIN - @speed} км/ч"
  end

  def stop!
    @speed = 0
  end

  def add_wagon!(wagon)
    if current_speed.zero?
      @wagon_count += 1
      @all_wagon << wagon
    else
      puts 'Находу прицелять вагоны нельзя'
    end
  end

  def remove_wagon!(wagon)
    if @all_wagon.include?(wagon)
      if current_speed.zero? && @wagon_count > 0
        @wagon_count -= 1
        @all_wagon.delete(wagon)
      else
        puts 'Находу оцеплять вагоны нельзя'
      end
    else
      puts "Не нашли такой вагон #{wagon} для удаления!"
    end
  end

  def take_route!(route)
    @route = route
    @station_index = 0
    #@route.route_stations[0].take_train(self)
    current_station.take_train(self)
  end

  # Вперед
  def forward_train!
    current_station.send_train(self)
    @station_index += 1
    current_station.take_train(self)
  end

  # Назад
  def backward_train!
    current_station.send_train(self)
    @station_index -= 1
    current_station.take_train(self)
  end
end
