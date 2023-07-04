require_relative 'train'
class PassengerTrain < Train
  def initialize(train_number, type = 'Passenger')
    super(train_number, 'Passenger')
  end

  # Добавлять вагон типа Passenger
  def add_wagon(wagon)
    if wagon.type == 'Passenger'
      super(wagon)
    else
      puts 'Ты дурак что-ли?! К пассажирскому поезду можно только пассажирские вагоны прикреплять!'
    end
  end
end
