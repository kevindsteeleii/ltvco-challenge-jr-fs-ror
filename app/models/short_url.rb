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
    # 1. decode shortened code -> id, use id to fetch short_url
    # 2. create/invoke helper method #self.decoder_hash that inverts the mapping from #short_code by creating a hash w/ key-value pairs of base62_digit and it's index in CHARACTERS array and memoizes it...
      # 2a. see private method #self.decoder_hash
    # 3. create/invoke helper method that does the conversion of short_code back to id, returns the id see method #self.convert_short_code_to_id
    # 4. use returned instance_id to look up corresponding short_url
    # 5. error handling TBD...
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
    # 3a. make a variable with a value of 0 (base10), called instance_id
    # 3b. revert short_code back to its array of base62 digits, taking care to reverse it as well since originally it was in descending not ascending order...
    # 3c. iterate through array of base62 digits, making sure to have the current index available in the block
    # 3d. per loop increment variable instance_id by the following formula: 62**index * decoding_hash_value_at_address_base62_digit
    # 3e. it follows the same logic as this base10 example: 104 => 10**2 * 1 + 10**1 * 0 + 10**0 * 4, no need to use parens PEMDAS!!!
    instance_id = 0
    split_short_code = short_code.split("").reverse

    split_short_code.each_with_index do |value, index| 
      current_digit = 62**index * self.decoder_hash[value]
      instance_id += current_digit
    end

    instance_id
  end

end
