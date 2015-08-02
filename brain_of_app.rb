class Assigner
    attr :full_cast

    def initialize(slot_count, writers, directors, actors)
        @slot_count = slot_count
        @writers = writers
        @directors = directors
        @actors = actors
        @full_cast = []
        @bad_pairings = {
           "Nathan Boese" => "Tanise Robnett",
            "Vinny Greco" => "Rachel Blomstrom"
        }
    end

    def run
        make_shows(@slot_count)
        writer_split
        director_split
        actor_split
        check_and_move
    end

    def make_shows(count)
        count.times do
            @full_cast << []
        end
    end

    def writer_split
        @writers.shuffle!
        @full_cast.each do |show|
            show << @writers.shift
        end
    end

    def director_split
        @directors.shuffle!
        @full_cast.each do |show|
            show << @directors.shift
        end
    end

    def actor_split
        @actors.shuffle!
        cur_index = 0
        last_index = (@slot_count - 1)
        until @actors.empty?
            @full_cast[cur_index] << @actors.shift
            unless cur_index == last_index
                cur_index += 1
            else
                cur_index = 0
            end
        end
    end

    def check_and_move
      @full_cast.each do |show_cast|
        for key, value in @bad_pairings do
            if show_cast.include?(key) && show_cast.include?(value)
                first_person = key
                second_person = value
                    if show_cast.index(first_person) > show_cast.index(second_person)
                        last_index = show_cast.index(first_person)
                    else
                        last_index = show_cast.index(second_person)
                    end
                to_be_moved = show_cast.slice!(last_index)
                destination_cast = (@full_cast.index(show_cast) - 1)
                @full_cast[destination_cast].insert(last_index, to_be_moved)
                    if @full_cast[destination_cast][last_index+1]
                        switching = @full_cast[destination_cast].slice!((last_index+1))
                        @full_cast[destination_cast+1].insert(last_index, switching)
                    end
                end
            end
        end
    end
end