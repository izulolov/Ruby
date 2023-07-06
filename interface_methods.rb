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

  # Создать маршрут
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

  # Редактировать маршрут
  def edit_route
    if !@routes.empty?
      puts 'Выберите маршрут из списка ниже которую хотите редактировать (добавить/удалить станцию)'
      @routes.each_with_index { |route, index| puts "#{index + 1} -> #{route.first_station.station_name} - #{route.last_station.station_name}" }
      rt = gets.chomp.to_i
      if rt.between?(1, @routes.length)
        puts "Вы выбрали маршрут #{@routes[rt - 1].first_station.station_name} - #{@routes[rt - 1].last_station.station_name }"
        puts 'Введите 1 чтобы добавить станцию, 2 - удалить'
        select = gets.chomp.to_i
        case select
          when 1
            puts 'Доступны следующие станции для добавления. Введите название станции из списка.'
            @stations.each_with_index { |station, index| puts "#{index + 1} -> #{station.station_name}" }
            name = gets.chomp
            st = @stations.detect { |station| station.station_name == name }
            if !st.nil?
              @routes[rt - 1].add_station(st)
              puts "Добавлена станция: #{st.station_name}"
            else
              puts "Ошибка! Не нашли станцию #{name}. Попробуйте заново"
            end
          when 2
            puts 'Какую станцию удалить? Введите название станции. Выберите из списка ниже:'
            @routes[rt - 1].route_stations_list
            name = gets.chomp
            st = @stations.detect { |station| station.station_name == name }
            if !st.nil?
              @routes[rt - 1].delete_station(st)
            else
              puts "Ошибка! Не нашли станцию #{name} для удаления. Попробуйте заново."
            end
          else
            puts 'Маршрут остался без изменения! Надо было выбрать 1 или 2'
        end
      else
        puts 'Ошибка! Неправильно ввели индекс маршрута. Попробуйте заново.'
      end
    else
      puts 'Сначала надо создать маршрут!'
    end
  end

  # Назначать маршрут поезду
  def train_route
    if @trains.empty?
      puts 'Сначала надо создать поезд'
    elsif @routes.empty?
      puts 'Сначала надо создать маршрут'
    else
      puts 'Выберите в какой маршрут хотите назначить поезд(введите индекс):'
      @routes.each_with_index { |route, index| puts "#{index + 1} -> #{route.first_station.station_name} - #{route.last_station.station_name}" }
      rt = gets.chomp.to_i
      if rt.between?(1, @routes.length)
        puts "Выберите какой поезд назначить на маршрут: #{@routes[rt - 1].first_station.station_name} - #{@routes[rt - 1].last_station.station_name} (введите номер поезда):"
        @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number}" }
        number = gets.chomp
        tr = @trains.detect { |train| train.train_number == number }
        if !tr.nil?
          tr.take_route(@routes[rt - 1])
        else
          puts 'Ошибка! Неправильно номер поезда!. Попробуйте еще раз'
        end
      else
        puts "Ошибка! Не нашли маршрут с индексом #{rt}. Попробуйте еще раз."
      end
    end
  end

  # Добавлять/удалять вагоны к поезду
  # Добавить вагон
  def add_wagon
    if @trains.empty?
      puts 'Сначала необходимо создать поезд'
    else
      puts 'К какому поезду добавить вагон? (введите номер)'
      number = gets.chomp
      train = @trains.detect { |train| train.train_number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        train.add_wagon(WAGON_TYPES[train.train_type].new)
        puts "Теперь у поезда #{train.train_number} #{train.wagon_count} вагонов"
      end
    end
  end

  # Удалить вагон
  def delet_wagon
    if @trains.empty?
      puts 'Сначала необходимо создать поезд'
    else
      puts 'От какого поезда оцепить вагон? (введите номер)'
      number = gets.chomp
      train = @trains.detect { |train| train.train_number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      elsif train.all_wagon.empty?
        puts 'У этого поезда и так нет вагонов'
      else
        train.remove_wagon
        puts "Теперь у поезда #{train.train_number} #{train.wagon_count} вагонов"
      end
    end
  end

  # Перемещать поезд по маршруту вперед и назад
  def move_to_next_or_prev_station
    puts 'Какими поездами вы можете двигать(то есть каким поездам назначено станция):'
    @stations.each_index { |index| @stations[index].trains.each { |train| puts "На станции #{@stations[index].station_name} - поезд с номером № #{train.train_number}"}}
    puts 'Какой поезд хотите двигать? (введите номер)'
    number = gets.chomp
    train = @trains.detect { |train| train.train_number == number }
    if train.nil?
      puts 'Поезда с таким номером нет'
    else
      puts 'Выбрите 1 для впред, 2 для назад'
      move = gets.chomp.to_i
      case move
        when 1 # Вперед
          train.forward_train
        when 2 # Назад
          train.backward_train
        else
          puts 'Надо было выбрать 1 или 2'
      end
    end
  end

  # Просматривать список станций и список поездов на станции
  # Список станции
  def list_station
    if @stations.empty?
      puts 'Сначала надо создать станцию!'
    else
      puts 'Все станции:'
      @stations.each { |station| puts station.station_name }
    end
  end

  # Поезда на станции
  def trains_in_station
    if @stations.empty?
      puts 'Сначала надо создать станцию!'
    else
      puts 'На какой станции?:'
      name = gets.chomp
      station = @stations.detect { |st| st.station_name == name }
      if station.nil?
        puts 'Такой станции нет'
      elsif station.trains.length.positive?
        station.return_train_on_station
      else
        puts "На станции #{station.station_name} поездов нет!"
      end
    end
  end
end
