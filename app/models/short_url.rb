class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    # generate short code using "CHARACTERS" array
    # 1. check to see if there's an id/ object's been saved...
    # 2. using the non-repeating, unique attribute id (INTEGER) of each short_url, convert from base10 to base62
    # 3. iterate and map through the array of base62 converted "digits" mapping each one to corresponding character from "CHARACTERS" array matching the base62 digit with the character at the same index
    # 4. join array as a string, urls can't be enumerables/arrays...
    if self.id.present? 
      converted_id_array = self.id.digits(62) # convert id from base10 to base62
      converted_id_array.map{ |digit| CHARACTERS[digit] }.reverse.join 
    end
  end

  def update_title!
  end

  private

  def validate_full_url
  end

end
