# You want to be able to add fields of various types - for example, corn and wheat - and to keep track of the harvest.
# You will be keeping track of the total amount of food your farm has ever produced.
# corn: 20, wheat: 30
# You can add fields of choice to your farm by specifying their type (eg. "corn") and their total area in hectares (eg. 100).
# When you harvest, you must collect food from every one of your fields and record how much total food you have collected. Display all of this information.
# check the status of each field and total food.
# The program should provide a list of input options whenever it asks you to enter one.

class Farm

  def initialize; end

  def self.create
    new_farm = Farm.new
  end

  # recycling CRM code (KISS principle applied)
  def main_menu
    while true # repeat indefinitely
      show_main_menu
      user_selected = gets.to_i
      farm_options(user_selected)
    end
  end

  def show_main_menu
    puts
    puts "<<<<<<<<<<NEW MENU SESSION>>>>>>>>>>"
    puts "[1] Field"    # adds a new field
    puts "[2] Harvest"  # harvests crops and adds to total harvested
    puts "[3] Status"   # displays some information about the farm
    puts "[4] Relax"    # provides lovely descriptions of your fields
    puts "[5] Exit"     # exits the program
    puts "Enter a number:"
  end

  def farm_options(user_selected)
    case user_selected
    when 1 then add_new_field   # done
    when 2 then harvest_time    # done
    when 3 then status_farm     # done
    when 4 then relax_time      # done
    when 5 then exit_me         # done
    else abort("Wrong answer, exiting the program...")
    end
  end

  def add_new_field
    print "What kind of field is it: melon or watermelon?:"
    puts
    culture = gets.chomp
    puts
    print "How large is the field in hectares?:"
    puts
    area = gets.chomp.to_i
    Field.create(culture, area)
    puts
    puts "Added a #{culture} field of #{area} ha!"
    puts
    puts "Here's an overview of all your fields:"
    puts
    puts Field.all.inspect
    puts
  end

  def harvest_time
    puts
    total_harvest = 0
    Field.all.each do |fields|
      puts "Harvesting #{fields.productivity * fields.area} food from #{fields.area} ha #{fields.culture} field."
      total_harvest += fields.productivity * fields.area
    end
    puts
    puts "The farm has #{total_harvest} harvested food so far."
    puts
  end

  def status_farm
    puts
    total_harvest = 0
    Field.all.each do |fields|
      puts "#{fields.culture.capitalize} field is #{fields.area} ha."
      total_harvest += fields.productivity * fields.area
    end
    puts
    puts "The farm has #{total_harvest} harvested food so far."
    puts
  end

  def relax_time
    if Field.all.empty?
      puts
      puts "No relax for the lazy! Go plow a field you, slob!"
      puts
      exit
    end
    animal_sounds = ["chirping", "tweeting", "squeaking", "barking", "purring"]
    animals = ["mouse", "bobcat", "robin", "hedgehog", "piglet"]
    adverbs = ["menacingly", "frighteningly", "happily", "desperately", "slyly"]
    adjectives = ["hidden", "young", "hungry", "wounded", "dying"]
    Field.all.each do |fields|
      puts "A #{adjectives.sample} #{animals.sample} is #{adverbs.sample} #{animal_sounds.sample} in the #{fields.area} ha sea of #{fields.culture}."
    end
  end

  def exit_me
    abort("No more farm business for me!")
  end

end

class Field

  @@farms_fields = []
  @@productivity_melons = 50
  @@productivity_watermelons = 80
  @@productivity_weeds = 150
  @@productivity_else = 10

  def initialize(culture, area)
    @culture = culture
    @area = area
    case culture
    when "melon" then @productivity = @@productivity_melons
    when "watermelon" then @productivity = @@productivity_watermelons
    when "weed" then @productivity = @@productivity_weeds
    else @productivity = @@productivity_else
    end
  end

  def self.create(culture, area)
    new_field = Field.new(culture, area)
    @@farms_fields << new_field
    return new_field
  end

  def culture
    return @culture
  end

  def area
    return @area
  end

  def productivity
    return @productivity
  end

  def self.all
    return @@farms_fields
  end

end

farm = Farm.create
farm.main_menu
