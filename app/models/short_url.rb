class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    if self.id.present? 
      converted_id_array = self.id.digits(62) # convert id from base10 to base62
      converted_id_array.map{ |digit| CHARACTERS[digit] }.reverse.join 
    end
  end

  def update_title!
  end

  def self.find_by_short_code(short_code) 
    instance_id = self.convert_short_code_to_id(short_code)
    ShortUrl.find(instance_id)
  end

  private

  def validate_full_url
  end

  def self.decoder_hash 
    @decoder_hash ||= CHARACTERS.each_with_index.map { |value, index| [value, index] }.to_h
  end

  def self.convert_short_code_to_id(short_code) 
    instance_id = 0
    split_short_code = short_code.split("").reverse

    split_short_code.each_with_index do |value, index| 
      current_digit = 62**index * self.decoder_hash[value]
      instance_id += current_digit
    end

    instance_id
  end

end
