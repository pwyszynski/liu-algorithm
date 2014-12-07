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

def markAndDeleteFinished(tasklist)
	len = tasklist.length
	for i in (0...len) do
		if (tasklist[i].progress==tasklist[i].time)
			tasklist[i].finished=true
		end
	end
	tasklist.delete_if { |task| task.finished==true }
end

def earliestDeadline(tasklist)
	earliestDeadlineIndex = 0
	for i in (0...tasklist.length-1) do
		if (tasklist[i].deadline < tasklist[i+1].deadline)
			if tasklist[i].finished==false
				earliestDeadlineIndex = i
			end
		end
	end
	return earliestDeadlineIndex
end

#MAIN
tasks = Array.new
arrived = Array.new
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
#(:index, :time, :progress, :arrival, :deadline, :aet, :finished)
tasks.push(Task.new(1, 1, 0, 0, 2, 0, false))
tasks.push(Task.new(2, 2, 0, 0, 5, 0, false))
tasks.push(Task.new(3, 2, 0, 2, 4, 0, false))
tasks.push(Task.new(4, 2, 0, 3, 10, 0, false))
tasks.push(Task.new(5, 2, 0, 6, 9, 0, false))


#Liu(tasks)
totaltime = sum_time(tasks)
len = tasks.length
earliest_deadline_index = 0

# i = jednostka czasu, w ktorej jestesmy
for i in (0...totaltime) do
	# przebiegam cala petle w celu sprawdzenia które zadania właśnie doszły do systemu
	for j in (0...len) do
		# jeżeli arrival = currentTime to spushuj to zadanie do tablicy arrived
		if (tasks[j].arrival == i)
			arrived.push(tasks[j])
		end
	end

	earliest_deadline_index = earliestDeadline(arrived)

	arrived[earliest_deadline_index].progress+=1

	arrived[earliest_deadline_index].print_task_and_progress

	markAndDeleteFinished(arrived)
end


