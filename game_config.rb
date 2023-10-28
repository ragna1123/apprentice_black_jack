# frozen_string_literal: true

require './user'

# 初期設定
class Config
  attr_reader :cpu_array

  def initialize
    @cpu_array = []
    select_cpu_players
  end

  def select_cpu_players
    player_num = -1
    until player_num >= 0 && player_num <= 4
      puts '遊ぶ人数を対戦人数を入力(0〜4人):'
      player_num = gets.chomp.to_i
    end
    player_num.times do |n|
      @cpu_array << Cpu.new("playler#{n + 1}")
    end
  end
end
