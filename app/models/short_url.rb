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
    # 1. if blank, error out
    # 2. create a regex that checks for an alphanumeric pattern ends with anywhere from 1-5 characters and ignores both capitalization and whitespace patterns
    # 3. compare regex with full_url, return true if it matches, otherwise it's false
    # 4. errors out if "invalid" full_url

    if(self.full_url.blank?) 
      errors.add(:full_url, "can't be blank") if self.full_url.blank?
    else 
      url_regexp = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
      valid = self.full_url =~ url_regexp ? true : false

      valid ? valid : errors.add(:full_url, "is not a valid url")
    end
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
