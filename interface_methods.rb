require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'

class InterfaceMethod
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  WAGON_TYPES = { 'Cargo' => CargoWagon, 'Passenger' => PassengerWagon }

  # Создать меню
  def menus
    puts 'Выберите команду:'
    puts %(    0. Выход
    1. Создать станцию    2. Создать поезд    3. Создать маршрут
    4. Добавлять или удалять станцию    5. Назначать маршрут поезду
    6. Добавлять вагоны к поезду    7. Отцеплять вагоны от поезда
    8. Перемещать поезд по маршруту вперед или назад    9. Просматривать список станций
    10. Cписок поездов на станции)
  end

  # Создавать станции
  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    if name.length >= 3
      @stations << Station.new(name)
      puts "Создана станция #{name}"
    else
      puts 'Ошибка! Название станции должна состоять хотябы из трех символов. Попробуйте еще раз'
    end
  end

  # Создавать поезда
  def create_train
    puts 'С каким номер создать поезд?'
    number = gets.chomp
    puts '1 - пассажирский, 2 - грузовой'
    select = gets.chomp.to_i
    case select
      when 1
        @trains << PassengerTrain.new(number)
        puts "Создан пассажирский поезд с номером: #{number}"
      when 2
        @trains << CargoTrain.new(number)
        puts "Создан грузовой поезд с номером: #{number}"
      else
        puts 'Поезд не создан! Введите 1 чтобы создать пассажирский, 2 для грузогого'
    end
  end

  # Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  def create_route
    if @stations.length < 2
      puts 'Чтобы создать маршрут нужно создать хотябы две станции'
    else
      puts %(Какой маршрут создать?
      Начальную и конечную станцию в маршруте можете выбрать из списка ниже.
      Для этого введите название станции:)
      @stations.each_with_index { |station, index| puts "#{index + 1} -> #{station.station_name}" }
      print 'Введите название начальной станции: '
      name1 = gets.chomp
      st1 = @stations.detect { |name| name.station_name == name1 }
      print 'Введите название конечной станции: '
      name2 = gets.chomp
      st2 = @stations.detect { |name| name.station_name == name2 }
      if st1.nil? || st2.nil?
        puts 'Ошибка! Проверьте правильно ли ввели название станции. Попробуйте заново.'
      else
        @routes << Route.new(st1, st2)
        puts "Создан маршрут #{st1.station_name} - #{st2.station_name}"
      end
    end
  end

  # Назначать маршрут поезду
  
  # Добавлять вагоны к поезду
  # Отцеплять вагоны от поезда
  # Перемещать поезд по маршруту вперед и назад
  # Просматривать список станций и список поездов на станции
end

