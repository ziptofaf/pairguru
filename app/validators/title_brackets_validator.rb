class TitleBracketsValidator < ActiveModel::Validator
  ERROR_MESSAGE  = "This record has wrong brackets".freeze

  def validate(record)
    characters_map = { "(" => ")", "{" => "}", "[" => "]" }
    characters_map_inv = characters_map.invert
    brackets_arr = []
    record.title.split('').each do |c|
      brackets_arr.push(c) && next if characters_map[c]

      if characters_map_inv[c]
        corresponding_start_bracket = brackets_arr.pop
        if corresponding_start_bracket != characters_map_inv[c]
          record.errors.add(:title, ERROR_MESSAGE)
          return
        end
      end
    end
    record.errors.add(:title, ERROR_MESSAGE) if brackets_arr.count.positive? || empty_brackets?(record)

  end

  def empty_brackets?(record)
    emptiness_regexes = [/\(\)/, /\[\]/, /\{\}/]
    emptiness_regexes.each do |regex|
      return true if record.title.match?(regex)
    end
    false
  end

end