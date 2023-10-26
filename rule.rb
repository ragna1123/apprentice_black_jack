class Rule
  # バースト判定
  def burst?(score)
    return unless score > 21

    true
  end

  def burst_message
    puts 'バーストしました'
  end
end
