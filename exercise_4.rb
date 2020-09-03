# Класс Station (Станция):

class Station

  # Имеет название, которое указывается при ее создании

  def initialize(station_name)
    @station_name = station_name
  end

  # Может принимать поезда (по одному за раз)

  def add_train(train)
    @trains << train
  end

  # Может возвращать список всех поездов на станции, находящиеся в текущий момент

  def show_trains
    @trains.each { |train| puts train }
  end

  # Может возвращать список поездов на станции по типу (см. ниже): кол-во
  # грузовых, пассажирских

  def show_trains_by_type
    puts cargo_num
    puts passenger_num
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка
  # поездов, находящихся на станции).

  def departure(train)
    @trains.drop(train)
  end
end

# Класс Route (Маршрут):


# Может добавлять промежуточную станцию в список

# Может выводить список всех станций по-порядку от начальной до конечной

class Route

  # Имеет начальную и конечную станцию, а также список промежуточных станций.
  # Начальная и конечная станции указываютсся при создании маршрута,

  def initialize (start_point, end_point)
    @start_point = start_point
    @end_point  = end_point
  end

  # а промежуточные могут добавляться между ними.

  def add_point(point)
    @points << point
  end

  # Может удалять промежуточную станцию из списка

  def delete_point(point)
    @points.drop(point)
  end

  def show_points
    puts @start_point
    puts @points
    puts @end_point
  end

end

# Класс Train (Поезд):






# Может принимать маршрут следования (объект класса Route).
# При назначении маршрута поезду, поезд автоматически помещается на первую
#   станцию в маршруте.
# Может перемещаться между станциями, указанными в маршруте. Перемещение
#   возможно вперед и назад, но только на 1 станцию за раз.
# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество
  # вагонов, эти данные указываются при создании экземпляра класса
  attr_reader :speed

  # Может возвращать количество вагонов
  attr_reader :number_of_wagons

  attr_accessor :route

  def initialize(number, type, number_of_wagons)
    @number = number_of_wagons
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  # Может набирать скорость

  def speed_up(speed)
    @speed += speed
  end

  # Может тормозить (сбрасывать скорость до нуля)

  def stop
    @speed = 0
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод
  # просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка
  # вагонов может осуществляться только если поезд не движется.

  def attach
    @number_of_wagons += 1 if @speed == 0
  end

  def detach
    @number_of_wagons -= 1 if @speed == 0
  end

  def set_route

  end


end


