#!/bin/env ruby
# encoding: utf-8
#wmoimsercutylkoRuby (͡°͜ʖ͡°)

class Task <
  Struct.new(:index, :time, :progress, :arrival, :deadline, :aet, :finished)
  #aet - actual end time

  def print_task
		puts "I=#{index}\t | T=#{time}\t | P=#{progress}\t | A=#{arrival}\t | D=#{deadline}\t | AET=#{aet}\t | F=#{finished}"
	end

	def print_task_and_progress
		puts "Zad.#{index}\t | #{progress}/#{time}\t |"
	end
end

def sum_time(tasklist)
	len = tasklist.length
	time = 0
	for i in (0...len) do
		time += tasklist[i].time
	end
	return time
end

def markFinished(tasklist)
	len = tasklist.length
	for i in (0...len) do
		if (tasklist[i].progress==tasklist[i].time)
			tasklist[i].finished=true
		end
	end
end


def Liu(tasklist)
	totaltime = sum_time(tasklist)
	len = tasklist.length
	arrived = Array.new

	# i = jednostka czasu, w ktorej jestesmy
	for i in (0...totaltime) do
		# przebiegam cala petle w celu sprawdzenia które zadania właśnie doszły do systemu
		for j in (0...len) do
			# jeżeli arrival = currentTime to spushuj to zadanie do tablicy arrived
			if tasklist[j].arrival = i
				arrived.push(tasklist[j])
			end
		end

		earliest_deadline_index = 0

		#wyszukiwanie najwcześniejszego deadline'u wśród tych, które dotarły
		for k in (0...arrived.length) do
			if (arrived[k].deadline<arrived[earliest_deadline_index].deadline && arrived[k].finished==false)
				earliest_deadline_index = k
			end
		end

		arrived[earliest_deadline_index].progress+=1
		arrived[earliest_deadline_index].aet=i

		arrived[earliest_deadline_index].print_task

		markFinished(arrived)
	end
end


#MAIN
tasks = Array.new
# puts "Podaj liczbę zadań:"
# n = gets.chomp.to_i

# for i in (0...n) do
# 	z = Node.new
# 	p "#{i}. indeks: "
# 	z.index = gets.chomp
# 	p "#{i}. długość: "
# 	z.time = gets.chomp.to_i
# 	p "#{i}. czas przybycia: "
#   z.progress = 0
# 	z.arrival = gets.chomp.to_i
# 	p "#{i}. deadline: "
# 	z.deadline = gets.chomp.to_i
# 	z.aet = 0
# 	z.finished = false

# 	tasks.push(z)
# end

tasks.push(Task.new(1, 2, 0, 0, 2, 0, false))
tasks.push(Task.new(2, 2, 0, 0, 3, 0, false))
tasks.push(Task.new(3, 3, 0, 1, 1, 0, false))
tasks.push(Task.new(4, 1, 0, 2, 4, 0, false))
tasks.push(Task.new(5, 2, 0, 3, 5, 0, false))
tasks.push(Task.new(6, 2, 0, 3, 5, 0, false))

Liu(tasks)
