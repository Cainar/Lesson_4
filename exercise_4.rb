# Класс Station (Станция):

class Station

  attr_reader :trains, :station_name

  # Имеет название, которое указывается при ее создании

  def initialize(station_name)
    @station_name = station_name
    @trains = []

  end

  # Может принимать поезда (по одному за раз)

  def add_train(train)
    @trains << train
  end

  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  # --- есть attr_reader на :trains, снёс метод show_trains
  # Может возвращать список поездов на станции по типу (см. ниже): кол-во
  # грузовых, пассажирских

  #--- убрал puts-ы, создал хэш

  def show_trains_by_type
    @cargo =  @trains.count { |train| train.type == 'cargo'}
    @passenger =  @trains.count { |train| train.type == 'passenger'}
    @trains_by_type = {
      cargo: @cargo,
      passenger: @passenger
    }
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка
  # поездов, находящихся на станции).

  def departure(train)
    @trains.delete(train)
  end
end

# Класс Route (Маршрут):


# Может добавлять промежуточную станцию в список

# Может выводить список всех станций по-порядку от начальной до конечной

class Route

# --- point переименовал в station

  attr_reader :start_station, :end_station, :stations
  # Имеет начальную и конечную станцию, а также список промежуточных станций.
  # Начальная и конечная станции указываютсся при создании маршрута,

  def initialize (start_station, end_station)
    @start_station = start_station
    @end_station  = end_station
    @stations = []
    @stations << @start_station
    @stations << @end_station
  end

  # а промежуточные могут добавляться между ними.

  def add_station(station)
    @stations.shift && @stations.pop
    @stations << station
    @stations.unshift(@start_station) && @stations.push(@end_station)
  end

  # Может удалять промежуточную станцию из списка
  #--- оператор === заменил на ==

  def delete_station(station)
    @stations.delete(station) unless station == @stations.first || station == @stations.last
  end

# --- закоментировал, есть attr_reader на stations
=begin
  def show_route
    @stations.each.with_index(1) { |station, index| puts "Станция - #{index}: #{station.station_name}" }
  end
=end

end

# Класс Train (Поезд):

# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train

  # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество
  # вагонов, эти данные указываются при создании экземпляра класса
  attr_reader :speed, :number_of_wagons, :route, :number, :type

  # Может возвращать количество вагонов

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
    @route = nil
  end

  # Может набирать скорость

  def speed_up(speed)
    @speed += speed if speed > 0
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
    @number_of_wagons -= 1 if @speed == 0 && self.number_of_wagons > 0
  end

  # Может принимать маршрут следования (объект класса Route).
  # При назначении маршрута поезду, поезд автоматически помещается на первую
  #   станцию в маршруте.

  def set_route(route)
    @route = route
    @route.start_station.add_train(self) if !@route.start_station.trains.include?(self)
  end


  # Может перемещаться между станциями, указанными в маршруте. Перемещение
  #   возможно вперед и назад, но только на 1 станцию за раз.

  def move_forward
        @route.stations.each_with_index do |station, index|
          if station.trains.include?(self) && station != @route.stations.last
            station.departure(self)
            @route.stations[index + 1].add_train(self)
            puts "Следующая: #{@route.stations[index + 2].station_name}" unless @route.stations[index + 2].nil?
            puts "Текущая: #{@route.stations[index + 1].station_name} <-- "
            puts "Предыдущая: #{@route.stations[index].station_name}" unless @route.stations[index].nil?
            break
          end
        end
  end

  def move_backward
        @route.stations.each_with_index do |station, index|
          if station.trains.include?(self) && station != @route.stations.first
            station.departure(self)
            @route.stations[index - 1].add_train(self)
            puts "Следующая: #{@route.stations[index - 2].station_name}" unless @route.stations[index - 2].nil?
            puts "Текущая: #{@route.stations[index - 1].station_name} <-- "
            puts "Предыдущая: #{@route.stations[index].station_name}" unless @route.stations[index].nil?
            break
          end
        end
  end



end

=begin Для проверки, чтобы в ручную не писать.

s1 = Station.new('Moscow')
s2 = Station.new('Arkhangelsk')
s3 = Station.new('Voronezh')
s4 = Station.new('Dubna')
s5 = Station.new('Kursk')
s6 = Station.new('Lipetsk')
s7 = Station.new('Nizhny Novgorod')
s8 = Station.new('Oryol')
s9 = Station.new('Penza')
s10 = Station.new('Ryazan')
s11 = Station.new('Saint Petersburg')
s12 = Station.new('Tambov')
s13 = Station.new('Tver')
s14 = Station.new('Tula')
s15 = Station.new('Chelyabinsk')
s16 = Station.new('Elista')
s17 = Station.new('Yaroslavl')

r1 = Route.new(s1, s4)
r2 = Route.new(s5, s8)
r3 = Route.new(s9, s13)
r4 = Route.new(s14, s17)


# cargo passenger

t1 = Train.new('0001', 'passenger', 5)
t2 = Train.new('0002', 'passenger', 10)
t3 = Train.new('0003', 'passenger', 7)
t4 = Train.new('0004', 'cargo', 20)
t5 = Train.new('0005', 'cargo', 15)
t6 = Train.new('0006', 'cargo', 32)

t1.set_route(r1)

=end



