require_relative 'interface_methods'

class Interface
  def run
    interface_method_object = InterfaceMethod.new

    loop do
      interface_method_object.menus
      print 'Введите номер команды: '
      select = gets.chomp.to_i
      case select

      # Выход
      when 0
        puts 'До новых встреч!'
        break

      # Создать станцию
      when 1
        interface_method_object.create_station

      # Создать поезд
      when 2
        interface_method_object.create_train

      # Создать маршрут
      when 3
        interface_method_object.create_route
      else
        puts 'Надо выбрать один из предложенных вариантов!'
      end
    end
  end
end
