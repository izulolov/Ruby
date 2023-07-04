require_relative 'train'
class CargoTrain < Train
  def initialize(train_number, type = 'Cargo')
    super(train_number, 'Cargo')
  end

  # Добавлять вагон типа Cargo(грузовой)
  def add_wagon(wagon)
    if wagon.type == 'Cargo'
      super(wagon)
    else
      puts 'Ты дурак что-ли?! К грузому поезду можно только грузовые вагоны прикреплять!'
    end
  end
end
