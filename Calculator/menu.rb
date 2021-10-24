require_relative "operations"
#require_relative "../extra_operations"

module Calculator 
    class Menu
        def newGame
            puts '|----------------------------------'
            print "| Qual o seu nome? > "
            user = gets.chomp
            puts '|----------------------------------'
            puts '|----------------------------------|'
            puts "| Hello #{user}. Let's play a game |"
            loop do
                puts '|----------------------------------|'
                # Opções Disponíveis
                puts '| 1 - Média Preconceituosa'
                puts '| 2 - Calculadora sem números(25)'
                puts '| 3 - Filtro de Filmes'
                puts '| 4 - Game Over'
                puts '|------------------------------------'
                print '| > '
                game = gets.chomp.to_i
                case game
                when 1
                    print '| Digite os alunos e as notas (''Aluno1 Nota1 ...''): '
                    grades = gets.chomp.to_s
                    print '| Digite a Blacklist: '
                    blacklist = gets.chomp.to_s
                    system("clear") || system("cls")
                    print "| A média dos alunos é: "
                    puts " #{Calculator::Operations.new.biased_mean(grades, blacklist)}"
                when 2
                    print  '| Digite os números (''a1 a2 ... an''): '
                    numbers = gets.chomp.to_s
                    system("clear") || system("cls")
                    puts "| Resultado: #{Calculator::Operations.new.no_integers(numbers)}"
                when 3
                    print '| Digite os genêros dos filmes (''gen(1) gen(2)... gen(n)''): '
                    genres = gets.chomp.to_s
                    print '| Digite a partir de que ano você deseja filtrar: '
                    year = gets.chomp.to_i
                    system("clear") || system("cls")
                    puts '| Filmes'
                    puts Calculator::Operations.new.filter_films(genres, year)
                when 4
                    system("clear") || system("cls")
                    puts '| Fim de jogo'  
                    break
                end
            end
        end
    end
end