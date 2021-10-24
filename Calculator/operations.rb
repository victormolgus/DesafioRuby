require 'json'
require 'net/http'

module Calculator
    class Operations
        def biased_mean(grades, blacklist)
            cont = 1
            mean = 0
            ar_grades = []
            for i in grades.split 
                if cont%2 != 0
                    n_grades = i.insert(0, '"')
                    n_grades = i.insert(i.size, '":')
                    ar_grades.push(n_grades)
                elsif cont < grades.split.size - 1 
                    n_grades = i.insert(i.size,', ')
                    ar_grades.push(n_grades)
                else
                    ar_grades.push(i)
                end
                cont = cont + 1 
            end
            grades = ar_grades.join
            grades = grades.insert(0, '{')
            grades = grades.insert(grades.size, '}')
            #-----------------------------------------
            h_grades = JSON.parse(grades)
            h_grades.each do |key, value| 
                for i in blacklist.split
                    if key == i
                        h_grades.delete(key)
                    end
                end
            end
            h_grades.each do |key, value| 
                mean = mean + value
            end
            if h_grades.length == 0
                return 0
            else 
                return mean/h_grades.length
            end
        end
        #-----------------------------
        def no_integers(numbers)
            res = []
            for i in numbers.split
                if i[i.size-2..i.size-1].include?"25" or i[i.size-2..i.size-1].include?"00" or i[i.size-2..i.size-1].include?"75"
                    res.push('S')
                else 
                    res.push('N')
                end
            end
            return  res.join(" ")
        end 
        def filter_films(genres, year)
            films = movie_list
            cont = 0
            res = []
            #puts films.fetch(:genres)
            films[:"movies"].size.times do
                #puts films[:"movies"][cont][:"genres"]
                for i in genres.split 
                    if films[:"movies"][cont][:"genres"].include?(i) && films[:"movies"][cont][:"year"].to_i  >= year
                        res.push(films[:"movies"][cont][:"title"])
                    end
                end
                cont = cont + 1
            end
            # puts res
            return res
            #puts films[:"movies"][0][:"genres"]
            #teste.each do |key, value|
            #    puts value
            #end
        end

        private 
        def movie_list
            url = 'https://raw.githubusercontent.com/yegor-sytnyk/movies-list/master/db.json'
            uri = URI(url)
            response = Net::HTTP.get(uri)
            return JSON.parse(response, symbolize_names: true)
        end
    end
end